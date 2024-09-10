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
            int cid = Integer.parseInt(request.getParameter("cid"));
            String pTitle = request.getParameter("pTitle");
            String pContent = request.getParameter("pContent");
            String pCode = request.getParameter("pCode");
            Part part = request.getPart("pic");

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");

            Post p = new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), null, cid, user.getId());
            PostDao dao = new PostDao(ConnectionProvider.getConnection());
            if (dao.savePost(p)) {
                // Get the real path using ServletContext
                String path = getServletContext().getRealPath("/") + "img" + File.separator + part.getSubmittedFileName();
                Helper.saveFile(part.getInputStream(), path);

                response.getWriter().write("Post added successfully!");

            } else {
                response.getWriter().write("Failed to add post.");

                out.println("error");
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
        return "Short description";
    }
}
