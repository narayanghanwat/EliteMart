package com.tka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tka.model.Product;
import com.tka.model.Seller;
import com.tka.service.ProductService;
import com.tka.service.SellerService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/products")
public class ProductController {

	@Autowired
	private ProductService productService;

	@Autowired
	private SellerService sellerService;

	// Show Add Product Page
	@GetMapping("/add")
	public String showAddProductPage(HttpSession session) {
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller == null) {
			return "redirect:/users/login";
		}
		return "add-product";
	}

	/*
	 * ========================= SAVE PRODUCT ==========================
	 */
	@PostMapping("/save")
	public String saveProduct(@ModelAttribute Product product, HttpSession session) {
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller == null) {
			return "redirect:/users/login";
		}
		product.setSeller(seller);
		product.setActive(true);
		productService.saveProduct(product);
		return "redirect:/products/list";
	}

	/*
	 * ========================= PRODUCT LIST (SELLER) ==========================
	 */
	@GetMapping("/list")
	public String sellerProducts(Model model, HttpSession session) {
		Seller seller = (Seller) session.getAttribute("loggedInSeller");
		if (seller == null) {
			return "redirect:/users/login";
		}
		model.addAttribute("products", productService.getProductsBySeller(seller.getSellerId()));
		return "product-list";
	}

	@GetMapping("/")
	public String allProducts(Model model) {
		model.addAttribute("products", productService.getAllProducts());
		return "admin-product-list";
	}

	@GetMapping("/{productId}")
	public String viewProduct(@PathVariable long productId, Model model) {
		model.addAttribute("product", productService.getProductById(productId));
		return "product-details";
	}

	/*
	 * ========================= add stock =========================
	 */
	@PostMapping("/add-stock")
	public String addStock(@RequestParam long productId, @RequestParam int stock) {
		System.out.println(productId);
		productService.addStock(productId,stock);
		return "redirect:/products/list";
	}
		
	 // ENABLE PRODUCT
    @GetMapping("/enable/{productId}")
    public String enableProduct(@PathVariable Long productId,
                                HttpServletRequest request) {
    		
        productService.setActive(productId, true);

        // redirect to previous page
        return "redirect:" + request.getHeader("Referer");
    }

    // DISABLE PRODUCT
    @GetMapping("/disable/{productId}")
    public String disableProduct(@PathVariable Long productId,
                                 HttpServletRequest request) {

        productService.setActive(productId, false);

        // redirect to previous page
        return "redirect:" + request.getHeader("Referer");
    }
}
