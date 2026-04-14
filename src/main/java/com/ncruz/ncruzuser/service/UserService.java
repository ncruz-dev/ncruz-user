package com.ncruz.ncruzuser.service;


import com.ncruz.ncruzuser.entity.UserEntity;
import com.ncruz.ncruzuser.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    public List<UserEntity> findAll() {
        return repository.findAll();
    }

    public UserEntity save(UserEntity user) {
        return repository.save(user);
    }

    public UserEntity update(Long id, UserEntity user) {
        user.setId(id);
        return repository.save(user);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
