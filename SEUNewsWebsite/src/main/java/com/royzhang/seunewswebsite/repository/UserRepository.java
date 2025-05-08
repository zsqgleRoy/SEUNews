package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsername(String username);

    Optional<User> findByUsernameAndPassword(String username, String password);

    @Query(
            "SELECT  u " +
                    "FROM User u " +
                    "WHERE u.user_id=:id"
    )
    User findUserByUserId(Integer id);
}
