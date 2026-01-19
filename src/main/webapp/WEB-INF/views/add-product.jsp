
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.product-card {
	border: 1px solid #ddd;
	border-radius: 6px;
}

.product-card h5 {
	color: #111;
}
</style>
</head>
<body>

	<div class="container mt-4 col-md-6">

		<div class="card product-card shadow">
			<div class="card-header bg-warning fw-bold text-center">Add New
				Product</div>

			<div class="card-body">
				<form action="/products/save" method="post"
					enctype="multipart/form-data">

					<!-- Product Name -->
					<div class="mb-3">
						<label class="form-label">Product Name</label> <input type="text"
							name="name" class="form-control" required>
					</div>

					<!-- Description -->
					<div class="mb-3">
						<label class="form-label">Description</label>
						<textarea name="description" class="form-control" rows="3"
							required></textarea>
					</div>

					<!-- Price -->
					<div class="mb-3">
						<label class="form-label">Price (₹)</label> <input type="number"
							name="price" step="0.01" class="form-control" required>
					</div>

					<!-- Stock -->
					<div class="mb-3">
						<label class="form-label">Stock Quantity</label> <input
							type="number" name="stock" class="form-control" required>
					</div>

					<!-- Category -->
					<div class="mb-3">
						<label class="form-label">Category</label> <select name="category"
							class="form-select" required>
							<option value="">Select</option>
							<option>Electronics</option>
							<option>Fashion</option>
							<option>Home</option>
							<option>Books</option>
							<option>Grocery</option>
						</select>
					</div>

					<!-- Product Image -->
					<div class="mb-3">
						<label class="form-label">Product Image URL</label>
						<!-- <input type="file"
							name="image" class="form-control" accept="image/*" required> -->
						<input type="text" name="image" class="form-control" required>
					</div>

					<button class="btn btn-warning w-100">Add Product</button>
				</form>
			</div>
		</div>

	</div>

</body>
</html>