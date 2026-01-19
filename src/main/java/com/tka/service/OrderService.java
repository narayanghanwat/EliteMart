package com.tka.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.model.Address;
import com.tka.model.Cart;
import com.tka.model.CartItem;
import com.tka.model.Order;
import com.tka.model.OrderItem;
import com.tka.model.Product;
import com.tka.model.Seller;
import com.tka.model.User;
import com.tka.repository.AddressRepository;
import com.tka.repository.CartRepository;
import com.tka.repository.OrderItemRepository;
import com.tka.repository.OrderRepository;
import com.tka.repository.ProductRepository;
import com.tka.repository.UserRepository;

@Service
public class OrderService {
	@Autowired
	private OrderRepository orderRepo;

	@Autowired
	private ProductRepository productRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private OrderItemRepository oiRepo;

	@Autowired
	private CartRepository cartRepo;

	@Autowired
	private AddressRepository addressRepo;

	public void buyProduct(long userId, long id, Long addressId, String paymentMode) {
		Address address = addressRepo.findById(addressId).orElseThrow(() -> new RuntimeException("Address not found"));

		Product product = productRepo.getById(id);
		product.setStock(product.getStock() - 1);
		productRepo.save(product);
		User user = userRepo.getById(userId);
		Order order = new Order();
		order.setOrderDate(LocalDateTime.now());
		order.setOrderStatus("PLACED");
		order.setTotalAmount(product.getPrice());
		order.setUser(user);
		order.setPaymentMode(paymentMode);
		order.setAddress(address);

		OrderItem orderitem = new OrderItem();
		orderitem.setOrder(order);
		orderitem.setPrice(product.getPrice());
		orderitem.setQuantity(1);
		orderitem.setProduct(product);
		orderRepo.save(order);
		oiRepo.save(orderitem);
	}

	public void placeOrder(User user, Long addressId, String paymentMode) {
		Cart cart = cartRepo.findByUser(user);
		if (cart == null || cart.getItems().isEmpty())
			return;

		Address address = addressRepo.findById(addressId).orElseThrow(() -> new RuntimeException("Address not found"));

		Order order = new Order();
		order.setUser(user);
		order.setOrderDate(LocalDateTime.now());
		order.setTotalAmount(cart.getTotalPrice());
		order.setOrderStatus("PLACED");
		order.setPaymentMode(paymentMode);
		order.setAddress(address);

		orderRepo.save(order);

		for (CartItem ci : cart.getItems()) {
			OrderItem oi = new OrderItem();
			oi.setOrder(order);
			oi.setProduct(ci.getProduct());
			oi.setQuantity(ci.getQuantity());
			oi.setPrice(ci.getProduct().getPrice());

			oiRepo.save(oi);

			Product p = ci.getProduct();
			int qty = ci.getQuantity();
			p.setStock(p.getStock() - qty);
			productRepo.save(p);
		}

		// Clear cart
		cart.getItems().clear();
		cart.setTotalPrice(0);
		cartRepo.save(cart);
	}
	
	public List<Order> 	getAllOrders() {
		return orderRepo.findAll();
	}

	public long countOrders() {
		return orderRepo.count();
	}
	public List<Order> getOrdersByUser(User user) {
		return orderRepo.findByUserOrderByOrderDateDesc(user);
	}

	public Order getOrderById(long orderId) {
		return orderRepo.getById(orderId);
	}

	public OrderItem getOrderItemById(long orderItemId) {
		return oiRepo.getById(orderItemId);
	}

	public List<OrderItem> getOrderItemsByProductId(Long productId) {
		return oiRepo.findByProduct_ProductId(productId);
	}

	public List<OrderItem> findByProductSeller(Seller seller) {
		return oiRepo.findByProductSeller(seller);
	}

	// Seller orders
	public List<OrderItem> getOrdersBySeller(Long sellerId) {
		return oiRepo.findByProduct_Seller_SellerId(sellerId);
	}

	// Seller revenue
	public double getTotalRevenueBySeller(Long sellerId) {
		return oiRepo.findByProduct_Seller_SellerId(sellerId).stream()
				.mapToDouble(oi -> oi.getPrice() * oi.getQuantity()).sum();
	}

	public OrderItem getOrderItemByProductId(Long productId) {
		return oiRepo.findTopByProduct_ProductIdOrderByOrder_OrderDateDesc(productId);
	}

}
