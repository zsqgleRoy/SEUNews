package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
}
