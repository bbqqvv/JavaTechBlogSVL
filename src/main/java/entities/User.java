package entities;

import java.sql.Timestamp;

public class User {
    private int id;
    private String user_name;
    private String email;
    private String password;

    private String gender;
    private String about;

    private String profile;
    private Timestamp date;

    public User(String user_name, String email, String password, String gender, String about, String profile) {
        this.user_name = user_name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.profile = profile;
    }

    public User(int id, String user_name, String email, String password, String gender, String about, String profile) {
        this.id = id;
        this.user_name = user_name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.profile = profile;
    }

    public User() {
    }

    public User(int id, String user_name, String email, String password, String gender, String about, Timestamp date) {
        this.id = id;
        this.user_name = user_name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.date = date;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

}