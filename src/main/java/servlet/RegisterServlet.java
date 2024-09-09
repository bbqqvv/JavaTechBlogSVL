package servlet;

import dao.UserDao;
import entities.User;
import helper.ConnectionProvider;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
@MultipartConfig
@WebServlet("/Register")

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String gender = req.getParameter("gender");
        String about = req.getParameter("about");
        String profile = req.getParameter("profile");

        String check = req.getParameter("check");


        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        if (check == null) {

            out.println("BOX NOT CHECKED");
        }else{
            User user = new User(name, email, password, gender, about, profile);
             UserDao dao = new UserDao(ConnectionProvider.getConnection());
            if(dao.saveUser(user) == true){
                out.println("User saved successfully");
            }else {
                out.println("Failed to save user");
            }
        }


        out.println("<h1>Registration Successful</h1>");
        out.println(String.format(
                "Name is: %s" +
                        "Email is: %s" +
                        "Password is: %s" +
                        "Gender is: %s" +
                        "About is: %s", name, email, password, gender, about));
    }
}
