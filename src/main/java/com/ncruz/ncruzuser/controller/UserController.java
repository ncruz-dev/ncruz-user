package com.ncruz.ncruzuser.controller;

import com.ncruz.api.UsersApi;
import com.ncruz.model.User;
import com.ncruz.ncruzuser.entity.UserEntity;
import com.ncruz.ncruzuser.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserController implements UsersApi {

    private final UserService service;

    public UserController(UserService service) {
        this.service = service;
    }

//    @Override
    public ResponseEntity<List<UserEntity>> getAllUsers() {
        List<UserEntity> users = service.findAll();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    public ResponseEntity<User> createUser(UserEntity user) {
        service.save(user);
        return ResponseEntity.status(201).build();
    }

    public ResponseEntity<User> updateUser(Integer id, UserEntity user) {
        service.update(id.longValue(), user);
        return ResponseEntity.ok().build();
    }

    @Override
    public ResponseEntity<String> deleteUser(Integer id) {
        service.delete(id.longValue());
        return ResponseEntity.ok("User deleted successfully");
    }

//    @Override
//    public ResponseEntity<Void> deleteUser(Integer id) {
//        service.delete(id.longValue());
//        return ResponseEntity.noContent().build();
//    }
}
