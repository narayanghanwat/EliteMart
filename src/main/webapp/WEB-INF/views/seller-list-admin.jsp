<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="admin-navbar.jsp" %>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<div class="container mt-4">

	<h3 class="mb-3">Seller Management</h3>

	<div class="card shadow-sm">
		<div class="card-body">

			<table class="table table-hover align-middle">
				<thead class="table-dark">
					<tr>
						<th>#</th>
						<th>Shop Name</th>
						<th>Owner</th>
						<th>Email</th>
						<th>Phone</th>
						<th>Rating</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="seller" items="${sellers}" varStatus="status">
						<tr>
							<td>${status.index + 1}</td>
							<td>${seller.storeName}</td>
							<td>${seller.user.name}</td>
							<td>${seller.user.email}</td>
							<td>${seller.phone}</td>
							<td><span class="badge bg-info"> ${seller.rating} </span></td>



						</tr>
					</c:forEach>

					<c:if test="${empty sellers}">
						<tr>
							<td colspan="8" class="text-center text-muted">No sellers
								found</td>
						</tr>
					</c:if>
				</tbody>
			</table>

		</div>
	</div>

</div>
