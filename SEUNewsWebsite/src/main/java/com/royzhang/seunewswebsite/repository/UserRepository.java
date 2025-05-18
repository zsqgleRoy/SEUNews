package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

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

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    @Modifying
    @Transactional
    @Query("UPDATE User u SET u.lastOperatorId = 2, u.isDeleted = CASE WHEN u.isDeleted = 1 THEN 0 ELSE 1 END WHERE u.user_id = :id")
    void deleteByIds(Integer id);
}
