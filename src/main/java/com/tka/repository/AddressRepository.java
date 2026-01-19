package com.tka.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tka.model.Address;
import com.tka.model.Seller;
import com.tka.model.User;

@Repository
public interface AddressRepository  extends JpaRepository<Address, Long> {
	  List<Address> findByUser(User user);
	  List<Address> findBySeller(Seller seller);
	  Address findByUserAndDefaultAddressTrue(User user);
	  Address findBySellerAndDefaultAddressTrue(Seller seller);
}
