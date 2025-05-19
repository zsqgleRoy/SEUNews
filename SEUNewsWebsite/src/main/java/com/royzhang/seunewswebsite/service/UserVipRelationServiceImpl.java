package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.UserVipRelationDTO;
import com.royzhang.seunewswebsite.entity.OrderStatus;
import com.royzhang.seunewswebsite.entity.UserVipRelation;
import com.royzhang.seunewswebsite.entity.UserVipRelationId;
import com.royzhang.seunewswebsite.entity.Vip;
import com.royzhang.seunewswebsite.repository.UserVipRelationRepository;
import com.royzhang.seunewswebsite.repository.VipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserVipRelationServiceImpl implements UserVipRelationService {

    @Autowired
    private UserVipRelationRepository relationRepository;

    @Autowired
    private VipRepository vipRepository;

    @Override
    @Transactional
    public UserVipRelation activateVip(Integer userId, Integer vipId) {
        UserVipRelation relation = new UserVipRelation();
        relation.setUid(userId);
        relation.setVipId(vipId);
        relation.setActivationTime(LocalDateTime.now());
        vipRepository.findById(vipId)
                .ifPresent(o -> {
            relation.setExpireTime(relation.getActivationTime().plusDays(o.getDurationsValue()));
        });
        return relationRepository.save(relation);
    }

    @Override
    public List<UserVipRelationDTO> getUserVipRelations(Integer userId) {
        List<UserVipRelation> relations = relationRepository.findByUid(userId);
        return relations.stream().map(relation -> {
            Vip vip = vipRepository.findById(relation.getVipId()).orElseThrow();
            // LocalDateTime expireTime = relation.getActivationTime().plusDays(vip.getDurationsValue());
            return new UserVipRelationDTO(relation);
        }).collect(Collectors.toList());
    }


    @Transactional
    @Override
    public void deleteRelation(Integer userId, Integer vipId, LocalDateTime activationTime) {
        relationRepository.deleteById(new UserVipRelationId(userId, vipId, activationTime));
    }
}