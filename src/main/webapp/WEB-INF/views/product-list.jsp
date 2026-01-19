<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="seller-navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product List</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
a, a:visited, a:hover, a:active {
	color: inherit;
	text-decoration: none;
}
</style>
<script>
	function enableAdd(fieldId) {
		document.getElementById(fieldId).style.display = "flex";
	}
</script>

</head>
<body>
	<div class="container mt-4">

		<h4>My Products</h4>
		<hr>

		<c:if test="${empty products}">
			<div class="alert alert-info">
				You have not added any products yet. <a href="/products/add"
					class="btn btn-sm btn-warning ms-2">Add Product</a>
			</div>
		</c:if>

		<c:if test="${not empty products}">
			<div class="table-responsive">
				<table class="table table-hover align-middle">
					<thead class="table-dark">
						<tr>
							<th>#</th>
							<th>Image</th>
							<th>Name</th>
							<th>Category</th>
							<th>Price (₹)</th>
							<th>Stock</th>
							<th>Action</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="p" items="${products}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>

								<td><a href="/products/${p.productId}"> <c:if
											test="${not empty p.image}">
											<img src="${p.image}" alt="${p.name}"
												width="80" height="80" class="img-thumbnail">
										</c:if> <c:if test="${empty p.image}">
											<span class="text-muted">No Image</span>
										</c:if>
								</a></td>

								<td><a href="/products/${p.productId}"> ${p.name}</a></td>
								<td>${p.category}</td>
								<td>${p.price}</td>
								<td>${p.stock}</td>
								<td>

									<div style="display: flex; align-items: center; gap: 5px;">
										<button class="btn btn-sm btn-success"
											onclick="enableAdd('stock${p.productId}')">Add Stock</button>

										<form id="stock${p.productId}" action="/products/add-stock"
											method="post"
											style="display: none; flex-direction: row; gap: 5px;">
											<input type="number" name="stock" required> <input
												type="hidden" name="productId" value="${p.productId}">
											<button class="btn btn-sm btn-success">Add</button>
										</form>
									</div>
								</td>
								<!-- STATUS BADGE -->
								<td class="text-center"><c:choose>
										<c:when test="${p.active}">
											<span class="badge bg-success">ACTIVE</span>
										</c:when>
										<c:otherwise>
											<span class="badge bg-secondary">INACTIVE</span>
										</c:otherwise>
									</c:choose></td>

								<!-- ENABLE / DISABLE BUTTON -->
								<td class="text-center"><c:choose>
										<c:when test="${p.active}">
											<a href="/products/disable/${p.productId}"
												class="btn btn-sm btn-danger"> Disable </a>
										</c:when>
										<c:otherwise>
											<a href="/products/enable/${p.productId}"
												class="btn btn-sm btn-success"> Enable </a>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
		</c:if>

		<a href="/products/add" class="btn btn-warning mt-3">Add New
			Product</a>

	</div>

</body>
</html>