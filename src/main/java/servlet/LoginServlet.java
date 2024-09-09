package servlet;

import dao.UserDao;
import entities.User;
import helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy thông tin đăng nhập từ form
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Tạo đối tượng UserDao để truy vấn cơ sở dữ liệu
        UserDao dao = new UserDao(ConnectionProvider.getConnection());

        // Gọi phương thức để lấy thông tin người dùng từ cơ sở dữ liệu
        User u = dao.getUserByUsernameAndPassword(email, password);

        if (u == null) {
            // Đăng nhập thất bại, thông báo lỗi và chuyển hướng về lại trang đăng nhập
            HttpSession session = req.getSession();
            session.setAttribute("error", "Invalid email or password.");
            resp.sendRedirect("login_page.jsp"); // Chuyển hướng về trang đăng nhập

            // Ghi lại thông báo trong console khi đăng nhập thất bại
            System.out.println("Login failed for email: " + email);
        } else {
            // Đăng nhập thành công, lưu thông tin người dùng trong session và chuyển hướng tới trang chủ
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", u);
            resp.sendRedirect("profile.jsp"); // Chuyển hướng về trang chủ

            // Ghi lại thông báo trong console khi đăng nhập thành công
            System.out.println("Login successful for email: " + email);
        }
    }
}
