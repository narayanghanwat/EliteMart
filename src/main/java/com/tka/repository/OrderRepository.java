package com.tka.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tka.model.Order;
import com.tka.model.User;

public interface OrderRepository extends JpaRepository<Order, Long>{

	List<Order> findByUserOrderByOrderDateDesc(User user);

}
