package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.ArticleLikeDTO;
import com.royzhang.seunewswebsite.service.ArticleLikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/article-likes")
public class ArticleLikeController {

    @Autowired
    private ArticleLikeService articleLikeService;

    @GetMapping("/article/{articleId}")
    public ResponseEntity<List<ArticleLikeDTO>> getAllLikesByArticleId(@PathVariable Integer articleId) {
        List<ArticleLikeDTO> likes = articleLikeService.getAllLikesByArticleId(articleId);
        return new ResponseEntity<>(likes, HttpStatus.OK);
    }

    @GetMapping("/{likeId}")
    public ResponseEntity<ArticleLikeDTO> getLikeById(@PathVariable Integer likeId) {
        ArticleLikeDTO like = articleLikeService.getLikeById(likeId);
        if (like != null) {
            return new ResponseEntity<>(like, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PostMapping
    public ResponseEntity<ArticleLikeDTO> createLike(@RequestBody ArticleLikeDTO likeDTO) {
        ArticleLikeDTO createdLike = articleLikeService.createLike(likeDTO);
        return new ResponseEntity<>(createdLike, HttpStatus.CREATED);
    }

    @DeleteMapping("/{likeId}")
    public ResponseEntity<Void> deleteLike(@PathVariable Integer likeId) {
        articleLikeService.deleteLike(likeId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/user/{userId}/article/{articleId}")
    public ResponseEntity<Boolean> isArticleLikedByUser(@PathVariable Integer userId, @PathVariable Integer articleId) {
        boolean isLiked = articleLikeService.isArticleLikedByUser(userId, articleId);
        return new ResponseEntity<>(isLiked, HttpStatus.OK);
    }
}
