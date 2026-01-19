package com.tka.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.model.Product;
import com.tka.repository.ProductRepository;

@Service
public class ProductService {

	@Autowired 
	private ProductRepository productRepo;
	public void saveProduct(Product product) {
		productRepo.save(product);		
	}
	public List<Product> getAllProducts() {
		return productRepo.findAll();
	}
	public Product getProductById(long productId) {
		return productRepo.getById(productId);
	}
	public List<Product> getProductsBySeller(Long sellerId) {
        return productRepo.findBySeller_sellerId(sellerId);
    }
	public long countProducts() {
		return productRepo.count();
	}
	public void addStock(long productId, int stock) {
		Product p = getProductById(productId);
		p.setStock(p.getStock()+stock);
		productRepo.save(p);
	}
	public void setActive(Long productId, boolean b) {
		 Product product = productRepo.findById(productId)
	                .orElseThrow(() -> new RuntimeException("Product not found"));

	        product.setActive(b);
	        productRepo.save(product);
	}
	
}
