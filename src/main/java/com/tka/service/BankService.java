package com.tka.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.model.BankDetails;
import com.tka.repository.BankRepository;

@Service
public class BankService {

	@Autowired
	private BankRepository bankRepo;

	@Autowired
	private SellerService sellerService;

	@Autowired
	private UserService userService;

	public void save(BankDetails bank, String role, Long id) {
		if (role.equals("user")) {
		bank.setUser(userService.getUserById(id));
		}

		if (role.equals("seller")) {
		bank.setSeller(sellerService.getSellerById(id));
		}
		bankRepo.save(bank);
	}

	public void removeById(long bankId) {
		BankDetails bd = bankRepo.getById(bankId);
		System.err.println(bd);
		bankRepo.delete(bd);
	}

}
