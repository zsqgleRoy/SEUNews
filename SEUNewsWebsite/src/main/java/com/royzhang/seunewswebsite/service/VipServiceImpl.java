package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.entity.Vip;
import com.royzhang.seunewswebsite.repository.VipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VipServiceImpl implements VipService {

    @Autowired
    private VipRepository vipRepository;

    @Override
    public List<Vip> findAll() {
        return vipRepository.findAll();
    }

    @Override
    public Optional<Vip> findById(Integer id) {
        return vipRepository.findById(id);
    }

    @Override
    public Vip save(Vip vip) {
        return vipRepository.save(vip);
    }

    @Override
    public void deleteById(Integer id) {
        vipRepository.deleteById(id);
    }
}