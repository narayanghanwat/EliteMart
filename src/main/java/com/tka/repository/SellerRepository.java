package com.tka.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tka.model.Seller;
import com.tka.model.User;

@Repository
public interface SellerRepository extends JpaRepository<Seller, Long> {

    // Optional: find seller by user
    Seller findByUserUserId(Long userId);

    // Optional: find by GST number
    Seller findByGstNumber(String gstNumber);
    
    List<Seller> findByUser(User user);

}
