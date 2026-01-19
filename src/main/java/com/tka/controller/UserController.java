package com.tka.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tka.model.Cart;
import com.tka.model.CartItem;
import com.tka.model.User;
import com.tka.service.CartService;
import com.tka.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/users")
public class UserController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private CartService cartService;
	
	@GetMapping("/")
	public String userList(HttpSession session, Model model) {
		model.addAttribute("users", userService.getAllUsers());
		return "admin-user-list";
	}



	// ------------------ REGISTER ------------------
	@GetMapping("/register")
	public String showRegisterForm(Model model) {
		model.addAttribute("user", new User());
		return "user-register";
	}

	@PostMapping("/save")
	public String saveUser(@ModelAttribute User user, Model model) {
		userService.saveUser(user);
		model.addAttribute("msg", "Saved Successfully");
		return "redirect:/";
	}

	// ------------------ LOGIN ------------------
	@GetMapping("/login")
	public String showLoginForm() {
		return "login";
	}

	// ------------------ LOGIN ------------------
	@GetMapping("/account")
	public String account() {
		return "account";
	}

	@PostMapping("/login")
	public String login(@RequestParam String username, @RequestParam String password, HttpSession session) {

		User user = userService.login(username, password);
		if (user != null) {
			session.setAttribute("loggedInUser", user);
			Cart cart = cartService.getCartByUserId(user.getUserId());
			if (cart == null) {
				return "redirect:/";
			}
			session.setAttribute("cart", cart);
			List<CartItem> cartItems = cartService.getCartItemsByCartId(cart.getCartId());
			session.setAttribute("cartItems", cartItems);
			return "redirect:/";
		}
		return "login"; // back to login page if failed
	}

	// ------------------ LOGOUT ------------------
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	// ------------------ EDIT USER ------------------
	@GetMapping("/edit/{id}")
	public String editUser(@PathVariable Long id, Model model) {
		User user = userService.getUserById(id);
		model.addAttribute("user", user);
		return "edit-profile";
	}

	// ------------------ DELETE USER ------------------
	@GetMapping("/delete")
	public String deleteUser(HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null)
			return "redirect:/users/login";
		return "password-authentication";
	}
	
	@PostMapping("/verify/password")
	public String verifyPassword(@RequestParam long userId,@RequestParam String password,Model model,HttpSession session) {
		if(!password.equals(userService.getUserById(userId).getPassword())) {
			model.addAttribute("msg","Incorrect Password");
			return "password-authentication";
		}
//		System.out.println(userId);
		userService.deleteUser(userId);
		session.invalidate();
		model.addAttribute("msg","Your Account Deleted Successfully");
		return "redirect:/";
	}

	/*
	 * ========================= UPDATE NAME =========================
	 */
	@PostMapping("/edit/updateName")
	public String updateName(@RequestParam String name, RedirectAttributes ra) {

		userService.updateName(name);
		ra.addFlashAttribute("success", "Name updated successfully");
		return "redirect:/users/edit/1";
	}

	/*
	 * ========================= UPDATE NAME =========================
	 */
	@PostMapping("/edit/updateUserName")
	public String updateUserName(@RequestParam String username, RedirectAttributes ra) {

		userService.updateUserName(username);
		ra.addFlashAttribute("success", "Username updated successfully");
		return "redirect:/users/edit/1";
	}

	/*
	 * ========================= UPDATE EMAIL =========================
	 */
	@PostMapping("/edit/updateEmail")
	public String updateEmail(@RequestParam String email, RedirectAttributes ra) {

		userService.updateEmail(email);
		ra.addFlashAttribute("success", "Email updated successfully");
		return "redirect:/users/edit/1";
	}

	/*
	 * ========================= UPDATE PHONE =========================
	 */
	@PostMapping("/edit/updatePhone")
	public String updatePhone(@RequestParam String phone, RedirectAttributes ra) {

		userService.updatePhone(phone);
		ra.addFlashAttribute("success", "Mobile number updated successfully");
		return "redirect:/users/edit/1";
	}

	/*
	 * ========================= UPDATE PASSWORD =========================
	 */
	@PostMapping("/edit/updatePassword")
	public String updatePassword(@RequestParam String oldPassword, @RequestParam String newPassword,
			@RequestParam String confirmPassword, RedirectAttributes ra) {

		if (!newPassword.equals(confirmPassword)) {
			ra.addFlashAttribute("error", "New passwords do not match");
			return "redirect:/users/edit/1";
		}

		boolean success = userService.changePassword(oldPassword, newPassword);

		if (!success) {
			ra.addFlashAttribute("error", "Current password is incorrect");
		} else {
			ra.addFlashAttribute("success", "Password updated successfully");
		}

		return "redirect:/users/edit/1";
	}

}
