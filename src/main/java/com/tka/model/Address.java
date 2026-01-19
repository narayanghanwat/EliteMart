package com.tka.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Entity
@Data
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long addressId;
    private String houseNo; 
    private String street;
    private String city;
    private String state;
    private String pincode;
    private String phone; 
    private boolean defaultAddress; 
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = true)
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "seller_id", nullable = true)
    private Seller seller;
    
    public void setToDefaultAddress(boolean p) {
    		this.defaultAddress = p;
    }
}
