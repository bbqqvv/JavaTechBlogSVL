<%@ page import="entities.Category, entities.User" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.PostDao" %>
<%@ page import="helper.ConnectionProvider" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="links.jsp" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login_page.jsp");
        return;
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="fa-brands fa-wordpress"></i> Tech Blog</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#"><i class="fa-regular fa-bell"></i> LearnCode with Van</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="fa-solid fa-list"></i> Categories
                    </a>
                    <ul class="dropdown-menu">
                        <!-- Display categories dynamically -->
                        <c:forEach var="category" items="${categories}">
                            <li><a class="dropdown-item" href="#">${category.name}</a></li>
                        </c:forEach>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#" id="post" data-bs-toggle="modal" data-bs-target="#add-post-modal">
                        <i class="fa-solid fa-circle-plus"></i> Do Post
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#profile-modal">
                        <span class="fa fa-user-circle"></span> <%= currentUser.getUser_name() %>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out"></span> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Profile Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Profile - TechBlog</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <img src="img/<%= currentUser.getProfile() %>" class="img-fluid rounded-circle" style="max-width: 150px;">
                    <h5 class="mt-3"><%= currentUser.getUser_name() %></h5>
                </div>
                <div id="profile-details">
                    <table class="table">
                        <tr><th>ID:</th><td><%= currentUser.getId() %></td></tr>
                        <tr><th>Email:</th><td><%= currentUser.getEmail() %></td></tr>
                        <tr><th>Gender:</th><td><%= currentUser.getGender() %></td></tr>
                        <tr><th>About:</th><td><%= currentUser.getAbout() %></td></tr>
                    </table>
                </div>
                <div id="profile-edit" style="display:none;">
                    <form action="EditServlet" method="post" enctype="multipart/form-data">
                        <table class="table">
                            <tr><th>ID:</th><td><%= currentUser.getId() %></td></tr>
                            <tr><th>Email:</th><td><input type="email" name="user_email" value="<%= currentUser.getEmail() %>" class="form-control"></td></tr>
                            <tr><th>Password:</th><td><input type="password" name="user_password" class="form-control" value="<%= currentUser.getPassword() %>"></td></tr>
                            <tr>
                                <th>Gender:</th>
                                <td>
                                    <select name="user_gender" class="form-control">
                                        <option value="Male" <%= currentUser.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                                        <option value="Female" <%= currentUser.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                                    </select>
                                </td>
                            </tr>
                            <tr><th>Name:</th><td><input type="text" name="user_name" value="<%= currentUser.getUser_name() %>" class="form-control"></td></tr>
                            <tr><th>About:</th><td><textarea name="user_about" class="form-control"><%= currentUser.getAbout() %></textarea></td></tr>
                            <tr><th>Profile:</th><td><input type="file" name="image" class="form-control"></td></tr>
                        </table>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </form>
                </div>
                <button id="edit-button" class="btn btn-secondary mt-3">Edit</button>
            </div>
        </div>
    </div>
</div>


<!-- POST Modal --><!-- POST Modal -->
<!-- Form HTML -->
<div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="addPostModalLabel" aria-hidden="true">
    <div class="modal-dialog"> <!-- Thay đổi kích thước modal nếu cần -->
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="addPostModalLabel">Provide Post Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Phần tử chứa thông báo được di chuyển lên trên cùng -->
                <div id="message"></div>
                <form id="add-post-form" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="category-select" class="form-label">Category</label>
                        <select id="category-select" class="form-select" name="cid" required>
                            <option value="" selected disabled>---Select Category---</option>
                            <!-- Options sẽ được điền bằng server-side code -->
                            <%
                                PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list = postd.getAllCategories();
                                for (Category c : list) {
                            %>
                            <option value="<%= c.getCid() %>"><%= c.getName() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="post-title" class="form-label">Post Title</label>
                        <input id="post-title" name="pTitle" type="text" class="form-control" placeholder="Enter post Title" required/>
                    </div>
                    <div class="mb-3">
                        <label for="post-content" class="form-label">Post Content</label>
                        <textarea id="post-content" name="pContent" class="form-control" style="height: 200px;" placeholder="Enter your content" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="post-code" class="form-label">Post Code (Optional)</label>
                        <textarea id="post-code" name="pCode" class="form-control" style="height: 200px;" placeholder="Enter your program (if any)"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="post-pic" class="form-label">Select Picture (Optional)</label>
                        <input id="post-pic" type="file" name="pic" class="form-control">
                    </div>
                    <div class="text-center">
                        <button type="button" class="btn btn-primary" onclick="submitForm()">Post</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<style>
    .modal-dialog {
        max-height: 80vh;
        overflow-y: auto;
    }

    /* Tùy chỉnh thêm nếu cần */
    .modal-content {
        height: auto;
    }
</style>

<script>
    document.getElementById('edit-button').addEventListener('click', function () {
        document.getElementById('profile-details').style.display = 'none';
        document.getElementById('profile-edit').style.display = 'block';
    });
</script>

<script>
    function getPosts(catId, temp) {
        $("#loader").show();
        $("#post-container").hide();

        $.ajax({
            url: 'AllPostsServlet',
            type: 'POST',
            data: { catId: catId },
            success: function (data) {
                $("#loader").hide();
                $("#post-container").show();
                $("#post-container").html(data);
                $(".c-link").removeClass('active');
                $(temp).addClass('active');
            },
            error: function () {
                $("#loader").hide();
                $("#post-container").show();
                swal("Error!!", "Something went wrong, try again...", "error");
            }
        });
    }
</script>

<!-- Loader -->
<div id="loader" style="display:none;">
    <div class="container text-center">
        <img src="img/loader.gif" class="img-fluid" alt="Loader"/>
    </div>
</div>



<script>
    function submitForm() {
        var formData = new FormData(document.getElementById('add-post-form'));

        fetch('AddPostServlet', {
            method: 'POST',
            body: formData
        })
            .then(response => response.text()) // Chuyển đổi phản hồi thành văn bản
            .then(data => {
                // Kiểm tra nội dung phản hồi để hiển thị thông báo phù hợp
                if (data === "Post added successfully!") {
                    document.getElementById('message').innerHTML = '<div class="alert alert-success" role="alert">' + data + '</div>';
                } else if (data === "Failed to add post.") {
                    document.getElementById('message').innerHTML = '<div class="alert alert-danger" role="alert">' + data + '</div>';
                } else {
                    document.getElementById('message').innerHTML = '<div class="alert alert-info" role="alert">Unknown response: ' + data + '</div>';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                // Hiển thị thông báo lỗi khi xảy ra lỗi trong quá trình gửi yêu cầu
                document.getElementById('message').innerHTML = '<div class="alert alert-danger" role="alert">An error occurred.</div>';
            });
    }
</script>
