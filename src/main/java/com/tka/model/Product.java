package com.tka.model;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long productId;

    @Column(nullable = false)
    private String name;

    @Column(length = 1000)
    private String description;

    @Column(nullable = false)
    private double price;

    @Column(nullable = false)
    private int stock;

    private String category;

    // stores uploaded image filename
    private String image;

    // soft delete / visibility
    private boolean active = true;

    @ManyToOne
    @JoinColumn(name = "seller_id")
    private Seller seller;
}
