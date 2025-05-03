package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.UserRoleRelationDTO;
import com.royzhang.seunewswebsite.entity.UserRoleRelation;
import com.royzhang.seunewswebsite.repository.UserRoleRelationRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserRoleRelationServiceImpl implements UserRoleRelationService {

    @Autowired
    private UserRoleRelationRepository userRoleRelationRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<UserRoleRelationDTO> getRolesByUserId(Integer userId) {
        List<UserRoleRelation> relations = userRoleRelationRepository.findByUserId(userId);
        return relations.stream()
                .map(relation -> modelMapper.map(relation, UserRoleRelationDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public void assignRoleToUser(UserRoleRelationDTO userRoleRelationDTO) {
        UserRoleRelation userRoleRelation = modelMapper.map(userRoleRelationDTO, UserRoleRelation.class);
        userRoleRelationRepository.save(userRoleRelation);
    }

    @Override
    public void revokeRoleFromUser(Integer userId, Integer roleId) {
        userRoleRelationRepository.deleteByUserIdAndRoleId(userId, roleId);
    }
}
