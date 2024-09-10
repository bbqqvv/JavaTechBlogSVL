package servlet;

import helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class PostServlet  extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form parameters
        String pTitle = request.getParameter("pTitle");
        String pContent = request.getParameter("pContent");
        String pCode = request.getParameter("pCode");
        String catId = request.getParameter("catId");

        // Handle image upload
        Part part = request.getPart("pPic");
        String imageName = part.getSubmittedFileName();

        try {
            // DB connection
            Connection con = ConnectionProvider.getConnection();
            String sql = "INSERT INTO posts(pTitle, pContent, pCode, pPic, catId) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, pTitle);
            pst.setString(2, pContent);
            pst.setString(3, pCode);
            pst.setString(4, imageName);
            pst.setInt(5, Integer.parseInt(catId));

            // Save the image file to the server (optional)
            String path = getServletContext().getRealPath("/") + "img" + java.io.File.separator + imageName;
            InputStream is = part.getInputStream();
            java.nio.file.Files.copy(is, java.nio.file.Paths.get(path));

            // Execute the SQL query
            pst.executeUpdate();
            response.sendRedirect("posts.jsp?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("posts.jsp?error=true");
        }
    }
}
