package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.UserVipRelationDTO;
import com.royzhang.seunewswebsite.entity.UserVipRelation;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

public interface UserVipRelationService {
    @Transactional
    UserVipRelation activateVip(Integer userId, Integer vipId);

    List<UserVipRelationDTO> getUserVipRelations(Integer userId);

    @Transactional
    void deleteRelation(Integer userId, Integer vipId, LocalDateTime time);
}
