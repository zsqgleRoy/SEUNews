package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.UserVipRelation;
import com.royzhang.seunewswebsite.entity.UserVipRelationId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface UserVipRelationRepository extends JpaRepository<UserVipRelation, UserVipRelationId> {

    // 根据用户ID查询所有开通记录
    @Query("SELECT u FROM UserVipRelation u WHERE u.uid = :userId")
    List<UserVipRelation> findByUserId(@Param("userId") Integer userId);

    // 根据VIP类型ID查询开通用户
    @Query("SELECT u FROM UserVipRelation u WHERE u.vipId = :vipId")
    List<UserVipRelation> findByVipId(@Param("vipId") Integer vipId);

    List<UserVipRelation> findByUid(Integer userId);
}