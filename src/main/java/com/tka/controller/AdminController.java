package com.tka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tka.model.User;
import com.tka.service.OrderService;
import com.tka.service.ProductService;
import com.tka.service.SellerService;
import com.tka.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private UserService userService;

	@Autowired
	private SellerService sellerService;

	@Autowired
	private ProductService productService;

	@Autowired
	private OrderService orderService;

	// 1️⃣ Admin Dashboard
	@GetMapping("/dashboard")
	public String adminDashboard(Model model) {
		model.addAttribute("userCount", userService.countUsers());
		model.addAttribute("sellerCount", sellerService.countSellers());
		model.addAttribute("productCount", productService.countProducts());
		model.addAttribute("orderCount", orderService.countOrders());
		return "admin-dashboard";
	}

	
	
	
	

}
