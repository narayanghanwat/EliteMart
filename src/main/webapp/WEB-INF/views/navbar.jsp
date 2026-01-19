<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.amazon-navbar {
	background-color: #131921;
	color: white;
	font-size: 14px;
	height: 60px;
}

.amazon-logo {
	color: #ff9900;
	font-weight: bold;
	font-size: 22px;
	text-decoration: none;
}

.amazon-logo span {
	color: white;
}

.search-select {
	max-width: 60px;
	border-radius: 4px 0 0 4px;
	font-size: 13px;
}

.search-input {
	border-radius: 0;
	height: 40px;
}

.search-btn {
	border-radius: 0 4px 4px 0;
	background-color: #febd69;
	border: none;
	height: 40px;
	width: 45px;
}

.search-btn:hover {
	background-color: #f3a847;
}

.nav-small {
	font-size: 12px;
	color: #ccc;
}

.dropdown-hover:hover .dropdown-menu {
	display: block;
	margin-top: 0;
}

.dropdown-menu {
	min-width: 200px;
	font-size: 14px;
}

.cart-count {
	background-color: orange;
	color: black;
	font-size: 12px;
	border-radius: 50%;
	padding: 2px 6px;
	position: absolute;
	top: -6px;
	left: 18px;
	font-weight: bold;
}
</style>

<nav class="navbar amazon-navbar px-3 d-flex align-items-center">

	<!-- Logo -->
	<a href="/" class="amazon-logo me-3"> Elite<span>Mart</span>
	</a>

	<!-- Deliver To -->
	<div class="me-3">
		<div class="nav-small">Deliver to</div>
		<strong> <c:choose>
				<c:when test="${not empty sessionScope.loggedInUser}">
					${sessionScope.loggedInUser.name}
				</c:when>
				<c:otherwise>
					India
				</c:otherwise>
			</c:choose>
		</strong>
	</div>

	<!-- Search -->
	<form class="d-flex flex-grow-1 mx-3" action="/products/search"
		method="get">
		<select class="form-select search-select">
			<option>All</option>
			<option>Books</option>
			<option>Electronics</option>
		</select> <input class="form-control search-input" type="search" name="keyword"
			placeholder="Search EliteMart">

		<button class="search-btn" type="submit">
			<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
				fill="black" viewBox="0 0 16 16">
				<path
					d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85z" />
			</svg>
		</button>
	</form>

	<!-- Account & Lists -->
	<div class="dropdown dropdown-hover me-4">
		<a href="#" class="text-white text-decoration-none">
			<div class="nav-small">
				Hello,
				<c:choose>
					<c:when test="${not empty sessionScope.loggedInUser}">
						${sessionScope.loggedInUser.name}
					</c:when>
					<c:otherwise>
						Sign in
					</c:otherwise>
				</c:choose>
			</div> <strong>Account & Lists </strong>
		</a>

		<ul class="dropdown-menu">
			<c:choose>
				<c:when test="${not empty sessionScope.loggedInUser}">
					<li><a class="dropdown-item" href="/users/account">Your
							Account</a></li>
					<li><a class="dropdown-item" href="/order/my">Your
							Orders</a></li>
					<li><a class="dropdown-item" href="/seller/choose-profile">Your
							Seller Account</a></li>

					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="/users/logout">Logout</a></li>
				</c:when>

				<c:otherwise>
					<li><a class="dropdown-item" href="/users/login">Sign In</a></li>
					<li><a class="dropdown-item" href="/users/register">Register</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>

	<!-- Orders -->
	<div class="me-4">
		<div class="nav-small">Returns</div>
		<strong><a href="/order/my"
			class="text-white text-decoration-none">& Orders</a></strong>
	</div>

	<!-- Cart -->
	<a href="/cart/"
		class="text-white fw-bold position-relative text-decoration-none">
		<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26"
			fill="white" viewBox="0 0 16 16" class="me-1">
	<path
				d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5z" />
	<path
				d="M5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4z" />
</svg> Cart
	</a>

</nav>
