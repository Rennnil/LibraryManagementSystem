<%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 06-09-2025
  Time: 18:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Course Checkout</title>
    <style>
        .card {
            margin-bottom: 24px;
            -webkit-box-shadow: 0 2px 3px #e4e8f0;
            box-shadow: 0 2px 3px #e4e8f0;
        }
        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid #eff0f2;
            border-radius: 1rem;
        }
        .activity-checkout {
            list-style: none
        }
        .activity-checkout .checkout-icon {
            position: absolute;
            top: -4px;
            left: -24px
        }
        .activity-checkout .checkout-item {
            position: relative;
            padding-bottom: 24px;
            padding-left: 35px;
            border-left: 2px solid #f5f6f8
        }
        .activity-checkout .checkout-item:first-child {
            border-color: #3b76e1
        }
        .activity-checkout .checkout-item:last-child {
            border-color: transparent
        }
        .avatar {
            height: 3rem;
            width: 3rem
        }
        .avatar-title {
            align-items: center;
            background-color: #3b76e1;
            color: #fff;
            display: flex;
            font-weight: 500;
            height: 100%;
            justify-content: center;
            width: 100%
        }
        .form-control {
            display: block;
            width: 100%;
            padding: 0.47rem 0.75rem;
            font-size: .875rem;
            color: #545965;
            border: 1px solid #e2e5e8;
            border-radius: 0.75rem;
        }
    </style>
</head>
<body>

<!-- =======================
Page Banner START -->
<section class="py-4">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="bg-light p-4 text-center rounded-3">
                    <h1 class="m-0">Course Grid Minimal</h1>
                    <!-- Breadcrumb -->
                    <div class="d-flex justify-content-center">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb breadcrumb-dots mb-0">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Course minimal</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- =======================Page Banner END -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css" integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous" />
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<div class="container">
    <div class="row">
        <div class="col-xl-8">

            <div class="card">
                <div class="card-body">
                    <ol class="activity-checkout mb-0 px-4 mt-3">
                        <li class="checkout-item">
                            <div class="avatar checkout-icon p-1">
                                <div class="avatar-title rounded-circle bg-primary">
                                    <i class="bx bxs-receipt text-white font-size-20"></i>
                                </div>
                            </div>
                            <div class="feed-item-list">
                                <div>
                                    <h5 class="font-size-16 mb-1">Billing Info</h5>
                                    <p class="text-muted text-truncate mb-4">Check your details are correct</p>
                                    <div class="mb-3">
                                        <form>
                                            <div class="row">
                                                <div class="col-lg-4">
                                                    <div class="mb-3">
                                                        <label class="form-label">First Name</label>
                                                        <input type="text" class="form-control" value="John" readonly>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="mb-3">
                                                        <label class="form-label">Last Name</label>
                                                        <input type="text" class="form-control" value="Doe" readonly>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="mb-3">
                                                        <label class="form-label">Email Address</label>
                                                        <input type="email" class="form-control" value="john.doe@example.com" readonly>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="mb-3">
                                                        <label class="form-label">Phone</label>
                                                        <input type="text" class="form-control" value="+91 9876543210" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </li>

                        <li class="checkout-item">
                            <div class="avatar checkout-icon p-1">
                                <div class="avatar-title rounded-circle bg-primary">
                                    <i class="bx bxs-wallet-alt text-white font-size-20"></i>
                                </div>
                            </div>
                            <div class="feed-item-list">
                                <div>
                                    <h5 class="font-size-16 mb-1">Payment Info</h5>
                                    <p class="text-muted text-truncate mb-4">Select your payment method</p>
                                </div>
                                <div>
                                    <h5 class="font-size-14 mb-3">Payment method :</h5>
                                    <div class="row">
                                        <div class="col-lg-3 col-sm-6">
                                            <label class="card-radio-label">
                                                <input type="radio" name="pay-method" checked>
                                                <span class="card-radio py-3 text-center text-truncate">
                                                    <i class="bx bx-credit-card d-block h2 mb-3"></i>
                                                    Credit / Debit Card
                                                </span>
                                            </label>
                                        </div>
                                        <div class="col-lg-3 col-sm-6">
                                            <label class="card-radio-label">
                                                <input type="radio" name="pay-method">
                                                <span class="card-radio py-3 text-center text-truncate">
                                                    <i class="bx bxl-paypal d-block h2 mb-3"></i>
                                                    Paypal
                                                </span>
                                            </label>
                                        </div>
                                        <div class="col-lg-3 col-sm-6">
                                            <label class="card-radio-label">
                                                <input type="radio" name="pay-method">
                                                <span class="card-radio py-3 text-center text-truncate">
                                                    <i class="bx bx-money d-block h2 mb-3"></i>
                                                    Cash on Delivery
                                                </span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ol>
                </div>
            </div>
        </div>

        <!-- Right sidebar START -->
        <div class="col-xl-4">
            <div class="card card-body shadow p-4 mb-4">
                <!-- Title -->
                <h4 class="mb-4">Order Summary</h4>

                <!-- Course item START -->
                <div class="row g-3">
                    <div class="col-sm-4">
                        <img class="rounded" src="https://via.placeholder.com/100" alt="Course Image">
                    </div>
                    <div class="col-sm-8">
                        <h6 class="mb-0 mt-4"><a href="#">Full Stack Java Development</a></h6>
                    </div>
                </div>
                <!-- Course item END -->

                <hr>

                <ul class="list-group list-group-borderless mb-2">
                    <li class="list-group-item px-0 d-flex justify-content-between">
                        <span class="h6 fw-light mb-0">Original Price</span>
                        <span class="h6 fw-light mb-0 fw-bold">Rs. 1500</span>
                    </li>
                    <li class="list-group-item px-0 d-flex justify-content-between">
                        <span class="h6 fw-light mb-0">Coupon Discount</span>
                        <span class="text-danger">- Rs. 200</span>
                    </li>
                    <li class="list-group-item px-0 d-flex justify-content-between">
                        <span class="h5 mb-0">Total</span>
                        <span class="h5 mb-0">Rs. 1300</span>
                    </li>
                </ul>

                <!-- Button -->
                <div class="d-grid">
                    <a href="#" class="btn btn-lg btn-success">Place Order</a>
                </div>
                <p class="small mb-0 mt-2 text-center">By completing your purchase, you agree to our <a href="#"><strong>Terms of Service</strong></a></p>
            </div>
        </div>
        <!-- Right sidebar END -->
    </div>
</div>
</body>
</html>


