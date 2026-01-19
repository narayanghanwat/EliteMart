<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.seller-navbar {
	background-color: #131921;
}

.seller-brand {
	color: #FF9900 !important;
	font-weight: bold;
	font-size: 22px;
}

.nav-link {
	color: white !important;
	font-size: 14px;
}

.nav-link:hover {
	text-decoration: underline;
}

.seller-badge {
	background: #232f3e;
	color: #febd69;
	padding: 4px 8px;
	border-radius: 4px;
	font-size: 12px;
}

.nav-small {
	font-size: 12px;
	color: #ccc;
}

.dropdown-hover:hover .dropdown-menu {
	display: block;
	margin-top: 0;
}

.dropdown-menu {
	min-width: 200px;
	font-size: 14px;
}
</style>

<nav class="navbar navbar-expand-lg seller-navbar px-3">
	<div class="container-fluid">

		<!-- Logo -->
		<a class="navbar-brand seller-brand" href="/seller/dashboard">
			EliteMart<span style="font-size: 12px"> seller</span>
		</a>

		<button class="navbar-toggler bg-light" type="button"
			data-bs-toggle="collapse" data-bs-target="#sellerNav">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="sellerNav">

			<!-- Left Links -->
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link"
					href="/seller/dashboard">Dashboard</a></li>
				<li class="nav-item"><a class="nav-link" href="/products/list">My
						Products</a></li>
				<li class="nav-item"><a class="nav-link" href="/products/add">Add
						Product</a></li>
				<li class="nav-item"><a class="nav-link" href="/order/list">Orders</a>
				</li>
			</ul>

			<!-- Right Section -->
			<div class="d-flex align-items-center">

				<span class="seller-badge me-3"> SELLER </span> <span
					class="text-white me-3"> </span>

				<!-- Account & Lists -->
				<div class="dropdown dropdown-hover me-4">
					<a href="#" class="text-white text-decoration-none">
						<div class="nav-small">
							Hello,
							<c:choose>
								<c:when test="${not empty sessionScope.loggedInSeller}">
						${sessionScope.loggedInSeller.sellerName}
					</c:when>
								<c:otherwise>
						Sign in
					</c:otherwise>
							</c:choose>
						</div> <strong>Account & Lists </strong>
					</a>

					<ul class="dropdown-menu">
						<c:choose>
							<c:when test="${not empty sessionScope.loggedInSeller}">
								<li><a class="dropdown-item"
									href="/seller/viewprofile/${sessionScope.loggedInSeller.sellerId}">Your
										Account</a></li>
								<li><a class="dropdown-item" href="/">User Account
										</a></li>
								<li><a class="dropdown-item" href="/seller/choose-profile">Switch
										Profile</a></li>

								<li><hr class="dropdown-divider"></li>
								<li><a class="dropdown-item" href="/seller/logoutseller">Logout</a></li>
							</c:when>

							<c:otherwise>
								<li><a class="dropdown-item" href="/users/login">Sign
										In</a></li>
								<li><a class="dropdown-item" href="/users/register">Register</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>



			</div>

		</div>
	</div>
</nav>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
