package com.tka.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tka.model.Cart;
import com.tka.model.CartItem;
import com.tka.model.Product;
import com.tka.model.User;
import com.tka.service.CartItemService;
import com.tka.service.CartService;
import com.tka.service.OrderService;
import com.tka.service.ProductService;
import com.tka.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {
	@Autowired
	private ProductService productService;

	@Autowired
	private CartService cartService;

	@Autowired
	private CartItemService cartItemService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private UserService userService;

	// 1️⃣ View Cart
	@GetMapping("/")
	public String viewCart(Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/users/login";
		}
		Cart cart = cartService.getCartByUserId(user.getUserId());
		if (cart == null) {
			return "cart";
		}
		model.addAttribute("cart", cart);
		List<CartItem> cartItems = cartService.getCartItemsByCartId(cart.getCartId());
		model.addAttribute("cartItems", cartItems);
		return "cart";
	}
	
	@PostMapping("/update-ajax")
	@ResponseBody
	public Map<String, Object> updateCartAjax(
	        @RequestParam Long cartItemId,
	        @RequestParam int quantity) {

	    CartItem item = cartItemService.findById(cartItemId);

	    int stock = item.getProduct().getStock();
	    if (quantity > stock) {
	        quantity = stock;
	    }

	    item.setQuantity(quantity);
	    cartItemService.save(item);

	    Cart cart = item.getCart();
	    cartService.recalculateCartTotal(cart);

	    double itemTotal =
	            item.getProduct().getPrice() * quantity;

	    Map<String, Object> response = new HashMap<>();
	    response.put("itemTotal", itemTotal);
	    response.put("cartTotal", cart.getTotalPrice());

	    return response;
	}


	// 2️⃣ Add to Cart
	@PostMapping("/add/{productId}")
	public String addToCart(@PathVariable Long productId, int quantity,
			HttpSession session) {
		Product product = productService.getProductById(productId);
		if (product == null)
			return "redirect:/"; // product not found

		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/users/login";
		}
		cartService.addProductToCart(user, product, quantity);
		return "redirect:/cart/";
	}

	// 4️⃣ Remove Item
	@GetMapping("/remove/{cartItemId}")
	public String removeCartItem(@PathVariable Long cartItemId, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null)
			return "redirect:/users/login";
		cartService.removeCartItem(cartItemId);
		return "redirect:/cart/";
	}
}
