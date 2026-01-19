package com.tka.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.tka.model.CartItem;

public interface CartItemRepository extends JpaRepository<CartItem, Long>{
	@Query("SELECT ci FROM CartItem ci WHERE ci.cart.id = :cartId")
	List<CartItem> findItemsByCartId(@Param("cartId") Long cartId);

}
