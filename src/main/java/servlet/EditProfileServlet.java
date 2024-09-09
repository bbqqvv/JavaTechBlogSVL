package servlet;

import dao.UserDao;
import entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Nhận dữ liệu từ form
        String userId = request.getParameter("id");
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String about = request.getParameter("about");
        String profile = request.getParameter("profile");


        // Cập nhật thông tin người dùng trong cơ sở dữ liệu
        User updatedUser = new User(userId, userName, email, gender, about, profile);
        boolean isUpdated = UserDao.updateUser(updatedUser);

        // Trả về kết quả dưới dạng JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (isUpdated) {
            out.print("{\"status\":\"success\"}");
        } else {
            out.print("{\"status\":\"error\"}");
        }
        out.flush();
    }
}
