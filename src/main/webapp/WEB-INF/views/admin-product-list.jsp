<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<%@ include file="admin-navbar.jsp"%>

<div class="container mt-4">

	<h3 class="mb-3">📦 All Products (Admin)</h3>

	<div class="card shadow">
		<div class="card-body">

			<table class="table table-hover align-middle">
				<thead class="table-dark">
					<tr>
						<th>#</th>
						<th>Image</th>
						<th>Product Name</th>
						<th>Seller</th>
						<th>Price (₹)</th>
						<th>Stock</th>
						<th>Status</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="p" items="${products}" varStatus="i">
						<tr>
							<td>${i.index + 1}</td>

							<!-- Image -->
							<td><img src="${p.image}" width="70"
								height="70" class="img-thumbnail"></td>

							<td>${p.name}</td>

							<!-- Seller name -->
							<td>${p.seller.storeName}</td>

							<td>₹ ${p.price}</td>
							<td>${p.stock}</td>

							<!-- Status -->
							<td><c:choose>
									<c:when test="${p.active}">
										<span class="badge bg-success">Active</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-danger">Disabled</span>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>

					<c:if test="${empty products}">
						<tr>
							<td colspan="8" class="text-center text-muted">No products
								available</td>
						</tr>
					</c:if>

				</tbody>
			</table>

		</div>
	</div>
</div>
