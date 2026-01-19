<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>Your Addresses</title>

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



	<div class="container">
		<c:if test="${param.alertId == 'yaab-setDefaultAddressSuccess'}">
			<div class="alert-success">✅ Default address changed</div>
		</c:if>
		<h2>Your Addresses</h2>

		<button class="btn add-btn" onclick="location.href='add-address'">
			+ Add a new address</button>

		<br> <br>
		<c:forEach var="addr" items="${addresses}">
			<c:if test="${addr.defaultAddress}">
				<%@ include file="address-card.jsp"%>
			</c:if>
		</c:forEach>

		<c:forEach var="addr" items="${addresses}">
			<c:if test="${!addr.defaultAddress}">
				<%@ include file="address-card.jsp"%>
			</c:if>
		</c:forEach>


	</div>


</body>
</html>
