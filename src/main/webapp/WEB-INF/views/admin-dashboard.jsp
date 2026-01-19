<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="admin-navbar.jsp"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.dashboard-card {
	border-radius: 12px;
	transition: transform 0.2s ease-in-out;
}

.dashboard-card:hover {
	transform: scale(1.03);
}
</style>

<div class="container mt-4">

	<h3 class="mb-4">Admin Dashboard</h3>

	<div class="row g-4">

		<!-- Users -->
		<div class="col-md-3">
			<div class="card dashboard-card text-bg-primary shadow">
				<div class="card-body text-center">
					<h6>Total Users</h6>
					<h2>${userCount}</h2>
					<a href="/users/" class="btn btn-light btn-sm mt-2"> Manage
						Users </a>
				</div>
			</div>
		</div>

		<!-- Sellers -->
		<div class="col-md-3">
			<div class="card dashboard-card text-bg-info shadow">
				<div class="card-body text-center">
					<h6>Total Sellers</h6>
					<h2>${sellerCount}</h2>
					<a href="/seller/all" class="btn btn-light btn-sm mt-2"> Manage
						Sellers </a>
				</div>
			</div>
		</div>

		<!-- Products -->
		<div class="col-md-3">
			<div class="card dashboard-card text-bg-success shadow">
				<div class="card-body text-center">
					<h6>Total Products</h6>
					<h2>${productCount}</h2>
					<a href="/products/" class="btn btn-light btn-sm mt-2"> Manage
						Products </a>
				</div>
			</div>
		</div>

		<!-- Orders -->
		<div class="col-md-3">
			<div class="card dashboard-card text-bg-warning shadow">
				<div class="card-body text-center">
					<h6>Total Orders</h6>
					<h2>${orderCount}</h2>
					<a href="/order/all" class="btn btn-light btn-sm mt-2"> View
						Orders </a>
				</div>
			</div>
		</div>

	</div>

	<!-- Admin Quick Links -->
	<div class="mt-5">
		<h5>Quick Actions</h5>
		<div class="d-flex gap-3 flex-wrap">
			<a href="/products/add" class="btn btn-outline-success">Add
				Product</a> <a href="/seller/register" class="btn btn-outline-info">Add
				Seller</a> <a href="/users/" class="btn btn-outline-primary">View
				Users</a>
		</div>
	</div>

</div>
<script>
	let pass = prompt("Enter Passkey :")
	if (pass != "ADM-9F7K-X2P8-QM4R") {
		alert("Invalid Passkey")
		window.location.href = "/"
	}
</script>