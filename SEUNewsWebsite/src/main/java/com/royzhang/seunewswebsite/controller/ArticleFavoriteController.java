package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.ArticleFavoriteDTO;
import com.royzhang.seunewswebsite.service.ArticleFavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/article-favorites")
public class ArticleFavoriteController {

    @Autowired
    private ArticleFavoriteService articleFavoriteService;

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<ArticleFavoriteDTO>> getAllFavoritesByUserId(@PathVariable Integer userId) {
        List<ArticleFavoriteDTO> favorites = articleFavoriteService.getAllFavoritesByUserId(userId);
        return new ResponseEntity<>(favorites, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<ArticleFavoriteDTO> createFavorite(@RequestBody ArticleFavoriteDTO favoriteDTO) {
        ArticleFavoriteDTO createdFavorite = articleFavoriteService.createFavorite(favoriteDTO);
        return new ResponseEntity<>(createdFavorite, HttpStatus.CREATED);
    }

    @DeleteMapping("/user/{userId}/article/{articleId}")
    public ResponseEntity<Void> deleteFavorite(@PathVariable Integer userId, @PathVariable Integer articleId) {
        articleFavoriteService.deleteFavorite(userId, articleId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/user/{userId}/article/{articleId}")
    public ResponseEntity<Boolean> isArticleFavoritedByUser(@PathVariable Integer userId, @PathVariable Integer articleId) {
        boolean isFavorited = articleFavoriteService.isArticleFavoritedByUser(userId, articleId);
        return new ResponseEntity<>(isFavorited, HttpStatus.OK);
    }
}
