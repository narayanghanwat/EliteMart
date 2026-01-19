<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Bank Details</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
	function validateBankForm() {
		let valid = true;

		// Account holder name
		const accName = document.getElementById("accountHolderName").value
				.trim();
		const accNameError = document.getElementById("accNameError");
		if (accName.length < 3) {
			accNameError.style.display = "block";
			valid = false;
		} else {
			accNameError.style.display = "none";
		}

		// Account number
		const accNumber = document.getElementById("accountNumber").value.trim();
		const accNumberError = document.getElementById("accNumberError");
		const accNumberRegex = /^[0-9]{9,18}$/;
		if (!accNumberRegex.test(accNumber)) {
			accNumberError.style.display = "block";
			valid = false;
		} else {
			accNumberError.style.display = "none";
		}

		// IFSC
		const ifsc = document.getElementById("ifscCode").value.trim()
				.toUpperCase();
		const ifscError = document.getElementById("ifscError");
		const ifscRegex = /^[A-Z]{4}0[A-Z0-9]{6}$/;
		if (!ifscRegex.test(ifsc)) {
			ifscError.style.display = "block";
			valid = false;
		} else {
			ifscError.style.display = "none";
		}

		// Bank name
		const bankName = document.getElementById("bankName").value.trim();
		const bankNameError = document.getElementById("bankNameError");
		if (bankName.length < 3) {
			bankNameError.style.display = "block";
			valid = false;
		} else {
			bankNameError.style.display = "none";
		}

		return valid;
	}
</script>

</head>
<body>

	<div class="container mt-5 col-md-5">
		<div class="card p-4 shadow">
			<h3 class="mb-4 text-center">Add Bank Details</h3>

			<form action="${pageContext.request.contextPath}/bank/save"
				method="post" onsubmit="return validateBankForm()">

				<!-- Account Holder Name -->
				<div class="mb-3">
					<label class="form-label">Account Holder Name</label> <input
						type="text" id="accountHolderName" name="accountHolderName"
						class="form-control" required>
					<div id="accNameError" class="text-danger small"
						style="display: none">Name must be at least 3 characters</div>
				</div>

				<!-- Account Number -->
				<div class="mb-3">
					<label class="form-label">Account Number</label> <input type="text"
						id="accountNumber" name="accountNumber" class="form-control"
						required>
					<div id="accNumberError" class="text-danger small"
						style="display: none">Account number must be 9-18 digits</div>
				</div>

				<!-- Bank Name -->
				<div class="mb-3">
					<label class="form-label">Bank Name</label> <input type="text"
						id="bankName" name="bankName" class="form-control" required>
					<div id="bankNameError" class="text-danger small"
						style="display: none">Enter valid bank name</div>
				</div>

				<!-- IFSC Code -->
				<div class="mb-3">
					<label class="form-label">IFSC Code</label> <input type="text"
						id="ifscCode" name="ifscCode" class="form-control" required>
					<div id="ifscError" class="text-danger small" style="display: none">
						Invalid IFSC code (Ex: ABCD0123456)</div>
				</div>

				<!-- Hidden IDs 
				<c:if test="${not empty seller}">
					<input type="hidden" name="sellerId" value="${seller.sellerId}">
				</c:if>

				<c:if test="${not empty user}">
					<input type="hidden" name="userId" value="${user.userId}">
				</c:if>                                                              -->

				<button type="submit" class="btn btn-warning w-100">Save
					Bank Details</button>

			</form>
		</div>
	</div>

</body>
</html>
