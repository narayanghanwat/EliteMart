<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

</head>
<body>

	<div class="container mt-5 col-md-4">
		<div class="card p-4 shadow">
			<h3 class="mb-4 text-center">Sign In</h3>

			<form action="/users/login" method="post">

				<!-- Email -->
				<div class="mb-3">
					<label class="form-label">Username</label> <input type="text"
						name="username" class="form-control" required>
				</div>

				<!-- Password -->
				<div class="mb-3">
					<label class="form-label">Password</label> <input type="password"
						name="password" class="form-control" required>
				</div>

				<!-- Submit Button -->
				<button type="submit" class="btn btn-warning w-100">Login</button>

			</form>

			<p class="text-center mt-3">
				New to EliteMart? <a href="/users/register">Create your
					account</a>
			</p>
		</div>
	</div>

</body>
</html>