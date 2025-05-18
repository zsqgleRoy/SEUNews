package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.entity.Vip;

import java.util.List;
import java.util.Optional;

public interface VipService {
    List<Vip> findAll();

    Optional<Vip> findById(Integer id);

    Vip save(Vip vip);

    void deleteById(Integer id);
}
