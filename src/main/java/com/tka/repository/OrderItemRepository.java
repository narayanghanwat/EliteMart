package com.tka.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.tka.model.OrderItem;
import com.tka.model.Seller;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
	
	@Query("SELECT oi FROM OrderItem oi WHERE oi.product.seller = :seller ORDER BY oi.order.orderDate DESC")
    List<OrderItem> findByProductSeller(@Param("seller") Seller seller);
	
	List<OrderItem> findByProduct_ProductId(Long productId);
	
    OrderItem findTopByProduct_ProductIdOrderByOrder_OrderDateDesc(Long productId);
    
 // Get all items for a specific order
 	List<OrderItem> findByOrder_OrderId(Long orderId);

 	// Get all order items of a seller (important for seller orders)
 	List<OrderItem> findByProduct_Seller_SellerId(Long sellerId);

}
