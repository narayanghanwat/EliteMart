package com.tka.model;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "orders")
public class Order {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long orderId;

	private LocalDateTime orderDate;
	private double totalAmount;
	private String orderStatus;
	private String paymentMode;
	private String status;
	// Payment status: Paid, Pending
	private String paymentStatus;

	@ManyToOne
	private User user;

	/* Delivery address */
	@ManyToOne
	@JoinColumn(name = "address_id")
	private Address address;

	// ORDER ITEMS
	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
	private List<OrderItem> orderItems;

	public void setOrderDate(LocalDateTime now) {
		this.orderDate = now;
	}
}
