package com.tka.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.model.Address;
import com.tka.model.Seller;
import com.tka.model.User;
import com.tka.repository.AddressRepository;

@Service
public class AddressService {
	@Autowired
	private AddressRepository addressRepository;

	@Autowired
	private UserService userService;
	@Autowired
	private SellerService sellerService;

	public List<Address> getUserAddresses(User user) {
		return addressRepository.findByUser(user);
	}

	public List<Address> getSellerAddresses(Seller seller) {
		return addressRepository.findBySeller(seller);
	}

	public void saveAddress(Long id, Address address, String role) {
		if (role.equals("user")) {
			User user = userService.getUserById(id);
			if (address.isDefaultAddress()) {
				Address defaultAddress = addressRepository.findByUserAndDefaultAddressTrue(user);
				if (defaultAddress != null)
					defaultAddress.setDefaultAddress(false);
			}
			address.setUser(user); // FK SET
		}
		if (role.equals("seller")) {
			Seller seller = sellerService.getSellerById(id);
			if (address.isDefaultAddress()) {
				Address defaultAddress = addressRepository.findBySellerAndDefaultAddressTrue(seller);
				if (defaultAddress != null)
					defaultAddress.setDefaultAddress(false);
			}
			address.setSeller(seller);
		}
		addressRepository.save(address);
	}

	public Address getAddressById(long id) {
		return addressRepository.findById(id).orElse(null);
	}

	public void updateAddress(Address address) {
		Address existing = addressRepository.findById(address.getAddressId()).orElse(null);

		if (existing != null) {
			existing.setHouseNo(address.getHouseNo());
			existing.setStreet(address.getStreet());
			existing.setCity(address.getCity());
			existing.setState(address.getState());
			existing.setPincode(address.getPincode());
			existing.setPhone(address.getPhone());
			existing.setDefaultAddress(address.isDefaultAddress());
			addressRepository.save(existing);
		}
	}

	public void deleteAddress(long id) {
		addressRepository.deleteById(id);
	}

	public void setDefaultAddress(long addressId, long id) {
		Address address = addressRepository.findById(addressId).orElse(null);
		User user = userService.getUserById(id);
		Address defaultAddress = addressRepository.findByUserAndDefaultAddressTrue(user);
		
		if (defaultAddress != null) {
			System.out.println("def address id " + defaultAddress.getAddressId());
			defaultAddress.setToDefaultAddress(false);
			addressRepository.save(defaultAddress);
		}
		address.setToDefaultAddress(true);
		addressRepository.save(address);
	}
}
