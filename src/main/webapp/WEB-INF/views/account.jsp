<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="navbar.jsp"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #eaeded;
}

.account-container {
	max-width: 1100px;
	margin: 40px auto;
}

.account-title {
	font-size: 28px;
	font-weight: 600;
	margin-bottom: 25px;
}

.account-card {
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 20px;
	height: 100%;
	cursor: pointer;
	transition: box-shadow 0.2s;
}

.account-card:hover {
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.account-card h6 {
	font-weight: 600;
}

.account-card p {
	font-size: 13px;
	color: #555;
}
</style>

<div class="account-container">

	<div class="account-title">Your Account</div>

	<div class="row g-4">

		<!-- Your Orders -->
		<div class="col-md-4">
			<a href="/order/my" class="text-decoration-none text-dark">
				<div class="account-card">
					<h6>Your Orders</h6>
					<p>Track, return, or buy things again</p>
				</div>
			</a>
		</div>

		<!-- Login & Security -->
		<div class="col-md-4">
			<a href="/users/edit/${sessionScope.loggedInUser.userId}"
				class="text-decoration-none text-dark">
				<div class="account-card">
					<h6>Login & Security</h6>
					<p>Edit login, name, and password</p>
				</div>
			</a>
		</div>

		<!-- Your Addresses -->
		<div class="col-md-4">
			<a href="/your-addresses" class="text-decoration-none text-dark">
				<div class="account-card">
					<h6>Your Addresses</h6>
					<p>Edit addresses for orders and gifts</p>
				</div>
			</a>
		</div>

		<!-- Seller Account -->
		<div class="col-md-4">
			<a href="/seller/choose-profile"
				class="text-decoration-none text-dark">
				<div class="account-card">
					<h6>Your Seller Account</h6>
					<p>Manage products and seller profile</p>
				</div>
			</a>
		</div>

		<!-- Payment Options -->
		<div class="col-md-4">
			<a href="#" class="text-decoration-none text-dark">
				<div class="account-card">
					<h6>Payment Options</h6>
					<p>Manage saved cards and UPI</p>
				</div>
			</a>
		</div>

		<!-- Logout -->
		<div class="col-md-4">
			<a href="/users/logout" class="text-decoration-none text-dark">
				<div class="account-card">
					<h6>Sign Out</h6>
					<p>Logout from your account</p>
				</div>
			</a>
		</div>

		``
		<!-- Close Your Account -->
		<div class="col-md-4">
			<a href="/users/delete"
				class="text-decoration-none text-dark"
				onclick="return confirm('Are you sure you want to permanently close your account? This action cannot be undone.');">
				<div class="account-card border-danger">
					<h6 class="text-danger">Close Your Account</h6>
					<p class="text-danger">Permanently delete your account and all
						associated data</p>
				</div>
			</a>
		</div>

	</div>
</div>
