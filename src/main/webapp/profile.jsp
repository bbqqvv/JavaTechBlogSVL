<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="helper.ConnectionProvider" %>
<%@ page import="dao.PostDao" %>
<%@ page import="entities.Post" %>

<%
    // Initialize PostDao
    PostDao postDao = new PostDao(ConnectionProvider.getConnection());

    // Get category list from the database
    List<Category> categoryList = postDao.getAllCategories();

    // Get posts based on category ID
    String categoryId = request.getParameter("categoryId");
    List<Post> postList;

    if (categoryId != null) {
        int catId = Integer.parseInt(categoryId);
        postList = postDao.getPostByCatId(catId);  // Fetch posts by category
    } else {
        postList = postDao.getAllPosts();  // Fetch all posts
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Category</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
</head>
<body>
<!-- Include Navbar -->
<%@ include file="navbar_profile.jsp" %>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar - Category List -->
        <div class="col-md-3">
            <h4 class="text-center">Categories</h4>
            <ul class="list-group">
                <% for (Category category : categoryList) { %>
                <li class="list-group-item list-group-item-action" id="category-<%= category.getCid() %>" onclick="loadPosts(<%= category.getCid() %>)" style="cursor: pointer;">
                    <i class="bi bi-folder-fill"></i> <%= category.getName() %>
                </li>
                <% } %>
            </ul>
        </div>

        <!-- Main Content - Post List -->
        <div class="col-md-9">
            <!-- Posts Section -->
            <h4>Posts:</h4>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <% if (postList != null && !postList.isEmpty()) { %>
                <% for (Post post : postList) { %>
                <div class="col">
                    <div class="card h-100">
                        <img src="img/<%= post.getpPic() %>" class="card-img-top" alt="Post Image">
                        <div class="card-body">
                            <h5 class="card-title"><%= post.getpTitle() %></h5>
                            <p class="card-text"><%= post.getpContent().substring(0, Math.min(post.getpContent().length(), 100)) + "..." %></p>
                        </div>
                    </div>
                </div>
                <% } %>
                <% } else { %>
                <div class="col">
                    <p>No posts available for this category.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- Include Footer/Links -->
<%@ include file="links.jsp" %>

</body>
</html>
