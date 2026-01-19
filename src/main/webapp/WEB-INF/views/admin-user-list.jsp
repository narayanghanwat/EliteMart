<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<%@ include file="admin-navbar.jsp" %>

<div class="container mt-4">

    <h3 class="mb-3">👥 Users</h3>

    <div class="card shadow">
        <div class="card-body">

            <table class="table table-hover align-middle">
                <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    </tr>
                </thead>

                <tbody>
                <c:forEach var="u" items="${users}" varStatus="i">
                    <tr>
                        <td>${i.index + 1}</td>
                        <td>${u.userId}</td>
                        <td>${u.name}</td>
                        <td>${u.email}</td>
                        <td>${u.phone}</td>                  
                    </tr>
                </c:forEach>

                <c:if test="${empty users}">
                    <tr>
                        <td colspan="8" class="text-center text-muted">
                            No users found
                        </td>
                    </tr>
                </c:if>

                </tbody>
            </table>

        </div>
    </div>
</div>
