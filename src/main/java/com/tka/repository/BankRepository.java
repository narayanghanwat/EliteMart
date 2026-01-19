package com.tka.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tka.model.BankDetails;

@Repository
public interface BankRepository extends JpaRepository<BankDetails, Long>{

}
