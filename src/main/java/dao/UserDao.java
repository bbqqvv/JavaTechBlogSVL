package dao;

import entities.User;
import helper.ConnectionProvider;

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
        boolean f = false;
        String query = "insert into user(user_name,email,password,gender,about) values (?,?,?,?,?)";

        try (PreparedStatement pstmt = this.con.prepareStatement(query)) {
            pstmt.setString(1, user.getUser_name());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            f = true;
        } catch (SQLException e) {
            // Use a proper logging framework instead of printStackTrace
            e.printStackTrace();  // Replace with logger.error("Error in saveUser", e);
        }
        return f;
    }

    // Get user by email and password
    public User getUserByUsernameAndPassword(String email, String password) {
        User user = null;
        String query = "select * from user where email=? and password=?";

        try (PreparedStatement pstmt = this.con.prepareStatement(query)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User(rs.getString("user_name"), rs.getString("email"),
                            rs.getString("password"), rs.getString("gender"), rs.getString("about"), rs.getString("profile"));
                }
            }
        } catch (SQLException e) {
            // Log the exception properly
            e.printStackTrace();  // Replace with logger.error("Error in getUserByUsernameAndPassword", e);
        }
        return user;
    }

    // Update user profile
    public static boolean updateUser(User user) {
        boolean rowUpdated = false;
        String sql = "UPDATE user SET user_name = ?, email = ?, gender = ?, about = ? , profile = ? WHERE id = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUser_name());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getGender());
            stmt.setString(4, user.getAbout());
            stmt.setString(5, user.getProfile()); // Thêm profile
            stmt.setInt(6, user.getId());  // Đúng chỉ số cho id


            rowUpdated = stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rowUpdated;
    }


}
