package servlet;

import dao.PostDao;
import entities.Post;
import entities.User;
import helper.ConnectionProvider;
import helper.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Get parameters from the form
            int cid = Integer.parseInt(request.getParameter("cid"));
            String pTitle = request.getParameter("pTitle");
            String pContent = request.getParameter("pContent");
            String pCode = request.getParameter("pCode");
            Part part = request.getPart("pic"); // image file

            // Get current user from session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");

            // Old image (if exists)
            String oldFile = user.getProfile();  // Assuming this holds the old image name

            // Create post entity
            Post post = new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), null, cid, user.getId());

            // Insert post into the database
            PostDao dao = new PostDao(ConnectionProvider.getConnection());
            if (dao.savePost(post)) {
                // Define the directory to save the image
                String uploadDir = request.getServletContext().getRealPath("/") + "img" + File.separator;

                // Print the upload directory for debugging
                System.out.println("Upload directory: " + uploadDir);

                // Save the new image
                String newImageName = part.getSubmittedFileName();
                if (Helper.saveFile(part.getInputStream(), uploadDir + newImageName)) {
                    // Print success message
                    System.out.println("Image saved successfully at: " + uploadDir + newImageName);

                    // Verify if the file exists
                    File savedFile = new File(uploadDir + newImageName);
                    if (savedFile.exists()) {
                        System.out.println("File exists: " + savedFile.getAbsolutePath());
                    } else {
                        System.out.println("File does not exist after saving!");
                    }

                    // If the old image is not the default, delete the old image
                    if (!oldFile.equals("default.png") && oldFile != null) {
                        Helper.deleteFile(uploadDir + oldFile);
                        System.out.println("Old image deleted: " + oldFile);
                    }

                    // Update user's profile image
                    user.setProfile(newImageName);
                    session.setAttribute("currentUser", user);

                    out.println("Post and image saved successfully!");
                } else {
                    System.out.println("Failed to save image.");
                    out.println("Post saved, but failed to save image.");
                }

                // Send success response
                response.getWriter().write("Post added successfully!");
            } else {
                System.out.println("Failed to add post.");
                out.println("Error adding post.");
                response.getWriter().write("Failed to add post.");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for adding posts and uploading images";
    }
}
