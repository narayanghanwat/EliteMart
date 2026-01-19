package com.tka.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.model.Seller;
import com.tka.model.User;
import com.tka.repository.SellerRepository;
import com.tka.repository.UserRepository;

@Service
public class SellerService {

	@Autowired
	private UserService userService;
	@Autowired
	private UserRepository userRepo;

	@Autowired
	private SellerRepository sellerRepo;

	public void registerSeller(Seller seller, long userId) {
		User user = userService.getUserById(userId);
		seller.setUser(user);
		seller.setSellerName(user.getName());
		user.getSellers().add(seller);

		userRepo.save(user); 
	}

	public Seller getSellerById(long id) {
		return sellerRepo.getById(id);
	}

	public void updateName(Seller seller, String name) {
		Seller s = sellerRepo.getById(seller.getSellerId());
		s.setSellerName(name);
		sellerRepo.save(s);
	}

	public void updateEmail(Seller s,String email) {
		Seller seller = sellerRepo.getById(s.getSellerId());
		seller.setEmail(email);
		sellerRepo.save(seller);
	}

	public void updatePhone(String phone) {
		Seller seller = sellerRepo.getById(2L);
		seller.setPhone(phone);
		sellerRepo.save(seller);
	}

	public boolean changePassword(String oldPassword, String newPassword) {
		Seller seller = sellerRepo.getById(2L);
		// plain password comparison
		if (!seller.getPassword().equals(oldPassword)) {
			return false;
		}

		seller.setPassword(newPassword);
		sellerRepo.save(seller);
		return true;
	}

	public void updateShopName(Seller s,String shopname) {
		Seller seller = sellerRepo.getById(s.getSellerId());
		seller.setStoreName(shopname);
		sellerRepo.save(seller);
	}

	public boolean addPassword(long sellerId, String newPassword) {
		Seller seller = sellerRepo.getById(sellerId);
		seller.setPassword(newPassword);
		sellerRepo.save(seller);
		return true;
	}

	public void addEmail(Seller s,String email) {
		Seller seller = sellerRepo.getById(s.getSellerId());
		seller.setEmail(email);
		sellerRepo.save(seller);
	}

	public void updateShippingPreference(String shippingPreference) {
		Seller seller = sellerRepo.getById(1L);
		seller.setShippingPreference(shippingPreference);
		sellerRepo.save(seller);
	}

	public List<Seller> getSellerByUser(User user) {
		return sellerRepo.findByUser(user);
	}

	public boolean verifyPassword(long sellerId, String password) {
		Seller seller = sellerRepo.getById(sellerId);
//		System.out.println(seller.getPassword());
		if (!seller.getPassword().equals(password)) {
			return false;
		}
		return true;
	}

	public List<Seller> getAllSellers() {
		return sellerRepo.findAll();
	}
	
	public long countSellers() {
		return sellerRepo.count();
	}
}
