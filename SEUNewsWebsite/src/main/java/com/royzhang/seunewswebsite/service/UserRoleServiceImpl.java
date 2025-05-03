package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.UserRoleDTO;
import com.royzhang.seunewswebsite.entity.UserRole;
import com.royzhang.seunewswebsite.repository.UserRoleRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserRoleServiceImpl implements UserRoleService {

    @Autowired
    private UserRoleRepository userRoleRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<UserRoleDTO> getAllRoles() {
        List<UserRole> roles = userRoleRepository.findAll();
        return roles.stream()
                .map(role -> modelMapper.map(role, UserRoleDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public UserRoleDTO getRoleById(Integer roleId) {
        Optional<UserRole> roleOptional = userRoleRepository.findById(roleId);
        return roleOptional.map(role -> modelMapper.map(role, UserRoleDTO.class)).orElse(null);
    }

    @Override
    public UserRoleDTO createRole(UserRoleDTO userRoleDTO) {
        UserRole userRole = modelMapper.map(userRoleDTO, UserRole.class);
        UserRole savedRole = userRoleRepository.save(userRole);
        return modelMapper.map(savedRole, UserRoleDTO.class);
    }

    @Override
    public UserRoleDTO updateRole(Integer roleId, UserRoleDTO userRoleDTO) {
        Optional<UserRole> roleOptional = userRoleRepository.findById(roleId);
        if (roleOptional.isPresent()) {
            UserRole userRole = roleOptional.get();
            userRole.setRoleName(userRoleDTO.getRoleName());
            userRole.setRoleDescription(userRoleDTO.getRoleDescription());
            UserRole updatedRole = userRoleRepository.save(userRole);
            return modelMapper.map(updatedRole, UserRoleDTO.class);
        }
        return null;
    }

    @Override
    public void deleteRole(Integer roleId) {
        userRoleRepository.deleteById(roleId);
    }
}
