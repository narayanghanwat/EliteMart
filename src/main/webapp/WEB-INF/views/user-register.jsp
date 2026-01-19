<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register User</title>

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

</head>

<body>
	<div class="container mt-5 col-md-5">
		<div class="card p-4 shadow">
			<h3 class="mb-4 text-center">Create Account</h3>

			<form action="/users/save" method="post"
				onsubmit="return validateForm()">

				<!-- Name -->
				<div class="mb-3">
					<label class="form-label">Name</label> <input type="text"
						name="name" class="form-control" required>
				</div>

				<!-- User Name -->
				<div class="mb-3">
					<label class="form-label">User Name</label> <input type="text"
						name="username" class="form-control" required>
				</div>

				<!-- Password -->
				<div class="mb-3">
					<label class="form-label">Password</label> <input type="password"
						id="password" name="password" class="form-control" required>
					<div id="passwordError" class="text-danger small"
						style="display: none">Password must be 8+ chars, include
						upper, lower, number & special char</div>
				</div>

				<!-- Phone -->
				<div class="mb-3">
					<label class="form-label">Phone</label> <input type="text"
						id="phone" name="phone" class="form-control" required>
					<div id="phoneError" class="text-danger small"
						style="display: none">Enter valid 10-digit mobile number</div>
				</div>

				<!-- Email -->
				<div class="mb-3">
					<label class="form-label">Email</label> <input type="email"
						id="email" name="email" class="form-control" required>
					<div id="emailError" class="text-danger small"
						style="display: none">Enter valid email address</div>
				</div>

				<button type="submit" class="btn btn-warning w-100">
					Register</button>
			</form>

			<p class="text-center mt-3">
				Already have an account? <a href="/users/login">Login</a>
			</p>
		</div>
	</div>
</body>
</html>
