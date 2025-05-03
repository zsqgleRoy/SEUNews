package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.UserRoleRelation;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface UserRoleRelationRepository extends JpaRepository<UserRoleRelation, Integer> {
    List<UserRoleRelation> findByUserId(Integer userId);

    void deleteByUserIdAndRoleId(Integer userId, Integer roleId);
}
