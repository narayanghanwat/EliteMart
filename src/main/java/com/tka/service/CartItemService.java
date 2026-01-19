package com.tka.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.model.CartItem;
import com.tka.repository.CartItemRepository;

@Service
public class CartItemService {

	@Autowired
	private CartItemRepository cartItemRepo;

	public List<CartItem> findItemsByCartId(long cartId) {
		return cartItemRepo.findItemsByCartId(cartId);
	}

	public CartItem findById(Long cartItemId) {
		return cartItemRepo.findById(cartItemId)
	            .orElseThrow(() -> new RuntimeException("CartItem not found"));
	}

	public void save(CartItem item) {
		 cartItemRepo.save(item);
	}
}
