package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Vip;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VipRepository extends JpaRepository<Vip, Integer> {

    Vip findVipById(Integer vipId);
}