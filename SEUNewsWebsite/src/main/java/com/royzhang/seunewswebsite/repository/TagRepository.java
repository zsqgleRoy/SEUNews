package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TagRepository extends JpaRepository<Tag, Integer> {
    Optional<Tag> findByLabel(String name);

    Optional<Object> findByTagId(Integer tag);
}