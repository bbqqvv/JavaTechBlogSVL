<%@include file="links.jsp"%>
<%
    // Lấy thông tin user từ session
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login_page.jsp");
        return; // Dừng thực hiện phần còn lại của trang nếu chưa đăng nhập
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="fa-brands fa-wordpress"></i> Tech Blog</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#"><i class="fa-regular fa-bell"></i> LearnCode with Van</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-list"></i> Categories
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Programming Language</a></li>
                        <li><a class="dropdown-item" href="#">Project Implementation</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Data Structure</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fa-regular fa-address-card"></i> Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal">
                        <img src="path/to/your/image.png" alt="Create Post Icon" style="width: 16px; height: 16px;"> Create Post
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
                    <a class="nav-link" href="LogoutServlet"> <span class="fa fa-user-plus"></span> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header primary-background text-white text-center">
                <h5 class="modal-title" id="exampleModalLabel"> TechBlog </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container text-center">
                    <img src="pics/<%= currentUser.getProfile() %>" class="img-fluid" style="border-radius:50%;max-width: 150px;" >
                    <br>
                    <h5 class="modal-title mt-3" id="exampleModalLabel"> <%= currentUser.getUser_name() %> </h5>
                    <div id="profile-details">
                        <table class="table">
                            <tbody>
                            <tr>
                                <th scope="row">ID:</th>
                                <td><%= currentUser.getId() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Email:</th>
                                <td><%= currentUser.getEmail() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Gender:</th>
                                <td><%= currentUser.getGender() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Status:</th>
                                <td><%= currentUser.getAbout() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Registered on:</th>
                                <td><%= (currentUser.getDate() != null) ? currentUser.getDate().toString() : "N/A" %></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div id="profile-edit" style="display: none;">
                        <h3 class="mt-2">Please Edit Carefully</h3>
                        <form action="EditServlet" method="post" enctype="multipart/form-data">
                            <table class="table">
                                <tr>
                                    <td>ID:</td>
                                    <td><%= currentUser.getId() %></td>
                                </tr>
                                <tr>
                                    <td>Email:</td>
                                    <td><input type="email" class="form-control" name="user_email" value="<%= currentUser.getEmail() %>"></td>
                                </tr>
                                <tr>
                                    <td>Name:</td>
                                    <td><input type="text" class="form-control" name="user_name" value="<%= currentUser.getUser_name() %>"></td>
                                </tr>
                                <tr>
                                    <td>Password:</td>
                                    <td><input type="password" class="form-control" name="user_password" value="<%= currentUser.getPassword() %>"></td>
                                </tr>
                                <tr>
                                    <td>Gender:</td>
                                    <td><%= currentUser.getGender().toUpperCase() %></td>
                                </tr>
                                <tr>
                                    <td>About:</td>
                                    <td><textarea rows="3" class="form-control" name="user_about"><%= currentUser.getAbout() %></textarea></td>
                                </tr>
                                <tr>
                                    <td>New Profile:</td>
                                    <td><input type="file" name="image" class="form-control"></td>
                                </tr>
                            </table>
                            <div class="container">
                                <button type="submit" class="btn btn-outline-primary">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        let editStatus = false;
        const editButton = document.getElementById('edit-profile-button');
        const profileDetails = document.getElementById('profile-details');
        const profileEdit = document.getElementById('profile-edit');

        editButton.addEventListener('click', function() {
            if (!editStatus) {
                profileDetails.style.display = 'none';
                profileEdit.style.display = 'block';
                editButton.textContent = 'Back';
            } else {
                profileDetails.style.display = 'block';
                profileEdit.style.display = 'none';
                editButton.textContent = 'Edit';
            }
            editStatus = !editStatus;
        });
    });
</script>
