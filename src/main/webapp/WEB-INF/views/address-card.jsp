<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<style>
body {
	font-family: Arial, sans-serif;
	background: #f3f3f3;
}

.container {
	width: 800px;
	margin: 40px auto;
	background: #fff;
	border: 1px solid #ddd;
	padding: 20px;
}

h2 {
	font-weight: 400;
}

.address-box {
	border: 1px solid #ddd;
	padding: 15px;
	margin-bottom: 15px;
	border-radius: 4px;
}

.btn {
	padding: 6px 12px;
	border: 1px solid #adb1b8;
	background: #e7e9ec;
	border-radius: 3px;
	cursor: pointer;
	margin-right: 8px;
}

.add-btn {
	background: linear-gradient(to bottom, #f7dfa5, #f0c14b);
	border: 1px solid #a88734;
}

.green-tick {
	color: green;
	font-weight: bold;
	font-size: 14px;
}

.alert-success {
	background-color: #e6f4ea;
	color: #1e7f3b;
	border: 1px solid #a8dab5;
	padding: 10px 15px;
	margin-bottom: 15px;
	border-radius: 6px;
	font-size: 14px;
}
</style>
</head>
<body>
	<div class="card-body">

		<div class="address-box">
			<c:if test="${addr.defaultAddress}">
				<span class="green-tick">✔ Default</span>
			</c:if>
			<br> <b>${addr.houseNo}</b><br> ${addr.street},
			${addr.city}<br> ${addr.state} - ${addr.pincode}<br> Phone:
			${addr.phone}<br> <br>


			<button class="btn"
				onclick="location.href='edit-address?id=${addr.addressId}'">Edit
			</button>

			<button class="btn"
				onclick="location.href='delete-address?id=${addr.addressId}'">
				Remove</button>

			<c:if test="${!addr.defaultAddress}">
				<form action="/set-default-address/${addr.addressId}" method="post"
					style="display: inline;">
					<button type="submit" class="btn btn-primary">Set as
						Default</button>
				</form>

			</c:if>

		</div>
	</div>
</body>
</html>