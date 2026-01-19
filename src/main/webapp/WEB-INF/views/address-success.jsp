<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Address Saved</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #f3f3f3;
	font-family: Arial, sans-serif;
}

.success-container {
	max-width: 500px;
	margin: 80px auto;
	background: #fff;
	padding: 40px;
	border-radius: 8px;
	text-align: center;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.success-icon {
	font-size: 50px;
	color: #28a745;
	margin-bottom: 20px;
}

h2 {
	font-weight: 500;
	margin-bottom: 15px;
}

p {
	font-size: 16px;
	color: #555;
	margin-bottom: 25px;
}

.btn-success {
	background-color: #28a745;
	border-color: #28a745;
}

.btn-success:hover {
	background-color: #218838;
	border-color: #1e7e34;
}
</style>
</head>

<body>

	<div class="success-container">
		<div class="success-icon">&#10004;</div>
		<h2>Address Saved Successfully!</h2>
		<p>Your address has been added to your account.</p>

		<div class="d-flex justify-content-center gap-2">
			<a href="<c:url value='/your-addresses'/>" class="btn btn-success">View
				Addresses</a>
		</div>
	</div>

</body>
</html>
