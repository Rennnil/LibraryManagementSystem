<!DOCTYPE html>
<html>
	<head>
		<!-- Basic Page Info -->
		<meta charset="utf-8" />
		<title>DeskApp - Bootstrap Admin Dashboard HTML Template</title>

		<!-- Site favicon -->
		<link
			rel="apple-touch-icon"
			sizes="180x180"
			href="vendors/images/apple-touch-icon.png"
		/>
		<link
			rel="icon"
			type="image/png"
			sizes="32x32"
			href="vendors/images/favicon-32x32.png"
		/>
		<link
			rel="icon"
			type="image/png"
			sizes="16x16"
			href="vendors/images/favicon-16x16.png"
		/>

		<!-- Mobile Specific Metas -->
		<meta
			name="viewport"
			content="width=device-width, initial-scale=1, maximum-scale=1"
		/>

		<!-- Google Font -->
		<link
			href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
			rel="stylesheet"
		/>
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="vendors/styles/core.css" />
		<link
			rel="stylesheet"
			type="text/css"
			href="vendors/styles/icon-font.min.css"
		/>
		<!-- Slick Slider css -->
		<link rel="stylesheet" type="text/css" href="src/plugins/slick/slick.css" />
		<!-- bootstrap-touchspin css -->
		<link
			rel="stylesheet"
			type="text/css"
			href="src/plugins/bootstrap-touchspin/jquery.bootstrap-touchspin.css"
		/>
		<link rel="stylesheet" type="text/css" href="vendors/styles/style.css" />

		<!-- Global site tag (gtag.js) - Google Analytics -->
		<script
			async
			src="https://www.googletagmanager.com/gtag/js?id=G-GBZ3SGGX85"
		></script>
		<script
			async
			src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-2973766580778258"
			crossorigin="anonymous"
		></script>
		<script>
			window.dataLayer = window.dataLayer || [];
			function gtag() {
				dataLayer.push(arguments);
			}
			gtag("js", new Date());

			gtag("config", "G-GBZ3SGGX85");
		</script>
		<!-- Google Tag Manager -->
		<script>
			(function (w, d, s, l, i) {
				w[l] = w[l] || [];
				w[l].push({ "gtm.start": new Date().getTime(), event: "gtm.js" });
				var f = d.getElementsByTagName(s)[0],
					j = d.createElement(s),
					dl = l != "dataLayer" ? "&l=" + l : "";
				j.async = true;
				j.src = "https://www.googletagmanager.com/gtm.js?id=" + i + dl;
				f.parentNode.insertBefore(j, f);
			})(window, document, "script", "dataLayer", "GTM-NXZMQSS");
		</script>
		<!-- End Google Tag Manager -->
	</head>
	<body>
		<div class="pre-loader">
			<div class="pre-loader-box">
				<div class="loader-logo">
					<img src="vendors/images/deskapp-logo.svg" alt="" />
				</div>
				<div class="loader-progress" id="progress_div">
					<div class="bar" id="bar1"></div>
				</div>
				<div class="percent" id="percent1">0%</div>
				<div class="loading-text">Loading...</div>
			</div>
		</div>

	   <div class="header">
			<div class="header-left">
				<div class="menu-icon bi bi-list"></div>
			</div>
		</div>


	<div class="left-side-bar">
			<div class="brand-logo">
				<a href="index.html">
					<img src="vendors/images/deskapp-logo.svg" alt="" class="dark-logo" />
					<img
						src="vendors/images/deskapp-logo-white.svg"
						alt=""
						class="light-logo"
					/>
				</a>
				<div class="close-sidebar" data-toggle="left-sidebar-close">
					<i class="ion-close-round"></i>
				</div>
			</div>
			<div class="menu-block customscroll">
				<div class="sidebar-menu">
					<ul id="accordion-menu">
						<li>
							<a href="index.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-house"></span
								><span class="mtext">Dashboard</span>
							</a>
						</li>
						
						
						</li>
						<li class="dropdown">
							<a href="javascript:;" class="dropdown-toggle">
								<span class="micon bi bi-back"></span
									><span class="mtext">Master</span>
							</a>
							<ul class="submenu">
								<li><a href="addFaculty.html">Add Faculty</a></li>
								<li><a href="addCourse.html">Add Course</a></li>
								<li><a href="addLecture.html">Add Lecture</a></li>
							</ul>
						</li>
						<li>
							<a href="course.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-calendar4-week"></span
								><span class="mtext">Books</span>
							</a>
						</li>
						
						
					
						
						

						
						<li>
							<a href="faculty.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-diagram-3"></span
								><span class="mtext">Librarian</span>
							</a>
						</li>
						<li>
							<a href="studentQuery.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-chat-right-dots"></span
								><span class="mtext">Students</span>
							</a>
						</li>
						<li>
							<a href="profile.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-receipt-cutoff"></span
								><span class="mtext">Profile</span>
							</a>
						</li>
						<li>
							<div class="dropdown-divider"></div>
						</li>
					</ul>
				</div>
			</div>
				<div class="sidebar-menu">
					<ul id="accordion-menu">
						<li>
							<a href="index.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-house"></span
								><span class="mtext">Dashboard</span>
							</a>
						</li>
						
						
						</li>
						<li class="dropdown">
							<a href="javascript:;" class="dropdown-toggle">
								<span class="micon bi bi-back"></span
									><span class="mtext">Master</span>
							</a>
							<ul class="submenu">
								<li><a href="addFaculty.html">Add Faculty</a></li>
								<li><a href="addCourse.html">Add Course</a></li>
								<li><a href="addLecture.html">Add Lecture</a></li>
							</ul>
						</li>
						<li>
							<a href="course.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-calendar4-week"></span
								><span class="mtext">Courses</span>
							</a>
						</li>
						
						
					
						
						

						
						<li>
							<a href="faculty.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-diagram-3"></span
								><span class="mtext">Faculty</span>
							</a>
						</li>
						<li>
							<a href="studentQuery.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-chat-right-dots"></span
								><span class="mtext">Student Query</span>
							</a>
						</li>
						<li>
							<a href="profile.html" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-receipt-cutoff"></span
								><span class="mtext">Profile</span>
							</a>
						</li>
						<li>
							<div class="dropdown-divider"></div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="mobile-menu-overlay"></div>

		<!-- js -->
		<script src="vendors/scripts/core.js"></script>
		<script src="vendors/scripts/script.min.js"></script>
		<script src="vendors/scripts/process.js"></script>
		<script src="vendors/scripts/layout-settings.js"></script>
		<!-- Slick Slider js -->
		<script src="src/plugins/slick/slick.min.js"></script>
		<!-- bootstrap-touchspin js -->
		<script src="src/plugins/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
		<script>
			jQuery(document).ready(function () {
				jQuery(".product-slider").slick({
					slidesToShow: 1,
					slidesToScroll: 1,
					arrows: true,
					infinite: true,
					speed: 1000,
					fade: true,
					asNavFor: ".product-slider-nav",
				});
				jQuery(".product-slider-nav").slick({
					slidesToShow: 3,
					slidesToScroll: 1,
					asNavFor: ".product-slider",
					dots: false,
					infinite: true,
					arrows: false,
					speed: 1000,
					centerMode: true,
					focusOnSelect: true,
				});
				$("input[name='demo3_22']").TouchSpin({
					initval: 1,
				});
			});
		</script>
		<!-- Google Tag Manager (noscript) -->
		<noscript
			><iframe
				src="https://www.googletagmanager.com/ns.html?id=GTM-NXZMQSS"
				height="0"
				width="0"
				style="display: none; visibility: hidden"
			></iframe
		></noscript>
		<!-- End Google Tag Manager (noscript) -->
	</body>
</html>
