package servlet;

import dao.UserDao;
import entities.Message;
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
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDao dao = new UserDao(ConnectionProvider.getConnection());
        User user = dao.getUserByEmailAndPassword(email, password);

        HttpSession session = req.getSession();

        if (user == null) {
            // Login failed
            Message msg = new Message("Invalid email or password.", "danger", "alert-danger");
            session.setAttribute("msg", msg);
            resp.sendRedirect("login_page.jsp");
        } else {
            // Login successful
            session.setAttribute("currentUser", user);
            Message msg = new Message("Login successful!", "success", "alert-success");
            session.setAttribute("msg", msg);
            resp.sendRedirect("profile.jsp");
        }
    }
}
