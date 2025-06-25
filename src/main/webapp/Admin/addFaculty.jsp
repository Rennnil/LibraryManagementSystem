<!DOCTYPE html>
<html>
	<head>

		<script src="https://cdn.lordicon.com/lordicon.js"></script>
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
		<link
			rel="stylesheet"
			type="text/css"
			href="src/plugins/datatables/css/dataTables.bootstrap4.min.css"
		/>
		<link
			rel="stylesheet"
			type="text/css"
			href="src/plugins/datatables/css/responsive.bootstrap4.min.css"
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
			<div class="header-right">
				<div class="dashboard-setting user-notification">
					<div class="dropdown">
						<a
							class="dropdown-toggle no-arrow"
							href="javascript:;"
							data-toggle="right-sidebar"
						>
							<i class="dw dw-settings2"></i>
						</a>
					</div>
				</div>
				
				<div class="user-info-dropdown">
					<div class="dropdown">
						<a
							class="dropdown-toggle"
							href="#"
							role="button"
							data-toggle="dropdown"
						>
							<span class="user-icon">
								<img src="vendors/images/photo1.jpg" alt="" />
							</span>
							<span class="user-name">Shivam</span>
						</a>
						<div
							class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list"
						>
							<a class="dropdown-item" href="profile.html"
								><i class="dw dw-user1"></i> Profile</a
							>
							<a class="dropdown-item" href="profile.html"
								><i class="dw dw-settings2"></i> Setting</a
							>
							<a class="dropdown-item" href="faq.html"
								><i class="dw dw-help"></i> Help</a
							>
							<a class="dropdown-item" href="login.html"
								><i class="dw dw-logout"></i> Log Out</a
							>
						</div>
					</div>
				</div>
			
			</div>
		</div>

		<div class="right-sidebar">
			<div class="sidebar-title">
				<h3 class="weight-600 font-16 text-blue">
					Layout Settings
					<span class="btn-block font-weight-400 font-12"
						>User Interface Settings</span
					>
				</h3>
				<div class="close-sidebar" data-toggle="right-sidebar-close">
					<i class="icon-copy ion-close-round"></i>
				</div>
			</div>
			<div class="right-sidebar-body customscroll">
				<div class="right-sidebar-body-content">
					<h4 class="weight-600 font-18 pb-10">Header Background</h4>
					<div class="sidebar-btn-group pb-30 mb-10">
						<a
							href="javascript:void(0);"
							class="btn btn-outline-primary header-white active"
							>White</a
						>
						<a
							href="javascript:void(0);"
							class="btn btn-outline-primary header-dark"
							>Dark</a
						>
					</div>

					<h4 class="weight-600 font-18 pb-10">Sidebar Background</h4>
					<div class="sidebar-btn-group pb-30 mb-10">
						<a
							href="javascript:void(0);"
							class="btn btn-outline-primary sidebar-light"
							>White</a
						>
						<a
							href="javascript:void(0);"
							class="btn btn-outline-primary sidebar-dark active"
							>Dark</a
						>
					</div>

					<h4 class="weight-600 font-18 pb-10">Menu Dropdown Icon</h4>
					<div class="sidebar-radio-group pb-10 mb-10">
						<div class="custom-control custom-radio custom-control-inline">
							<input
								type="radio"
								id="sidebaricon-1"
								name="menu-dropdown-icon"
								class="custom-control-input"
								value="icon-style-1"
								checked=""
							/>
							<label class="custom-control-label" for="sidebaricon-1"
								><i class="fa fa-angle-down"></i
							></label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input
								type="radio"
								id="sidebaricon-2"
								name="menu-dropdown-icon"
								class="custom-control-input"
								value="icon-style-2"
							/>
							<label class="custom-control-label" for="sidebaricon-2"
								><i class="ion-plus-round"></i
							></label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input
								type="radio"
								id="sidebaricon-3"
								name="menu-dropdown-icon"
								class="custom-control-input"
								value="icon-style-3"
							/>
							<label class="custom-control-label" for="sidebaricon-3"
								><i class="fa fa-angle-double-right"></i
							></label>
						</div>
					</div>

					<h4 class="weight-600 font-18 pb-10">Menu List Icon</h4>
					<div class="sidebar-radio-group pb-30 mb-10">
						<div class="custom-control custom-radio custom-control-inline">
							<input
								type="radio"
								id="sidebariconlist-1"
								name="menu-list-icon"
								class="custom-control-input"
								value="icon-list-style-1"
								checked=""
							/>
							<label class="custom-control-label" for="sidebariconlist-1"
								><i class="ion-minus-round"></i
							></label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input
								type="radio"
								id="sidebariconlist-2"
								name="menu-list-icon"
								class="custom-control-input"
								value="icon-list-style-2"
							/>
							<label class="custom-control-label" for="sidebariconlist-2"
								><i class="fa fa-circle-o" aria-hidden="true"></i
							></label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input
								type="radio"
								id="sidebariconlist-3"
								name="menu-list-icon"
								class="custom-control-input"
								value="icon-list-style-3"
							/>
							<label class="custom-control-label" for="sidebariconlist-3"
								><i class="dw dw-check"></i
							></label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input
								type="radio"
								id="sidebariconlist-4"
								name="menu-list-icon"
								class="custom-control-input"
								value="icon-list-style-4"
								checked=""
							/>
							<label class="custom-control-label" for="sidebariconlist-4"
								><i class="icon-copy dw dw-next-2"></i
							></label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input
								type="radio"
								id="sidebariconlist-5"
								name="menu-list-icon"
								class="custom-control-input"
								value="icon-list-style-5"
							/>
							<label class="custom-control-label" for="sidebariconlist-5"
								><i class="dw dw-fast-forward-1"></i
							></label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input
								type="radio"
								id="sidebariconlist-6"
								name="menu-list-icon"
								class="custom-control-input"
								value="icon-list-style-6"
							/>
							<label class="custom-control-label" for="sidebariconlist-6"
								><i class="dw dw-next"></i
							></label>
						</div>
					</div>

					<div class="reset-options pt-30 text-center">
						<button class="btn btn-danger" id="reset-settings">
							Reset Settings
						</button>
					</div>
				</div>
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

		<div class="main-container">
			<div class="pd-ltr-20 xs-pd-20-10">
				<div class="min-height-200px">
					<div class="page-header">
						<div class="row">
							<div class="col-md-6 col-sm-12">
								<div class="title">
									<h4>DataTable</h4>
								</div>
								<nav aria-label="breadcrumb" role="navigation">
									<ol class="breadcrumb">
										<li class="breadcrumb-item">
											<a href="index.html">Home</a>
										</li>
										<li class="breadcrumb-item active" aria-current="page">
											DataTable
										</li>
									</ol>
								</nav>
							</div>
							<div class="col-md-6 col-sm-12 text-right">
								<div>
									<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addCourse">
										Add Course 
									</button>
								</div>
							</div>
						</div>
					</div>
					

					
									
					<!-- Export Datatable start -->
					<div class="card-box pb-10">
						<div class="h5 pd-20 mb-0">Recent Patient</div>
						<table class=" table nowrap  data-table-export ">
							<thead>
								<tr>
									<th class="table-plus">Name</th>
									<th>Gender</th>
									<th>Weight</th>
									<th>Assigned Doctor</th>
									<th>Admit Date</th>
									<th>Disease</th>
									<th class="datatable-nosort">Actions</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="table-plus">
										<div class="name-avatar d-flex align-items-center">
											<div class="avatar mr-2 flex-shrink-0">
												<img
													src="pic-3.jpg"
													class="border-radius-100 shadow"
													width="40"
													height="40"
													alt=""
												/>
											</div>
											<div class="txt">
												<div class="weight-600">Jennifer O. Oster</div>
											</div>
										</div>
									</td>
									<td>Female</td>
									<td>45 kg</td>
									<td>Dr. Callie Reed</td>
									<td>19 Oct 2020</td>
									<td>
										<span
											class="badge badge-pill"
											data-bgcolor="#e7ebf5"
											data-color="#265ed7"
											>Typhoid</span
										>
									</td>
									<td>
										<div class="table-actions">
											<a href="" class="btn" data-color="#265ed7"
											data-toggle="modal" data-target="#editCourse"
												><i class="icon-copy dw dw-edit2"></i
											></a>
											<a href="" class="btn" data-color="#e95959"
											data-toggle="modal" data-target="#deleteModal"
												><i class="icon-copy dw dw-delete-3"></i
											></a>
										</div>
									</td>
								</tr>
							
								
							</tbody>
						</table>
					</div>
					<!-- Export Datatable End -->
				</div>
			       
			</div>
		</div>
		<!-- Add modal start -->
		<div
		class="modal fade bs-example-modal-lg"
		id="addCourse"
		tabindex="-1"
		role="dialog"
		aria-labelledby="myLargeModalLabel"
		aria-hidden="true"
	>
		<div class="modal-dialog modal-md modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myLargeModalLabel">
						Large modal
					</h4>

					

					<button
						type="button"
						class="close"
						data-dismiss="modal"
						aria-hidden="true"
					>
					<lord-icon
					src="https://cdn.lordicon.com/jkppkiom.json"
					trigger="hover"
					style="width:30px;height:30px">
				    </lord-icon>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="mb-3">
						  <label for="exampleInputEmail1" >Email address</label>
						  <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
						</div>
						<div class="mb-3">
						  <label for="exampleInputPassword1">Password</label>
						  <input type="password" class="form-control" id="exampleInputPassword1">
						</div>
						
						<div class="custom-file mb-3">
							<input type="file" class="custom-file-input" id="customFile" name="filename">
							<label class="custom-file-label" for="customFile">Choose file</label>
						  </div>
						
						
						
						<div class="d-flex" style="gap: 20px;">
							<button type="submit" class="btn btn-primary w-75">Submit</button>
							<button
							type="button"
							class="btn btn-danger w-25"
							data-dismiss="modal"
						>
							Close
						</button>
						</div>
						
					  </form>
					
				</div>
				
			</div>
		</div>
	</div>
	<!-- ============(Edit)=========================================== -->


		<div
		class="modal fade bs-example-modal-lg"
		id="editCourse"
		tabindex="-1"
		role="dialog"
		aria-labelledby="myLargeModalLabel"
		aria-hidden="true"
	>
		<div class="modal-dialog modal-md modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myLargeModalLabel">
						Large modal
					</h4>
					<button
						type="button"
						class="close"
						data-dismiss="modal"
						aria-hidden="true"
					>
						×
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="mb-3">
						  <label for="exampleInputEmail1" >Email address</label>
						  <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
						</div>
						<div class="mb-3">
						  <label for="exampleInputPassword1">Password</label>
						  <input type="password" class="form-control" id="exampleInputPassword1">
						</div>
						
						<div class="d-flex" style="gap: 20px;">
							<button type="submit" class="btn btn-primary w-75">Submit</button>
							<button
							type="button"
							class="btn btn-danger w-25"
							data-dismiss="modal"
						>
							Close
						</button>
						</div>
						
					  </form>
				</div>
				
			</div>
		</div>
	</div>


		<!-- ============(Delete)=========================================== -->


		<div class="modal fade bs-example-modal-lg" id="deleteModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Delete Student</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<form action="DeleteServlet" method="post">
							<p>Are you sure you want to delete this student?</p>
							<input type="hidden" name="id" id="deleteId">
							<button type="submit" class="btn btn-danger">Delete</button>
							<button
							type="button"
							class="btn btn-light w-25"
							data-dismiss="modal"
						>
							Close
						</button>
						</form>
					</div>
				</div>
			</div>
		</div>


		<!-- welcome modal end -->
		<!-- js -->
		<script src="vendors/scripts/core.js"></script>
		<script src="vendors/scripts/script.min.js"></script>
		<script src="vendors/scripts/process.js"></script>
		<script src="vendors/scripts/layout-settings.js"></script>
		<script src="src/plugins/datatables/js/jquery.dataTables.min.js"></script>
		<script src="src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
		<script src="src/plugins/datatables/js/dataTables.responsive.min.js"></script>
		<script src="src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
		<!-- buttons for Export datatable -->
		<script src="src/plugins/datatables/js/dataTables.buttons.min.js"></script>
		<script src="src/plugins/datatables/js/buttons.bootstrap4.min.js"></script>
		<script src="src/plugins/datatables/js/buttons.print.min.js"></script>
		<script src="src/plugins/datatables/js/buttons.html5.min.js"></script>
		<script src="src/plugins/datatables/js/buttons.flash.min.js"></script>
		<script src="src/plugins/datatables/js/pdfmake.min.js"></script>
		<script src="src/plugins/datatables/js/vfs_fonts.js"></script>
		<!-- Datatable Setting js -->
		<script src="vendors/scripts/datatable-setting.js"></script>
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

		<script>
			// Add the following code if you want the name of the file appear on select
			$(".custom-file-input").on("change", function() {
			  var fileName = $(this).val().split("\\").pop();
			  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
			});
			</script>
	</body>
</html>
