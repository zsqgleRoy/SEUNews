package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.ArticleCategoryDTO;
import com.royzhang.seunewswebsite.service.ArticleCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/article-categories")
public class ArticleCategoryController {

    @Autowired
    private ArticleCategoryService articleCategoryService;

    // 获取文章所属的所有分类
    @GetMapping("/article/{articleId}")
    public ResponseEntity<List<ArticleCategoryDTO>> getAllCategoriesByArticleId(@PathVariable Integer articleId) {
        List<ArticleCategoryDTO> categories = articleCategoryService.getAllCategoriesByArticleId(articleId);
        return new ResponseEntity<>(categories, HttpStatus.OK);
    }

    // 为文章添加分类
    @PostMapping
    public ResponseEntity<Void> addCategoryToArticle(@RequestBody ArticleCategoryDTO articleCategoryDTO) {
        articleCategoryService.addCategoryToArticle(articleCategoryDTO);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    // 从文章中移除分类
    @DeleteMapping("/article/{articleId}/category/{categoryId}")
    public ResponseEntity<Void> removeCategoryFromArticle(@PathVariable Integer articleId, @PathVariable Integer categoryId) {
        articleCategoryService.removeCategoryFromArticle(articleId, categoryId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
