package com.tka.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tka.model.Address;
import com.tka.model.Cart;
import com.tka.model.CartItem;
import com.tka.model.Order;
import com.tka.model.OrderItem;
import com.tka.model.Product;
import com.tka.model.Seller;
import com.tka.model.User;
import com.tka.repository.ProductRepository;
import com.tka.service.AddressService;
import com.tka.service.CartItemService;
import com.tka.service.CartService;
import com.tka.service.OrderService;
import com.tka.service.SellerService;
import com.tka.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller()
@RequestMapping("order")
public class OrderController {
	@Autowired
	private OrderService orderService;

	@Autowired
	private AddressService addressService;

	@Autowired
	private UserService userService;

	@Autowired
	private ProductRepository productRepo;

	@Autowired
	private SellerService sellerService;

	@Autowired
	private CartService cartService;

	@Autowired
	private CartItemService cartItemService;

	@GetMapping("/all")
	public String orderList(HttpSession session, Model model) {
		model.addAttribute("orders", orderService.getAllOrders());
		return "admin-order-list";
	}

	@PostMapping("/buy/{productId}/{qty}")
	public String buy(@PathVariable long productId,@PathVariable int qty, Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/users/login";
		}
		Product product = productRepo.getById(productId);
		List<Address> addressList = addressService.getUserAddresses(user);
		model.addAttribute("addresses", addressList);
		model.addAttribute("totalAmount", product.getPrice() * qty);
		model.addAttribute("product", product);
		model.addAttribute("quantity" , qty);
		return "checkout";
	}

	@GetMapping("/checkout")
	public String checkout() {
		return "checkout";
	}

	@PostMapping("/place")
	public String placeOrder(@RequestParam Long addressId, @RequestParam Long productId,
			@RequestParam String paymentMode, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/users/login";
		}
		orderService.buyProduct(user.getUserId(), productId, addressId, paymentMode);
		return "redirect:/order/success";
	}

	@PostMapping("/checkout")
	public String checkoutOrder(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/users/login";
		}
		Cart cart = cartService.getCartByUserId(user.getUserId());
		if (cart == null || cart.getItems().isEmpty()) {
			return "redirect:/cart/";
		}

		List<CartItem> cartItems = cartItemService.findItemsByCartId(cart.getCartId());
		List<Address> addressList = addressService.getUserAddresses(user);
		model.addAttribute("addresses", addressList);
		model.addAttribute("cart", cart);
		model.addAttribute("user", user);
		model.addAttribute("cartItems", cartItems);
		return "checkout";
	}

	@PostMapping("/placeorder")
	public String placeOrder(HttpSession session, @RequestParam Long addressId, @RequestParam String paymentMode) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/users/login";
		}

		orderService.placeOrder(user, addressId, paymentMode);

		// Reset cart count
		session.setAttribute("cartCount", 0);

		return "redirect:/order/success";
	}

	@GetMapping("/success")
	public String orderSuccessPage() {
		return "order-success";
	}

	@GetMapping("/my")
	public String myOrders(Model model, HttpSession session) {
		User u = (User) session.getAttribute("loggedInUser");
		if (u == null) {
			return "login";
		}
		List<Order> orders = orderService.getOrdersByUser(u);
		model.addAttribute("orders", orders);
		return "my-orders";
	}

	@GetMapping("/list")
	public String sellerOrders(Model model, HttpSession session) {

		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller == null) {
			return "login";
		}
		// Fetch all order items for seller's products
		List<OrderItem> sellerOrderItems = orderService.findByProductSeller(seller);
		model.addAttribute("sellerOrderItems", sellerOrderItems);
		return "seller-orders";
	}

	@GetMapping("/item/{id}/{productId}")
	public String orderItems(Model model, @PathVariable long id, @PathVariable long productId) {
		Order order = orderService.getOrderById(id);
		OrderItem item = orderService.getOrderItemByProductId(productId);

		LocalDate orderDate = item.getOrder().getOrderDate().toLocalDate();
		LocalDate returnCloseDate = orderDate.plusDays(15);

		model.addAttribute("item", item);
		model.addAttribute("orderDate", orderDate);
		model.addAttribute("returnCloseDate", returnCloseDate);
		return "order-item-details";
	}

	@GetMapping("/details/{orderId}")
	public String orderDetails(@PathVariable long orderId, Model model) {
		Order order = orderService.getOrderById(orderId);
		model.addAttribute("order", order);
		return "order-details";
	}
}
