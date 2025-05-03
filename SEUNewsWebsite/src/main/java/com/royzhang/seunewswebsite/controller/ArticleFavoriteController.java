package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.ArticleFavoriteDTO;
import com.royzhang.seunewswebsite.service.ArticleFavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/article-favorites")
public class ArticleFavoriteController {

    @Autowired
    private ArticleFavoriteService articleFavoriteService;

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<ArticleFavoriteDTO>> getAllFavoritesByUserId(@PathVariable Integer userId) {
        List<ArticleFavoriteDTO> favorites = articleFavoriteService.getAllFavoritesByUserId(userId);
        return new ResponseEntity<>(favorites, HttpStatus.OK);
    }

    @GetMapping("/{favoriteId}")
    public ResponseEntity<ArticleFavoriteDTO> getFavoriteById(@PathVariable Integer favoriteId) {
        ArticleFavoriteDTO favorite = articleFavoriteService.getFavoriteById(favoriteId);
        if (favorite != null) {
            return new ResponseEntity<>(favorite, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PostMapping
    public ResponseEntity<ArticleFavoriteDTO> createFavorite(@RequestBody ArticleFavoriteDTO favoriteDTO) {
        ArticleFavoriteDTO createdFavorite = articleFavoriteService.createFavorite(favoriteDTO);
        return new ResponseEntity<>(createdFavorite, HttpStatus.CREATED);
    }

    @DeleteMapping("/{favoriteId}")
    public ResponseEntity<Void> deleteFavorite(@PathVariable Integer favoriteId) {
        articleFavoriteService.deleteFavorite(favoriteId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/user/{userId}/article/{articleId}")
    public ResponseEntity<Boolean> isArticleFavoritedByUser(@PathVariable Integer userId, @PathVariable Integer articleId) {
        boolean isFavorited = articleFavoriteService.isArticleFavoritedByUser(userId, articleId);
        return new ResponseEntity<>(isFavorited, HttpStatus.OK);
    }
}
