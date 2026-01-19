package com.tka.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.model.Cart;
import com.tka.model.CartItem;
import com.tka.model.Product;
import com.tka.model.User;
import com.tka.repository.CartItemRepository;
import com.tka.repository.CartRepository;
import com.tka.repository.UserRepository;

@Service
public class CartService {
	@Autowired
	private CartRepository cartRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private CartItemRepository cartItemRepo;

	public void addProductToCart(User user, Product product, int quantity) {

		// 1️⃣ Fetch existing cart or create new
		Cart cart = cartRepo.findByUser(user);
		if (cart == null) {
			cart = new Cart();
			cart.setUser(user);
		}

		// 2️⃣ Check if product already exists in cart
		CartItem existingItem = cart.getItems().stream()
				.filter(item -> item.getProduct().getProductId().equals(product.getProductId())).findFirst()
				.orElse(null);

		if (existingItem != null) {
			// If exists, increase quantity
			if (existingItem.getQuantity() + quantity <= product.getStock()) {
				existingItem.setQuantity(existingItem.getQuantity() + quantity);
			}
			else 
			{
				existingItem.setQuantity(quantity);
			}
		} else {
			// Else, create new CartItem
			CartItem ci = new CartItem();
			ci.setProduct(product);
			ci.setQuantity(quantity);
			ci.setCart(cart); // important!
			cart.getItems().add(ci); // add to cart's items list
		}

		// 3️⃣ Recalculate total
		cart.calculateTotal();

		// 4️⃣ Save cart (cascade saves CartItems)
		cartRepo.save(cart);

//		System.out.println("Added to cart: " + user.getName() + " | " + product.getName() + " x " + quantity);
	}

	public Cart getCartByUserId(Long userId) {
		return cartRepo.findByUser_UserId(userId);

	}

	public List<CartItem> getCartItemsByCartId(Long cartId) {
		return cartItemRepo.findItemsByCartId(cartId);
	}

	public void removeCartItem(Long cartItemId) {
		CartItem item = cartItemRepo.findById(cartItemId).orElseThrow(() -> new RuntimeException("Item not found"));
		Cart cart = item.getCart();
		cartItemRepo.deleteById(cartItemId);
		recalculateCartTotal(cart);
	}

	public void recalculateCartTotal(Cart cart) {
		double total = 0;

		for (CartItem ci : cart.getItems()) {
			total += ci.getProduct().getPrice() * ci.getQuantity();
		}

		cart.setTotalPrice(total);
		cartRepo.save(cart);
	}
}
