<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .card { border-radius: 20px; }
        #loader { display: none; }
    </style>
    <%@include file="links.jsp"%>

</head>
<body>
<%@include file="normal_navbar.jsp"%>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title text-center mb-4">Register</h4>
                    <form id="reg-form">
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="gender" class="form-label">Gender</label>
                            <select class="form-select" id="gender" name="gender" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="about" class="form-label">About</label>
                            <textarea class="form-control" id="about" name="about" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="check" name="check" required>
                            <label class="form-check-label" for="check">I agree to the terms and conditions</label>
                        </div>
                        <button type="submit" id="submit-btn" class="btn btn-primary w-100">Submit</button>
                        <img id="loader" src="loader.gif" class="mx-auto d-block mt-3" alt="Loading..." style="width: 50px; display: none">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $('#reg-form').on('submit', function(event) {
        event.preventDefault(); // Ngăn không cho form gửi đi bình thường

        let form = new FormData(this); // Tạo đối tượng FormData chứa dữ liệu form
        $("#submit-btn").hide(); // Ẩn nút submit
        $("#loader").show(); // Hiển thị ảnh load

        $.ajax({
            url: "http://localhost:8000/TechBlog_war/Register",
            type: 'POST',
            data: form,
            contentType: false, // Không đặt header mặc định
            processData: false, // Không xử lý dữ liệu
            success: function(data) {
                if (data.trim() == 'User saved successfully') {
                    Swal.fire({
                        icon: "success",
                        title: "Your registration was successful!",
                        timer: 1500
                    }).then(() => {
                        window.location.href = "login_page.jsp"; // Chuyển đến trang đăng nhập
                    });
                } else {
                    Swal.fire(data); // Hiển thị thông báo lỗi
                }
            },
            error: function() {
                Swal.fire({
                    icon: "error",
                    title: "Registration failed! Please try again."
                });
            }
        });
    });
</script>
<%@include file="links.jsp"%>

</body>
</html>
