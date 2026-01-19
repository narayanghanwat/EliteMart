<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit address</title>

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f3f3f3;
	margin: 0;
	padding: 0;
}

.container {
	width: 600px;
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

label {
	font-size: 14px;
	font-weight: bold;
	display: block;
	margin-top: 15px;
}

input {
	width: 100%;
	padding: 8px;
	margin-top: 6px;
	border: 1px solid #a6a6a6;
	border-radius: 3px;
	font-size: 14px;
}

input:focus {
	outline: none;
	border-color: #e77600;
	box-shadow: 0 0 3px rgba(228, 121, 17, .5);
}

.btn {
	margin-top: 20px;
	padding: 8px 14px;
	font-size: 14px;
	cursor: pointer;
	border-radius: 3px;
}

.save-btn {
	background: linear-gradient(to bottom, #f7dfa5, #f0c14b);
	border: 1px solid #a88734;
}

.cancel-btn {
	background: #e7e9ec;
	border: 1px solid #adb1b8;
	margin-left: 10px;
}

.checkbox-row {
	display: flex;
	align-items: center;
	margin-top: 15px;
	font-size: 14px;
}

.checkbox-row input[type="checkbox"] {
	width: 16px;
	height: 16px;
	margin: 0 8px 0 0;
	cursor: pointer;
}

.checkbox-row label {
	margin: 0;
	cursor: pointer;
}
</style>

</head>
<body>

	<div class="container">
		<h2>Edit address</h2>

		<form action="update-address" method="post">

			<!-- IMPORTANT: address ID -->
			<input type="hidden" name="addressId" value="${address.addressId}">
			<input type="hidden" name="user.userId"
				value="${address.user.userId}"> <label>House / Flat
				No</label> <input type="text" name="houseNo" value="${address.houseNo}"
				required> <label>Street / Area / Village</label> <input
				type="text" name="street" value="${address.street}" required>
			<label>City</label> <input type="text" name="city"
				value="${address.city}" required> <label>State</label> <input
				type="text" name="state" value="${address.state}" required>

			<label>Pincode</label> <input type="text" name="pincode"
				value="${address.pincode}" pattern="[0-9]{6}" required> <label>Mobile
				number</label> <input type="text" name="phone" value="${address.phone}"
				pattern="[0-9]{10}" required>

			<div class="checkbox-row">
				<input type="checkbox" id="defaultAddress" name="defaultAddress"
				${address.defaultAddress ? 'checked="checked"' : ''}/>
				<label for="defaultAddress">Set as default address</label>
			</div>

			<button type="submit" class="btn save-btn">Update address</button>

			<button type="button" class="btn cancel-btn"
				onclick="location.href='your-addresses'">Cancel</button>

		</form>
	</div>

</body>
</html>
