package com.tka.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.model.User;
import com.tka.repository.UserRepository;

@Service
public class UserService {
	@Autowired
	UserRepository userRepo;

	public void saveUser(User user) {
		userRepo.save(user);
	}

	public User getUserById(long id) {
		return userRepo.getById(id);
	}

	public void deleteUser(Long id) {
		userRepo.deleteById(id);
	}

	public void updateName(String name) {
		long id = 1;
		User user = userRepo.getById(id);
		user.setName(name);
		userRepo.save(user);
	}

	public void updateEmail(String email) {
		long id = 1;
		User user = userRepo.getById(id);
		user.setEmail(email);
		userRepo.save(user);
	}

	public void updatePhone(String phone) {
		long id = 1;
		User user = userRepo.getById(id);
		user.setPhone(phone);
		userRepo.save(user);
	}

	public boolean changePassword(String oldPassword, String newPassword) {

		long id = 1;
		User user = userRepo.getById(id);

		// plain password comparison
		if (!user.getPassword().equals(oldPassword)) {
			return false;
		}

		user.setPassword(newPassword);
		userRepo.save(user);
		return true;
	}

	public void updateUserName(String username) {
		long id = 1;
		User user = userRepo.getById(id);
		user.setUsername(username);
		userRepo.save(user);
	}

	public User findByUsername(String username) {
		return userRepo.findByUsername(username);
	}

	public User login(String username, String password) {
		User user = findByUsername(username);
		if (user != null && user.getPassword().equals(password)) {
			return user;
		}
		return null;
	}

	public List<User> getAllUsers() {
		return userRepo.findAll();
	}
	
	public long countUsers() {
		return userRepo.count();
	}

}
