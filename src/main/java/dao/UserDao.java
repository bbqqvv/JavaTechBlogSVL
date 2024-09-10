package dao;

import entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    // Save user to the database
    public boolean saveUser(User user) {
        boolean isSaved = false;
        String query = "INSERT INTO user(user_name, email, password, gender, about) VALUES (?,?,?,?,?)";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, user.getUser_name());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            isSaved = true;
        } catch (SQLException e) {
            e.printStackTrace(); // Replace with logging
        }

        return isSaved;
    }

    // Retrieve user by email and password
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        String query = "SELECT * FROM user WHERE email=? AND password=?";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User(
                            rs.getInt("id"),
                            rs.getString("user_name"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("gender"),
                            rs.getString("about"),
                            rs.getString("profile")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Replace with logging
        }

        return user;
    }

    // Update user profile
    public boolean updateUser(User user) {
        boolean isUpdated = false;
        String query = "UPDATE user SET user_name=?, email=?, password=?, gender=?, about=?, profile=? WHERE id=?";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, user.getUser_name());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.setString(6, user.getProfile());
            pstmt.setInt(7, user.getId()); // Đảm bảo rằng user.getId() trả về giá trị chính xác

            // Log query và tham số
            System.out.println("SQL Query: " + query);
            System.out.println("Parameters: " +
                    "user_name=" + user.getUser_name() + ", " +
                    "email=" + user.getEmail() + ", " +
                    "password=" + user.getPassword() + ", " +
                    "gender=" + user.getGender() + ", " +
                    "about=" + user.getAbout() + ", " +
                    "profile=" + user.getProfile() + ", " +
                    "id=" + user.getId());

            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Log số hàng bị ảnh hưởng
            isUpdated = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Thay thế bằng logging nếu cần
        }

        return isUpdated;
    }


}
