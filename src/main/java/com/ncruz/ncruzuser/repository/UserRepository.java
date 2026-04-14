package com.ncruz.ncruzuser.repository;


import com.ncruz.ncruzuser.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
}