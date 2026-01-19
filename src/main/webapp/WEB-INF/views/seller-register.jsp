
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Seller Registration</title>

<style>
body {
	font-family: Arial, sans-serif;
	background: #f5f5f5;
}

.container {
	width: 420px;
	margin: 50px auto;
	background: #fff;
	padding: 25px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

label {
	font-weight: bold;
	margin-top: 12px;
	display: block;
}

input, select {
	width: 100%;
	padding: 8px;
	margin-top: 5px;
}

.error {
	color: red;
	font-size: 13px;
	display: none;
}

button {
	margin-top: 20px;
	width: 100%;
	padding: 10px;
	background: #ff9900;
	border: none;
	color: white;
	font-size: 16px;
	cursor: pointer;
}
</style>

<script>
	function validateForm() {
		let valid = true;

		// Phone validation
		const phone = document.getElementById("phone").value;
		const phoneError = document.getElementById("phoneError");
		const phoneRegex = /^[6-9]\d{9}$/;

		if (!phoneRegex.test(phone)) {
			phoneError.style.display = "block";
			valid = false;
		} else {
			phoneError.style.display = "none";
		}

		// GST validation
		const gst = document.getElementById("gstNumber").value;
		const gstError = document.getElementById("gstError");
		const gstRegex = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/;

		if (gst && !gstRegex.test(gst)) {
			gstError.style.display = "block";
			valid = false;
		} else {
			gstError.style.display = "none";
		}

		return valid;
	}
</script>

</head>

<body>

	<div class="container mt-5 col-md-5">

		<div class="card shadow">
			<div class="card-header bg-warning fw-bold text-center">Seller
				Registration </div>

			<div class="card-body">
				<form action="/seller/save" method="post"
					onsubmit="return validateForm()">

					<label>Store Name</label> <input type="text" name="storeName"
						required /> <label>GST Number</label> <input type="text"
						id="gstNumber" name="gstNumber" placeholder="22AAAAA0000A1Z5" />
					<div class="error" id="gstError">Invalid GST Number</div>

					<label>Phone Number</label> <input type="text" id="phone"
						name="phone" placeholder="10-digit mobile number" required />
					<div class="error" id="phoneError">Enter valid 10-digit phone
						number</div>

					<label>Shipping Preference</label> <select
						name="shippingPreference">
						<option value="SELF_SHIP">Self Shipping</option>
						<option value="PLATFORM_SHIP">Platform Shipping</option>
					</select>
					<input type = "hidden" name = "userId" value = "${userId}">

					<input type="submit" value = "Register as Seller">
				</form>
			</div>
		</div>

	</div>

	<!-- <div class="container">
		<h2>Seller Registration</h2>

		<form action="/seller/registernew" method="post"
			onsubmit="return validateForm()">

			<label>Store Name</label> <input type="text" name="storeName"
				required /> <label>GST Number</label> <input type="text"
				id="gstNumber" name="gstNumber" placeholder="22AAAAA0000A1Z5" />
			<div class="error" id="gstError">Invalid GST Number</div>

			<label>Phone Number</label> <input type="text" id="phone"
				name="phone" placeholder="10-digit mobile number" required />
			<div class="error" id="phoneError">Enter valid 10-digit phone
				number</div>

			<label>Shipping Preference</label> <select name="shippingPreference">
				<option value="SELF_SHIP">Self Shipping</option>
				<option value="PLATFORM_SHIP">Platform Shipping</option>
			</select>

			<button type="submit">Register as Seller</button>
		</form>
	</div>
	 -->

</body>
</html>
