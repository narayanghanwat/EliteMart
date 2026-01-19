package com.tka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tka.model.Address;
import com.tka.model.Seller;
import com.tka.model.User;
import com.tka.service.AddressService;
import com.tka.service.SellerService;

import jakarta.servlet.http.HttpSession;

@Controller

public class AddressController {

	@Autowired
	private AddressService addressService;

	@Autowired
	private SellerService sellerService;

	@GetMapping("/your-addresses")
	public String yourAddresses(Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/users/login";
		}
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller != null)
			model.addAttribute("addresses", addressService.getSellerAddresses(seller));
		model.addAttribute("addresses", addressService.getUserAddresses(user));
		return "user-addresses";
	}

	@GetMapping("/add-address")
	public String addAddressPage() {
		return "add-address";
	}

	@PostMapping("/save-address")
	public String saveAddress(Address address, Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (user == null) {
			return "redirect:/users/login";
		} else if (seller == null) {
			addressService.saveAddress(user.getUserId(), address, "user");
		} else {
			addressService.saveAddress(seller.getSellerId(), address, "seller");
		}
		return "address-success";
	}

	@GetMapping("/edit-address")
	public String editAddress(@RequestParam long id, Model model) {
		model.addAttribute("address", addressService.getAddressById(id));
		return "edit-address";
	}

	@PostMapping("/set-default-address/{addressId}")
	public String setDefaultAddress(@PathVariable long addressId, Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		addressService.setDefaultAddress(addressId, user.getUserId());
		model.addAttribute("address", addressService.getAddressById(addressId));
		return "redirect:/your-addresses?alertId=yaab-setDefaultAddressSuccess";
	}
//
//	@PostMapping("/set-default-address")
//	public String setdefaultAddress(@RequestParam long id,Model model, HttpSession session) {
//
//		Seller seller = (Seller) session.getAttribute("loggedInSeller");
//
//		if (seller == null) {
//			return "redirect:/users/login";
//		}
//
//		addressService.setDefaultAddress(id, "seller", seller.getSellerId());
//		model.addAttribute("address", addressService.getAddressById(id));
//		return "redirect:/seller/viewprofile/" + seller.getSellerId();
//	}

	@PostMapping("/update-address")
	public String updateAddress(Address address) {
		addressService.updateAddress(address);
		return "redirect:/your-addresses";
	}

	@GetMapping("/delete-address")
	public String deleteAddress(@RequestParam long id) {
		addressService.deleteAddress(id);
		return "redirect:/your-addresses";
	}

	@PostMapping("/address/delete")
	public String addressDelete(@RequestParam long addressId) {
		addressService.deleteAddress(addressId);
		return "redirect:/";
	}

}
