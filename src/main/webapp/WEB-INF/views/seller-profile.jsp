<%@page import="com.tka.model.Seller"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seller Profile</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
.border-success {
	border-left: 5px solid #198754 !important;
}
</style>
</head>
<body>
	<%
	// get seller from session
	Seller seller = (Seller) session.getAttribute("loggedInSeller");
	%>

	<div class="container mt-5">



		<div class="card shadow mb-4">

			<div class="card-body">
				<div class="d-flex align-items-center mb-3 w-100">

					<h3 class="mb-0">Seller Profile</h3>
					<div class="ms-auto">
						<a href="/seller/edit/profile/${seller.sellerId}"
							class="btn btn-sm btn-outline-primary"> Edit </a>
					</div>
				</div>


				<!-- Basic Info -->
				<p>
					<strong>Shop Name:</strong> ${seller.storeName}
				</p>
				<p>
					<strong>GST Number:</strong> ${seller.gstNumber}
				</p>
				<p>
					<strong>Phone:</strong> ${seller.phone}
				</p>
				<p>
					<strong>Shipping Preference:</strong> ${seller.shippingPreference}

				</p>

				<p>
					<c:if test="${not empty seller.email}">
						<strong>Email:</strong> ${seller.email}
					</c:if>

				</p>


				<hr>

				<!-- Bank Details -->
				<h5>Bank Details</h5>
				<c:if test="${not empty seller.bankDetails}">
					<p>
						<strong>Account Holder:</strong>
						${seller.bankDetails.accountHolderName}
					</p>
					<p>
						<strong>Account Number:</strong>
						${seller.bankDetails.accountNumber}
					</p>
					<p>
						<strong>Bank Name:</strong> ${seller.bankDetails.bankName}
					</p>
					<p>
						<strong>IFSC Code:</strong> ${seller.bankDetails.ifscCode}
					</p>

					<!-- 
					<a href="/bank/edit/${seller.bankDetails.id}"
						class="btn btn-sm btn-outline-primary">Edit Bank Details</a>
					<form action="/bank/delete" method="post" class="d-inline">
						<input type="hidden" name="bankId"
							value="${seller.bankDetails.id}">
						<button type="submit" class="btn btn-sm btn-outline-danger"
							onclick="return confirm('Are you sure you want to remove bank details?')">
							Remove Bank Details</button>
					</form>
 -->
				</c:if>
				<c:if test="${empty seller.bankDetails}">
					<a href="/bank/add" class="btn btn-sm btn-outline-success">Add
						Bank Details</a>
				</c:if>

				<hr>

				<!-- Addresses -->
				<h5>Addresses</h5>
				<c:forEach var="address" items="${seller.addresses}">
					<div
						class="card mb-3 ${address.defaultAddress ? 'border-success' : ''}">
						<div class="card-body">

							<c:if test="${address.defaultAddress}">
								<span class="badge bg-success">&#x2705; Default Address</span>
							</c:if>

							<p>
								<strong>${address.houseNo}</strong>, ${address.street},
								${address.city}, ${address.state} - ${address.pincode}
							</p>

							<div class="d-flex gap-2">
<!-- 								<a href="/edit-address/${address.addressId}"
									class="btn btn-sm btn-outline-primary">Edit</a>
 							<c:if test="${!address.defaultAddress}">
									<form action="/set-default-address" method="post">
										<input type="hidden" name="id"
											value="${address.addressId}">
										<button type="submit" class="btn btn-sm btn-outline-success">Set
											as Default</button>
									</form>
								</c:if>
-->
	
								<form action="/address/delete" method="post">
									<input type="hidden" name="addressId"
										value="${address.addressId}">
									<button type="submit" class="btn btn-sm btn-outline-danger"
										onclick="return confirm('Delete this address?')">
										Remove</button>
								</form>


							</div>

						</div>
					</div>
				</c:forEach>

				<a href="/add-address" class="btn btn-warning">Add New Address</a>

			</div>
		</div>

	</div>

</body>
</html>
