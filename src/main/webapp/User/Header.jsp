<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="author" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap"
          rel="stylesheet">

    <style>
        /* Profile image style */
        .user-icon img {
            width: 35px;
            height: 35px;
            margin-top: -5px;
            border-radius: 50%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        /* Zoom on hover */
        .user-icon:hover img {
            transform: scale(1.1);
        }

        /* Dropdown menu */
        .profile-dropdown {
            display: none;
            position: absolute;
            top: 60px;
            min-width: 220px;
            right: 0;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 10px;
            width: 160px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        /* Menu items */
        .profile-dropdown a {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            transition: background 0.3s;
        }

        .profile-dropdown a:hover {
            background-color: #f0f0f0;
        }

        .custom-small-modal {
            max-width: 700px;
        }

        .modal-content {
            padding: 10px 20px;
        }
        .profile-dropdown.show {
            display: block !important;
        }

    </style>
</head>
<body>

<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
    <!-- SVG Icon Definitions -->
    <symbol id="search" viewBox="0 0 24 24">
        <path fill="currentColor" fill-rule="evenodd"
              d="M11.5 2.75a8.75 8.75 0 1 0 0 17.5a8.75 8.75 0 0 0 0-17.5M1.25 11.5c0-5.66 4.59-10.25 10.25-10.25S21.75 5.84 21.75 11.5c0 2.56-.939 4.902-2.491 6.698l3.271 3.272a.75.75 0 1 1-1.06 1.06l-3.272-3.271A10.21 10.21 0 0 1 11.5 21.75c-5.66 0-10.25-4.59-10.25-10.25"
              clip-rule="evenodd"/>
    </symbol>
    <symbol id="user" viewBox="0 0 24 24">
        <path fill="currentColor" fill-rule="evenodd"
              d="M12 1.25a4.75 4.75 0 1 0 0 9.5a4.75 4.75 0 0 0 0-9.5M8.75 6a3.25 3.25 0 1 1 6.5 0a3.25 3.25 0 0 1-6.5 0M12 12.25c-2.313 0-4.445.526-6.024 1.414C4.42 14.54 3.25 15.866 3.25 17.5v.102c-.001 1.162-.002 2.62 1.277 3.662c.629.512 1.51.877 2.7 1.117c1.192.242 2.747.369 4.773.369s3.58-.127 4.774-.369c1.19-.24 2.07-.605 2.7-1.117c1.279-1.042 1.277-2.5 1.276-3.662V17.5c0-1.634-1.17-2.96-2.725-3.836c-1.58-.888-3.711-1.414-6.025-1.414M4.75 17.5c0-.851.622-1.775 1.961-2.528c1.316-.74 3.184-1.222 5.29-1.222c2.104 0 3.972.482 5.288 1.222c1.34.753 1.961 1.677 1.961 2.528c0 1.308-.04 2.044-.724 2.6c-.37.302-.99.597-2.05.811c-1.057.214-2.502.339-4.476.339c-1.974 0-3.42-.125-4.476-.339c-1.06-.214-1.68-.509-2.05-.81c-.684-.557-.724-1.293-.724-2.601"
              clip-rule="evenodd"/>
    </symbol>
    <!-- Add other required SVG symbols here -->
</svg>

<div class="search-popup">
    <div class="search-popup-container">

        <form role="search" method="get" class="search-form" action="SearchBooks.jsp">
            <input type="search" id="search-form" class="search-field"
                   placeholder="Search by title or author"
                   value="<%= request.getParameter("s") != null ? request.getParameter("s") : "" %>"
                   name="s"/>
            <button type="submit" class="search-submit">
                <svg class="search">
                    <use xlink:href="#search"></use>
                </svg>
            </button>
        </form>

        <h5 class="cat-list-title">Browse Categories</h5>
        <ul class="cat-list">
            <li class="cat-list-item">
                <a href="CategoryBooks.jsp?category=History">History</a>
            </li>
            <li class="cat-list-item">
                <a href="CategoryBooks.jsp?category=Novels">Novels</a>
            </li>
            <li class="cat-list-item">
                <a href="CategoryBooks.jsp?category=Romance" title="Romance">Romance</a>
            </li>
            <li class="cat-list-item">
                <a href="CategoryBooks.jsp?category=Horror">Horror</a>
            </li>
            <li class="cat-list-item">
                <a href="CategoryBooks.jsp?category=Mystery">Mystery</a>
            </li>
            <li class="cat-list-item">
                <a href="CategoryBooks.jsp?category=Children">Children</a>
            </li>
            <li class="cat-list-item">
                <a href="CategoryBooks.jsp?category=Dystopian">Dystopian</a>
            </li>
            <li class="cat-list-item">
                <a href="CategoryBooks.jsp?category=Mythology">Mythology</a>
            </li>
        </ul>

    </div>
</div>

<header id="header" class="site-header">

    <nav id="header-nav" class="navbar navbar-expand-lg py-3">
        <div class="container">
            <a class="navbar-brand" href="">
                <img src="../User/images/Logo.png" class="logo"  alt=""/>
            </a>
            <button class="navbar-toggler d-flex d-lg-none order-3 p-2" type="button" data-bs-toggle="offcanvas"
                    data-bs-target="#bdNavbar" aria-controls="bdNavbar" aria-expanded="false"
                    aria-label="Toggle navigation">
                <svg class="navbar-icon">
                    <use xlink:href="#navbar-icon"></use>
                </svg>
            </button>
            <div class="offcanvas offcanvas-end" tabindex="-1" id="bdNavbar" aria-labelledby="bdNavbarOffcanvasLabel">
                <div class="offcanvas-header px-4 pb-0">
                    <a class="navbar-brand" href="index.jsp">
                        <img src="images/main-logo.png" class="logo">
                    </a>
                    <button type="button" class="btn-close btn-close-black" data-bs-dismiss="offcanvas"
                            aria-label="Close"
                            data-bs-target="#bdNavbar"></button>
                </div>
                <div class="offcanvas-body">
                    <ul id="navbar"
                        class="navbar-nav text-uppercase justify-content-start justify-content-lg-center align-items-start align-items-lg-center flex-grow-1">
                        <li class="nav-item">
                            <a class="nav-link me-4 active" href="index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link me-4" href="AboutUs.jsp">About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link me-4" href="Books.jsp">Books</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link me-4 dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                               aria-expanded="false">Categories</a>
                            <ul class="dropdown-menu animate slide border">
                                <li>
                                    <a href="CategoryBooks.jsp?category=History" class="dropdown-item fw-light">History</a>
                                </li>
                                <li>
                                    <a href="CategoryBooks.jsp?category=Novels" class="dropdown-item fw-light">Novels</a>
                                </li>
                                <li>
                                    <a href="CategoryBooks.jsp?category=Romance" class="dropdown-item fw-light">Romance</a>
                                </li>
                                <li>
                                    <a href="CategoryBooks.jsp?category=Horror" class="dropdown-item fw-light">Horror</a>
                                </li>
                                <li>
                                    <a href="CategoryBooks.jsp?category=Mystery" class="dropdown-item fw-light">Mystery</a>
                                </li>
                                <li>
                                    <a href="CategoryBooks.jsp?category=Children" class="dropdown-item fw-light">Children</a>
                                </li>
                                <li>
                                    <a href="CategoryBooks.jsp?category=Dystopian" class="dropdown-item fw-light">Dystopian</a>
                                </li>
                                <li>
                                    <a href="CategoryBooks.jsp?category=Mythology" class="dropdown-item fw-light">Mythology</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link me-4" href="" id="">Contact</a>
                        </li>
                    </ul>
                    <div class="user-items d-flex">
                        <ul class="d-flex justify-content-end list-unstyled mb-0">
                            <li class="search-item pe-3">
                                <a href="#" class="search-button">
                                    <svg class="search">
                                        <use xlink:href="#search"></use>
                                    </svg>
                                </a>
                            </li>
                            <li class="pe-3">
                                <a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    <svg class="user">
                                        <use xlink:href="#user"></use>
                                    </svg>
                                </a>
                            </li>
                            <li class="pe-3">
                                <div class="header-right">
                                    <%
                                        String userImage = (String) session.getAttribute("image");
                                        String userName = (String) session.getAttribute("userName");

                                        boolean isLoggedIn = (userName != null && userImage != null);

                                        if (!isLoggedIn) {
                                            userImage = "pic-3.jpg";  // Default image when not logged in
                                            userName = "Guest";
                                        }
                                    %>

                                    <div class="user-info-dropdown" style="position: relative;">
                                        <div class="dropdown">
                                            <a href="javascript:void(0);" role="button" class="user-icon-btn">
                                            <span class="user-icon">
                                                <img src="<%= userImage %>" alt="Profile"
                                                     style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;" />
                                            </span>
                                            </a>

                                            <!-- Dropdown content -->
                                            <div class="profile-dropdown">
                                                <span style="padding: 8px 12px; display: block; font-weight: bold;"><%= userName %></span>

                                                <% if (isLoggedIn) { %>
                                                <a href="../User/UserProfile.jsp">Profile</a>
                                                <a href="../User/BorrowedBooks.jsp">Borrowed Books</a>
                                                <a href="../LogoutServlet">Logout</a>
                                                <% } else { %>
                                                <a href="../User/index.jsp">Please Login</a>
                                                <% } %>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-sm custom-small-modal">
                            <div class="modal-content">
                                <div class="modal-header border-bottom-0">
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="tabs-listing">
                                        <nav>
                                            <div class="nav nav-tabs d-flex justify-content-center" id="nav-tab" role="tablist">
                                                <button class="nav-link text-capitalize active" id="nav-sign-in-tab"
                                                        data-bs-toggle="tab" data-bs-target="#nav-sign-in"
                                                        type="button" role="tab" aria-controls="nav-sign-in" aria-selected="true">
                                                    Sign In
                                                </button>
                                                <button class="nav-link text-capitalize" id="nav-register-tab"
                                                        data-bs-toggle="tab" data-bs-target="#nav-register"
                                                        type="button" role="tab" aria-controls="nav-register" aria-selected="false">
                                                    Register
                                                </button>
                                            </div>
                                        </nav>

                                        <div class="tab-content" id="nav-tabContent">
                                            <!-- Sign In Tab -->
                                            <div class="tab-pane fade active show" id="nav-sign-in" role="tabpanel" aria-labelledby="nav-sign-in-tab">
                                                <form action="../LoginServlet" method="post" enctype="multipart/form-data">
                                                    <div class="form-group py-2">
                                                        <label class="mb-1" for="sign-in">Email Id *</label>
                                                        <input type="text" name="email" class="form-control w-100 rounded-2 p-2" required>
                                                    </div>
                                                    <div class="form-group pb-2">
                                                        <label class="mb-1" for="sign-in">Password *</label>
                                                        <input type="password" name="password" class="form-control w-100 rounded-2 p-2" required>
                                                    </div>
                                                    <label class="py-2 d-block">
                                                        <span class="label-body float-end"><a href="#" class="fw-bold">Forgot Password</a></span>
                                                    </label>
                                                    <div>
                                                        <button type="submit" name="submit" class="btn btn-dark w-100 my-2">Login</button>
                                                    </div>
                                                </form>
                                            </div>

                                            <!-- Register Tab -->
                                            <div class="tab-pane fade" id="nav-register" role="tabpanel" aria-labelledby="nav-register-tab">
                                                <form action="../UserRegisterServlet" method="post" enctype="multipart/form-data">
                                                    <div class="row">
                                                        <div class="form-group py-2 col-sm-6">
                                                            <label class="mb-2" for="first-name">First Name *</label>
                                                            <input type="text" id="first-name" name="firstname"
                                                                   class="form-control w-100 rounded-3 p-2" required>
                                                        </div>
                                                        <div class="form-group py-2 col-sm-6">
                                                            <label class="mb-2 d-block">Gender *</label>
                                                            <div class="form-check form-check-inline">
                                                                <input class="form-check-input" type="radio" name="gender" id="gender-male" value="Male" required>
                                                                <label class="form-check-label" for="gender-male">Male</label>
                                                            </div>
                                                            <div class="form-check form-check-inline">
                                                                <input class="form-check-input" type="radio" name="gender" id="gender-female" value="Female">
                                                                <label class="form-check-label" for="gender-female">Female</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group py-2 col-sm-6">
                                                            <label class="mb-2" for="last-name">Last Name *</label>
                                                            <input type="text" id="last-name" name="lastname"
                                                                   class="form-control w-100 rounded-3 p-2" required>
                                                        </div>
                                                        <div class="form-group py-2 col-sm-6">
                                                            <label class="mb-2" for="image-url">Image *</label>
                                                            <input type="file" id="image-url" name="userimage"
                                                                   class="form-control w-100 rounded-3 p-2">
                                                        </div>
                                                        <div class="form-group py-2 col-sm-6">
                                                            <label class="mb-2" for="mobile">Mobile Number *</label>
                                                            <input type="tel" id="mobile" name="mobile"
                                                                   class="form-control w-100 rounded-3 p-2"
                                                                   pattern="[0-9]{10}" maxlength="10" required>
                                                        </div>
                                                        <div class="form-group py-2 col-sm-6">
                                                            <label class="mb-2" for="email">Email Address *</label>
                                                            <input type="email" id="email" name="email"
                                                                   class="form-control w-100 rounded-3 p-2" required>
                                                        </div>
                                                        <div class="form-group pb-2 col-sm-6">
                                                            <label class="mb-2" for="password">Password *</label>
                                                            <input type="password" id="password" name="password"
                                                                   class="form-control w-100 rounded-3 p-2" required>
                                                        </div>
                                                        <div class="form-group pb-2 col-sm-6">
                                                            <label class="mb-2" for="confirm-password">Address *</label>
                                                            <input type="text" id="address" name="address"
                                                                   class="form-control w-100 rounded-3 p-2" required>
                                                        </div>
                                                        <div class="form-group col-12">
                                                            <button type="submit" name="submit" class="btn btn-dark w-100 my-3">Register</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div> <!-- tabs-listing -->
                                </div> <!-- modal-body -->
                            </div> <!-- modal-content -->
                        </div> <!-- modal-dialog -->
                    </div> <!-- modal -->
                </div>
            </div>
        </div>
    </nav>
</header>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const userIconBtn = document.querySelector(".user-icon-btn");
        const dropdown = document.querySelector(".profile-dropdown");

        userIconBtn.addEventListener("click", function(e) {
            e.preventDefault();
            dropdown.classList.toggle("show");
        });

        // Optional: close dropdown when clicking outside
        document.addEventListener("click", function(e) {
            if (!userIconBtn.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove("show");
            }
        });
    });
</script>

<script src="js/jquery-1.11.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>

</body>
</html>