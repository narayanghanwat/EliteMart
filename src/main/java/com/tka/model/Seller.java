package com.tka.model;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import lombok.Data;

@Data
@Entity
public class Seller {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long sellerId;

	private String sellerName;
	private String storeName;

	private String email;
	private String phone;
	private String gstNumber;

	private String password;
	private boolean active = true;

	private Double rating = 0.0;

	private String shippingPreference;

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = true)
	private User user; // link to user

	@OneToMany(mappedBy = "seller", cascade = CascadeType.ALL)
	private List<Address> addresses;

	@OneToOne(mappedBy = "seller", cascade = CascadeType.ALL)
	private BankDetails bankDetails;

}
