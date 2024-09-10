package servlet;

import dao.UserDao;
import entities.Message;
import entities.User;
import helper.ConnectionProvider;
import helper.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve user from session
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        // Retrieve parameters from the request
        String userName = req.getParameter("user_name");
        String email = req.getParameter("user_email");
        String password = req.getParameter("user_password");  // Fixed password field
        String gender = req.getParameter("user_gender");
        String about = req.getParameter("user_about");
        Part part = req.getPart("image");
        String imageName = part.getSubmittedFileName();

        // Update current user information
        currentUser.setEmail(email);
        currentUser.setUser_name(userName);
        currentUser.setPassword(password);
        currentUser.setAbout(about);
        currentUser.setGender(gender);

        String oldFile = currentUser.getProfile();
        currentUser.setProfile(imageName);

        // Update user in the database
        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
        boolean isUpdated = userDao.updateUser(currentUser);

        if (isUpdated) {
            // Define paths for saving new image and deleting old image
            String uploadDir = req.getServletContext().getRealPath("/") + "img" + File.separator;
            String newImagePath = uploadDir + currentUser.getProfile();
            String oldImagePath = uploadDir + oldFile;

            // If old image is not the default, delete it
            if (!oldFile.equals("default.png")) {
                Helper.deleteFile(oldImagePath);
            }

            // Save the new image
            if (Helper.saveFile(part.getInputStream(), newImagePath)) {
                Message msg = new Message("Profile details updated...", "success", "alert-success");
                session.setAttribute("msg", msg);
            } else {
                Message msg = new Message("Error while saving profile image.", "error", "alert-danger");
                session.setAttribute("msg", msg);
            }
        } else {
            Message msg = new Message("Failed to update profile details.", "error", "alert-danger");
            session.setAttribute("msg", msg);
        }

        // Redirect to profile page
        resp.sendRedirect("profile.jsp");
    }
}
