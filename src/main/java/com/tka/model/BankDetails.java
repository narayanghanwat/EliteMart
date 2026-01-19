package com.tka.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "bank_details")
public class BankDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String accountHolderName;
	private String accountNumber;
	private String bankName;
	private String ifscCode;

	@OneToOne
	@JoinColumn(name = "user_id", nullable = true)
	private User user;

	@OneToOne
	@JoinColumn(name = "seller_id", nullable = true)
	private Seller seller;

}
