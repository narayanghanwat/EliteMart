<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Select Seller</title>
<style>
table {
	border-collapse: collapse;
	width: 80%;
	margin: auto;
}

th, td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

button {
	padding: 5px 10px;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #ddd;
}

body {
	font-family: Arial;
	margin: 20px;
}

.seller-card {
	border: 1px solid #ccc;
	padding: 15px;
	border-radius: 10px;
	margin: 10px 0;
}

button {
	padding: 5px 10px;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #ddd;
}

.no-seller {
	color: red;
	font-weight: bold;
}

a.add-seller {
	display: inline-block;
	margin-top: 10px;
	padding: 8px 12px;
	background-color: #4CAF50;
	color: white;
	text-decoration: none;
	border-radius: 5px;
}

a.add-seller:hover {
	background-color: #45a049;
}

.centered {
	text-align: center;
	margin-top: 50px;
}
</style>
</head>
<body>

	<h2 style="text-align: center;">Select a Seller</h2>
	<c:if test="${empty sellers}">
		<div class="centered">
			<p class="no-seller">No seller profiles added yet.</p>
		</div>
	</c:if>
	<c:if test="${not empty sellers}">
		<table>
			<tr>
				<th>Seller ID</th>
				<th>Name</th>
				<th>Shop Name</th>
				<!-- <th>Username</th> -->
				<th>Action</th>
			</tr>

			<c:forEach var="seller" items="${sellers}">
				<tr>
					<td>${seller.sellerId}</td>
					<td>${seller.sellerName}</td>
					<td>${seller.storeName}</td>
					<!-- <td>${seller.user.username}</td> -->
					<td>
						<!-- Choose button: redirect to seller profile -->
						<form action="/seller/profile" method="get">
							<input type="hidden" name="sellerId" value="${seller.sellerId}" />
							
							<input type="hidden" name="userId" value="0" />
							<button type="submit">Select</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>

	<div class="centered">
		<a href="/seller/register" class="add-seller">Add New Seller Account</a>
	</div>

</body>
</html>
