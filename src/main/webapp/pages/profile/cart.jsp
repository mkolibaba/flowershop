<%@ page import="com.accenture.flowershop.fe.Cart" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.accenture.flowershop.be.entity.user.User" %>
<%@ page import="com.accenture.flowershop.fe.CartItem" %>
<%@ page import="com.accenture.flowershop.fe.Redirect" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setDateHeader("Expires", 0);

    if (Redirect.fromUserPage(request, response)) {
        return;
    }
%>

<!DOCTYPE html>

<html lang="en">
<head>
    <title>Cart</title>

    <meta http-equiv="content-type" content="text/html" charset="UTF-32">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../../css/bootstrap/bootstrap4.min.css"/>
    <link rel="stylesheet" href="../../css/index.css"/>
</head>
<body>

<div class="layer">

    <h2>Cart</h2>
    <br/>

    <input type="button" name="buttonInfo" class="btn btn-outline-info"
           value="Personal Information" onclick="window.location = '/profile/info'"/>
    <input type="button" name="buttonCatalog" class="btn btn-outline-info"
           value="Catalog" onclick="window.location = '/profile/catalog'"/>
    <input type="button" name="buttonOrders" class="btn btn-outline-info"
           value="Orders" onclick="window.location = '/profile/orders'"/>
    <input type="button" name="buttonCart" class="btn btn-primary"
           value="Cart"/>
    <input type="button" name="buttonLogout" class="btn btn-outline-danger"
           value="Logout" onclick="window.location = '/rest/acc/logout'"/>

    <br/><br/>

    <%
        Cart cart = ((Cart) request.getSession(false).getAttribute("cart"));
        if (cart != null && !cart.isEmpty()) {
            BigDecimal total = cart.getTotal();
            User user = (User) request.getSession(false).getAttribute("user");
            int discount = user.getDiscount();
            BigDecimal priceWithDiscount = total.multiply(new BigDecimal(1 - (double) (discount) / 100));
            priceWithDiscount = priceWithDiscount.setScale(2, BigDecimal.ROUND_HALF_UP);
    %>
    <form action="/profile/cart" method="post">
        <table class="table">
            <tr>
                <th>Name</th>
                <th>Amount, pcs.</th>
                <th>Price, RUB</th>
                <th></th>
            </tr>
            <% for (CartItem item : cart) { %>
                <tr>
                    <td><%= item.getFlower().getName() %></td>
                    <td><%= item.getAmount()           %></td>
                    <td><%= item.getTotal()            %></td>
                    <td>
                        <input type="submit" class="btn btn-outline-danger btn-sm"
                               value="Remove" name='<%= "remove" + item.getFlower().getName() %>'/>
                    </td>
                </tr>
            <% } %>
        </table>

        <br/>Total price without discount: <%= total %> RUB
        <br/>Your discount: <%= discount %>%
        <br/>Total price with discount: <%= priceWithDiscount %> RUB

        <br/><br/>

        <input type="submit" class="btn btn-primary" value="Order" name="buttonOrder"/>

    </form>

    <% } else { %>
    There is no items in your cart :(
    <% } %>

</div>

</body>
</html>