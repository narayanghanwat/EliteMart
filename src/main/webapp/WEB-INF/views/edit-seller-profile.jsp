<%@page import="com.tka.model.Seller"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login & Security</title>

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f3f3f3;
	margin: 0;
}

.container {
	width: 650px;
	margin: 40px auto;
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 20px;
}

h2 {
	font-weight: 400;
	margin-bottom: 20px;
}

.row {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	border-top: 1px solid #eee;
	padding: 15px 0;
}

.row:first-child {
	border-top: none;
}

.label {
	font-size: 14px;
	font-weight: bold;
}

.value {
	font-size: 14px;
	color: #555;
	margin-top: 5px;
}

input {
	width: 260px;
	padding: 6px;
	margin-top: 8px;
}

.edit-btn {
	background: #e7e9ec;
	border: 1px solid #adb1b8;
	border-radius: 3px;
	padding: 6px 12px;
	cursor: pointer;
}

.save-btn {
	background: linear-gradient(to bottom, #f7dfa5, #f0c14b);
	border: 1px solid #a88734;
	border-radius: 3px;
	padding: 6px 12px;
	margin-top: 10px;
	cursor: pointer;
}

.msg {
	margin-bottom: 15px;
	font-size: 14px;
	color: green;
}

.error {
	color: red;
}
</style>

<script>
	function enableEdit(field) {
		document.getElementById(field + "View").style.display = "none";
		document.getElementById(field + "Edit").style.display = "block";
	}

	function enableAdd(field) {
		document.getElementById(field + "Add").style.display = "block";
	}
</script>

</head>
<body>
	<%
		// get seller from session
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
	%>
	<div class="container">
		<h2>Login & Security</h2>

		<c:if test="${not empty success}">
			<div class="msg">${success}</div>
		</c:if>

		<c:if test="${not empty error}">
			<div class="msg error">${error}</div>
		</c:if>

		<!-- NAME -->
		<div class="row">
			<div>
				<div class="label">Name</div>
				<div id="nameView" class="value">${seller.sellerName}</div>

				<form id="nameEdit" action="/seller/updateName" method="post"
					style="display: none">
					<input type="text" name="name" value="${seller.sellerName}"
						required> <br>
					<button class="save-btn">Save</button>
				</form>
			</div>
			<button class="edit-btn" onclick="enableEdit('name')">Edit</button>
		</div>

		<!-- SHOPNAME -->
		<div class="row">
			<div>
				<div class="label">Shop Name</div>
				<div id="shopnameView" class="value">${seller.storeName}</div>

				<form id="shopnameEdit" action="/seller/updateShopName"
					method="post" style="display: none">
					<input type="text" name="shopname" value="${seller.storeName}"
						required> <br>
					<button class="save-btn">Save</button>
				</form>
			</div>
			<button class="edit-btn" onclick="enableEdit('shopname')">Edit</button>
		</div>

		<!-- GSTNUMBER -->
		<div class="row">
			<div>
				<div class="label">GST Number</div>
				<div id="gstNumberView" class="value">${seller.gstNumber}</div>

				<form id="gstNumberEdit" action="/seller/updategstNumber"
					method="post" style="display: none">
					<input type="text" name="gstNumber" value="${seller.gstNumber}"
						required> <br>
					<button class="save-btn">Save</button>
				</form>
			</div>
			<button class="edit-btn" onclick="enableEdit('gstNumber')">Edit</button>
		</div>


		<!-- PHONE -->
		<div class="row">
			<div>
				<div class="label">Phone</div>
				<div id="phoneView" class="value">${seller.phone}</div>

				<form id="phoneEdit" action="/seller/updatePhone" method="post"
					style="display: none">
					<input type="text" name="phone" value="${seller.phone}"
						pattern="[0-9]{10}" required> <br>
					<button class="save-btn">Save</button>
				</form>
			</div>
			<button class="edit-btn" onclick="enableEdit('phone')">Edit</button>
		</div>

		<!-- SHIPPING PREFERENCE -->
		<div class="row">
			<div>
				<div class="label">Shipping Preference</div>

				<!-- VIEW MODE -->
				<div id="shippingPreferenceView" class="value">
					${seller.shippingPreference}</div>

				<!-- EDIT MODE -->
				<form id="shippingPreferenceEdit"
					action="/seller/updateShippingPreference" method="post"
					style="display: none">

					<select name="shippingPreference" required>
						<option value="">-- Select Preference --</option>

						<option value="SELF_SHIP">Self Shipping</option>

						<option value="PLATFORM_SHIP">Platform Shipping</option>
					</select> <br>
					<button class="save-btn">Save</button>
				</form>
			</div>

			<button class="edit-btn" onclick="enableEdit('shippingPreference')">
				Edit</button>
		</div>


		<!-- EMAIL -->
		<div class="row">
			<div>
				<div class="label">Email</div>
				<div id="emailView" class="value">${seller.email}</div>
				<c:if test="${not empty seller.email}">
					<form id="emailEdit" action="/seller/updateEmail" method="post"
						style="display: none">
						<input type="email" name="email" value="${seller.email}" required>
						<br>
						<button class="save-btn">Save</button>
					</form>
				</c:if>
				
				<c:if test="${empty seller.email}">
				<form id="emailAdd" action="/seller/add/email" method="post"
						style="display: none">
						<input type="email" name="email" required>
						<br>
						<button class="save-btn">Save</button>
					</form>
				</c:if>
			</div>
			<c:if test="${not empty seller.email}">
				<button class="edit-btn" onclick="enableEdit('email')">Edit</button>
			</c:if>
			<c:if test="${empty seller.email}">
				<div class="col-md-5 value text-muted">Not set</div>
				<button class="edit-btn" onclick="enableAdd('email')">Add</button>
			</c:if>
		</div>



		<!-- PASSWORD -->
		<div class="row">
			<div>
				<div class="label">Password</div>

				<c:if test="${not empty seller.password}">
					<div id="passwordView" class="value">********</div>
				</c:if>

				<form id="passwordEdit" action="/seller/updatePassword"
					method="post" style="display: none">
					<input type="password" name="oldPassword"
						placeholder="Current password" required> <br> <input
						type="password" name="newPassword" placeholder="New password"
						required> <br> <input type="password"
						name="confirmPassword" placeholder="Re-enter new password"
						required> <br>

					<button class="save-btn">Save</button>
				</form>

			</div>
			<c:if test="${not empty seller.password}">
				<button class="edit-btn" onclick="enableEdit('password')">Edit</button>
			</c:if>
			<c:if test="${empty seller.password}">
				<div class="col-md-5 value text-muted">Not set</div>
				<button class="edit-btn" onclick="enableAdd('password')">Add</button>
			</c:if>
		</div>

		<!-- ADD MODE -->

		<form id="passwordAdd" action="/seller/add/password" method="post"
			class="col-md-9 offset-md-3 mt-2" style="display: none">

			<input type="password" name="password"
				class="form-control form-control-sm mb-2"
				placeholder="Create password" required> <input
				type="password" name="confirmPassword"
				class="form-control form-control-sm mb-2"
				placeholder="Confirm password" required>

			<button class="save-btn">Save</button>
		</form>
</body>
</html>
