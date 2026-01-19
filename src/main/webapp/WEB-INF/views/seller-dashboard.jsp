<%@page import="com.tka.model.Seller"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ include file="seller-navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seller Dashboard</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">


<style>
body {
	background: #f3f3f3;
}

.card-box {
	border-radius: 6px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .1);
}
</style>

</head>
<body>
	<c:if test="${not empty msg}">
        ${msg}
    </c:if>
	<br>
		<%
// get seller from session
Seller seller = (Seller) session.getAttribute("loggedInSeller");
%>

	



	<div class="container mt-4">
		<h3>Welcome, ${seller.storeName}</h3>

		<div class="row mt-4">

			<div class="col-md-4">
				<div class="card card-box p-3">
					<h6>Total Products</h6>
					<h3>${productCount}</h3>
					<a href="/products/list" class="btn btn-sm btn-outline-primary">
						Manage Products </a>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card card-box p-3">
					<h6>Total Orders</h6>
					<h3>${orderCount}</h3>
				    <a href="/order/list"
						class="btn btn-sm btn-outline-success"> View Orders </a>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card card-box p-3">
					<h6>Total Revenue</h6>
					<h3>₹ ${totalRevenue}</h3>
				</div>
			</div>

		</div>
	</div>
</body>
</html>