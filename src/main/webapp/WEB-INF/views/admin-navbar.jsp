<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.admin-navbar {
	background-color: #131921;
}

.admin-brand {
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

.admin-badge {
	background: #232f3e;
	color: #febd69;
	padding: 4px 8px;
	border-radius: 4px;
	font-size: 12px;
}
</style>

<nav class="navbar navbar-expand-lg admin-navbar px-3">
	<div class="container-fluid">

		<!-- Logo -->
		<a class="navbar-brand admin-brand" href="/admin/dashboard">
			EliteMart<span style="font-size: 12px"> admin</span>
		</a>

		<button class="navbar-toggler bg-light" type="button"
			data-bs-toggle="collapse" data-bs-target="#adminNav">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="adminNav">

			<!-- Left Links -->
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link"
					href="/admin/dashboard">Dashboard</a></li>
				<li class="nav-item"><a class="nav-link" href="/users/">Users</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="/seller/all">Sellers</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="/products/">Products</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="/order/all">Orders</a>
				</li>
			</ul>

			<!-- Right Section -->
			<div class="d-flex align-items-center">

				<span class="admin-badge me-3"> ADMIN </span> <span
					class="text-white me-3"> Hello,
					Admin </span> <a href="/users/logout"
					class="btn btn-sm btn-warning fw-bold"> Logout </a>
			</div>

		</div>
	</div>
</nav>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
