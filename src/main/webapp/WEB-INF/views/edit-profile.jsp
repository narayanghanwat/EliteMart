<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login & Security</title>
<script>
	function validateForm() {
		let valid = true;

		// Phone validation
		const phone = document.getElementById("phone").value;
		const phoneRegex = /^[6-9]\d{9}$/;
		const phoneError = document.getElementById("phoneError");

		if (!phoneRegex.test(phone)) {
			phoneError.style.display = "block";
			valid = false;
		} else {
			phoneError.style.display = "none";
		}

		// Password validation
		const password = document.getElementById("password").value;
		const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
		const passwordError = document.getElementById("passwordError");

		if (!passwordRegex.test(password)) {
			passwordError.style.display = "block";
			valid = false;
		} else {
			passwordError.style.display = "none";
		}

		// Email validation
		const email = document.getElementById("email").value;
		const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		const emailError = document.getElementById("emailError");

		if (!emailRegex.test(email)) {
			emailError.style.display = "block";
			valid = false;
		} else {
			emailError.style.display = "none";
		}

		return valid;
	}
</script>
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
</script>

</head>
<body>

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
				<div id="nameView" class="value">${user.name}</div>

				<form id="nameEdit" action="updateName" method="post"
					style="display: none">
					<input type="text" name="name" value="${user.name}" required>
					<br>
					<button class="save-btn">Save</button>
				</form>
			</div>
			<button class="edit-btn" onclick="enableEdit('name')">Edit</button>
		</div>

		<!-- USERNAME -->
		<div class="row">
			<div>
				<div class="label">Username</div>
				<div id="usernameView" class="value">${user.username}</div>

				<form id="usernameEdit" action="updateUserName" method="post"
					style="display: none">
					<input type="text" name="username" value="${user.username}"
						required> <br>
					<button class="save-btn">Save</button>
				</form>
			</div>
			<button class="edit-btn" onclick="enableEdit('username')">Edit</button>
		</div>

		<!-- EMAIL -->
		<div class="row">
			<div>
				<div class="label">Email</div>
				<div id="emailView" class="value">${user.email}</div>

				<form id="emailEdit" action="updateEmail" method="post"
					style="display: none">
					<input type="email" name="email" value="${user.email}" required>
					<br>
					<button class="save-btn">Save</button>
				</form>
			</div>
			<button class="edit-btn" onclick="enableEdit('email')">Edit</button>
		</div>

		<!-- PHONE -->
		<div class="row">
			<div>
				<div class="label">Mobile number</div>
				<div id="phoneView" class="value">${user.phone}</div>

				<form id="phoneEdit" action="updatePhone" method="post"
					style="display: none">
					<input type="text" name="phone" value="${user.phone}"
						pattern="[0-9]{10}" required> <br>
					<button class="save-btn">Save</button>
				</form>
			</div>
			<button class="edit-btn" onclick="enableEdit('phone')">Edit</button>
		</div>

		<!-- PASSWORD -->
		<div class="row">
			<div>
				<div class="label">Password</div>
				<div id="passwordView" class="value">********</div>

				<form id="passwordEdit" action="updatePassword" method="post"
					style="display: none">
					<input type="password" name="oldPassword"
						placeholder="Current password" required> <br> <input
						type="password" name="newPassword" placeholder="New password"
						required> <br> <input type="password"
						name="confirmPassword" placeholder="Re-enter new password"
						required> <br>

					<button class="save-btn">Save</button>
				</form>
			</div>
			<button class="edit-btn" onclick="enableEdit('password')">Edit</button>
		</div>

	</div>

</body>
</html>
