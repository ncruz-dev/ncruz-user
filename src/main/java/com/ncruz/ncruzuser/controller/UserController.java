package com.ncruz.ncruzuser.controller;

import com.ncruz.api.UsersApi;
import com.ncruz.model.User;
import com.ncruz.ncruzuser.entity.UserEntity;
import com.ncruz.ncruzuser.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserController implements UsersApi {

    private final UserService service;

    public UserController(UserService service) {
        this.service = service;
    }

    @Override
    public ResponseEntity<User> createUser(User user) {
        UserEntity userEntity = new UserEntity();
        userEntity.setName(user.getName());
        userEntity.setEmail(user.getEmail());
        UserEntity savedUser = service.save(userEntity);
        return new ResponseEntity<>(new User()
                .id(savedUser.getId().intValue())
                .name(savedUser.getName())
                .email(savedUser.getEmail()), HttpStatus.CREATED);
    }

    @Override
    public ResponseEntity<String> deleteUser(Integer id) {
        service.delete(id.longValue());
        return ResponseEntity.ok("User deleted successfully");
    }

    @Override
    public ResponseEntity<List<User>> listUsers() {
        List<UserEntity> users = service.findAll();
        return new ResponseEntity<>(users.stream().map(userEntity -> new User()
                .id(userEntity.getId().intValue())
                .name(userEntity.getName())
                .email(userEntity.getEmail())).toList(), HttpStatus.OK);
    }

    @Override
    public ResponseEntity<User> updateUser(Integer id, User user) {
        UserEntity userEntity = new UserEntity();
        userEntity.setName(user.getName());
        userEntity.setEmail(user.getEmail());
        UserEntity updatedUser = service.update(id.longValue(), userEntity);
        return ResponseEntity.ok(new User()
                .id(updatedUser.getId().intValue())
                .name(updatedUser.getName())
                .email(updatedUser.getEmail()));
    }

}
