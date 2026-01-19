package com.tka.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponentsBuilder;

import com.tka.model.Seller;
import com.tka.model.User;
import com.tka.service.OrderService;
import com.tka.service.ProductService;
import com.tka.service.SellerService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/seller")
public class SellerController {

	@Autowired
	private SellerService sellerService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ProductService productService;

	// Admin – View Sellers
	@GetMapping("/all")
	public String viewSellers(Model model) {

		model.addAttribute("sellers", sellerService.getAllSellers());
		return "seller-list-admin";
	}

	@GetMapping("/register")
	public String register(Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			model.addAttribute("userId", user.getUserId());
			return "seller-register";
		}
		return "redirect:/users/login";
	}

	@PostMapping("/save")
	public String registerSeller(Seller seller, @RequestParam long userId) {
		System.err.println(seller);
		sellerService.registerSeller(seller, userId);
		return "index";
	}

	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/users/login";
		}

		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller == null) {
			return "redirect:/users/login";
		}

		int productCount = productService.getProductsBySeller(seller.getSellerId()).size();
		int orderCount = orderService.getOrdersBySeller(seller.getSellerId()).size();
		double totalRevenue = orderService.getTotalRevenueBySeller(seller.getSellerId());

		model.addAttribute("productCount", productCount);
		model.addAttribute("orderCount", orderCount);
		model.addAttribute("totalRevenue", totalRevenue);

		model.addAttribute("seller", sellerService.getSellerById(seller.getSellerId()));

		return "seller-dashboard";
	}

	@GetMapping("/profile")
	public String profile(Model model, @RequestParam long sellerId) {
		Seller seller = sellerService.getSellerById(sellerId);

		model.addAttribute("seller", seller);
		return "password-authentication";
	}

	@GetMapping("/getprofile/{sellerId}")
	public String getprofile(Model model, @PathVariable long sellerId) {
		Seller seller = sellerService.getSellerById(sellerId);

		model.addAttribute("seller", seller);
		return "seller-dashboard";
	}

	@GetMapping("/viewprofile/{sellerId}")
	public String viewprofile(Model model, @PathVariable long sellerId) {
		Seller seller = sellerService.getSellerById(sellerId);

		model.addAttribute("seller", seller);
		return "seller-profile";
	}

	/*
	 * ========================= Verify PASSWORD =========================
	 */
	@PostMapping("/verify/password")
	public String addPassword(@RequestParam long sellerId, @RequestParam String password, Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/users/login";
		}
		boolean success = sellerService.verifyPassword(sellerId, password);

		model.addAttribute("seller", sellerService.getSellerById(sellerId));
		if (success == false) {
			model.addAttribute("msg", "Wrong Password");
			return "password-authentication";
		}
		session.setAttribute("loggedInSeller", sellerService.getSellerById(sellerId));

		return "redirect:/seller/dashboard";
	}

	@GetMapping("/choose-profile")
	public String chooseProfile(Model model, HttpSession session) {

		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			List<Seller> sellerList = sellerService.getSellerByUser(user);
			if (sellerList != null) {
				model.addAttribute("sellers", sellerList);
				return "seller-choose-profile";
			} else {
				model.addAttribute("seller", new Seller());
				return "seller-register";
			}
		}
		return "redirect:/users/login";

	}

	@GetMapping("/add/email")
	public String addEmail(@RequestParam String email) {

		System.err.println(email);
		return "redirect/:seller/profile";
	}

	@GetMapping("/edit/profile/{sellerId}")
	public String ditProfile(Model model, @PathVariable long sellerId, HttpSession session) {
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller != null) {
			model.addAttribute("seller", sellerService.getSellerById(seller.getSellerId()));
			return "edit-seller-profile";
		}
		return "redirect:/users/login";
	}

	// ------------------ LOGOUT ------------------
	@GetMapping("/logoutseller")
	public String logout(HttpSession session) {
		session.removeAttribute("loggedInSeller");
		return "redirect:/";
	}

	/*
	 * ========================= UPDATE NAME =========================
	 */
	@PostMapping("/updateName")
	public String updateName(@RequestParam String name, RedirectAttributes ra, HttpSession session,
			HttpServletRequest request) {
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller == null) {
			return "redirect:/users/login";
		}
		sellerService.updateName(seller, name);
		ra.addFlashAttribute("success", "Name updated successfully");
		String redirectUrl = UriComponentsBuilder.fromPath("/seller/edit/profile/{id}")
				.buildAndExpand(seller.getSellerId()).toUriString();
		return "redirect:" + redirectUrl;
	}

	/*
	 * ========================= UPDATE NAME =========================
	 */
	@PostMapping("/updateShopName")
	public String updateShopName(@RequestParam String shopname, RedirectAttributes ra, HttpSession session,
			HttpServletRequest request) {
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller == null) {
			return "redirect:/users/login";
		}
		sellerService.updateShopName(seller, shopname);
		ra.addFlashAttribute("success", "Shopname updated successfully");
		String redirectUrl = UriComponentsBuilder.fromPath("/seller/edit/profile/{id}")
				.buildAndExpand(seller.getSellerId()).toUriString();
		return "redirect:" + redirectUrl;
	}

	/*
	 * ========================= Add EMAIL =========================
	 */
	@PostMapping("/add/email")
	public String addEmail(@RequestParam String email, RedirectAttributes ra, HttpSession session,
			HttpServletRequest request) {
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller == null) {
			return "redirect:/users/login";
		}
		sellerService.addEmail(seller, email);
		ra.addFlashAttribute("success", "Email added successfully");
		String redirectUrl = UriComponentsBuilder.fromPath("/seller/edit/profile/{id}")
				.buildAndExpand(seller.getSellerId()).toUriString();
		return "redirect:" + redirectUrl;
	}

	/*
	 * ========================= UPDATE EMAIL =========================
	 */
	@PostMapping("/updateEmail")
	public String updateEmail(@RequestParam String email, RedirectAttributes ra, HttpSession session,
			HttpServletRequest request) {
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller == null) {
			return "redirect:/users/login";
		}
		sellerService.updateEmail(seller, email);
		ra.addFlashAttribute("success", "Email updated successfully");
		String redirectUrl = UriComponentsBuilder.fromPath("/seller/edit/profile/{id}")
				.buildAndExpand(seller.getSellerId()).toUriString();
		return "redirect:" + redirectUrl;
	}

	/*
	 * ========================= UPDATE GST NUMBER =========================
	 */
	@PostMapping("/updategstNumber")
	public String updategstNumber(@RequestParam String gstNumber, RedirectAttributes ra) {

		sellerService.updatePhone(gstNumber);
		ra.addFlashAttribute("success", "GST number updated successfully");
		return "redirect:/seller/edit/profile";
	}

	/*
	 * ========================= UPDATE PHONE =========================
	 */
	@PostMapping("/updatePhone")
	public String updatePhone(@RequestParam String phone, RedirectAttributes ra) {

		sellerService.updatePhone(phone);
		ra.addFlashAttribute("success", "Mobile number updated successfully");
		return "redirect:/seller/edit/profile";
	}

	/*
	 * ========================= UPDATE PHONE =========================
	 */
	@PostMapping("/updateShippingPreference")
	public String updateShippingPreference(@RequestParam String shippingPreference, RedirectAttributes ra) {

		sellerService.updateShippingPreference(shippingPreference);
		ra.addFlashAttribute("success", "ShippingPreference updated successfully");
		return "redirect:/seller/edit/profile";
	}

	/*
	 * ========================= Add PASSWORD =========================
	 */
	@PostMapping("/add/password")
	public String addPassword(@RequestParam String password, @RequestParam String confirmPassword,
			@RequestParam long sellerId, RedirectAttributes ra) {

		if (!password.equals(confirmPassword)) {
			ra.addFlashAttribute("error", "New passwords do not match");
			return "redirect:/seller/edit/profile";
		}

		boolean success = sellerService.addPassword(sellerId, password);

		if (!success) {
			ra.addFlashAttribute("error", "Unable to add password");
		} else {
			ra.addFlashAttribute("success", "Password added successfully");
		}

		return "redirect:/seller/edit/profile";
	}

	@PostMapping("/addnew/password")
	public String addnewPassword(@RequestParam String password, @RequestParam String confirmPassword,
			@RequestParam long sellerId, Model model) {
		System.err.println(sellerId);
		if (!password.equals(confirmPassword)) {
			model.addAttribute("msg", "New passwords do not match");
			return "password-authentication";
		}

		boolean success = sellerService.addPassword(sellerId, password);

		if (!success) {
			model.addAttribute("msg", "Unable to add password");
		} else {
			model.addAttribute("success", "Password added successfully");
		}
		model.addAttribute("seller", sellerService.getSellerById(sellerId));
		return "password-authentication";
	}

	/*
	 * ========================= UPDATE PASSWORD =========================
	 */
	@PostMapping("/updatePassword")
	public String updatePassword(@RequestParam String oldPassword, @RequestParam String newPassword,
			@RequestParam String confirmPassword, RedirectAttributes ra) {

		if (!newPassword.equals(confirmPassword)) {
			ra.addFlashAttribute("error", "New passwords do not match");
			return "redirect:/users/edit/1";
		}

		boolean success = sellerService.changePassword(oldPassword, newPassword);

		if (!success) {
			ra.addFlashAttribute("error", "Current password is incorrect");
		} else {
			ra.addFlashAttribute("success", "Password updated successfully");
		}

		return "redirect:/seller/edit/profile";
	}

}
