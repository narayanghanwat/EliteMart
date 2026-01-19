package com.tka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tka.model.BankDetails;
import com.tka.model.Seller;
import com.tka.model.User;
import com.tka.service.BankService;
import com.tka.service.SellerService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/bank")
public class BankDetailsController {
	@Autowired
	private SellerService sellerService;

	@Autowired
	private BankService bankservice;

	@GetMapping("/add")
	public String add(Model model) {
		model.addAttribute("bank", new BankDetails());
		return "add-bank-details";
	}

	@PostMapping("/save")
	public String save(BankDetails bank, Model model, HttpSession session) {

		User user = (User) session.getAttribute("loggedInUser");
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (user == null) {
			return "redirect:/users/login";
		} else if (seller == null) {
			bankservice.save(bank, "user", user.getUserId());
		} else {
			bankservice.save(bank, "seller", seller.getSellerId());
		}

		model.addAttribute("seller", sellerService.getSellerById(1));
		return "/redirect:/seller/viewprofile/" + seller.getSellerId();
	}

	@PostMapping("/delete")
	public String delete(@RequestParam long bankId, Model model, HttpSession session) {

//		User user = (User) session.getAttribute("loggedInUser");
//		Seller seller = (Seller) session.getAttribute("loggedInSeller");
//		if (user == null) {
//			return "redirect:/users/login";
//		} else if (seller == null) {
//			return "redirect:/";
//		}
//		else {
//		bankservice.removeById(bankId);
		System.err.println(bankId +" removed bank details");
//		}
		return "redirect:/seller/viewprofile/2";
	}
}
