package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.ArticleTagDTO;
import com.royzhang.seunewswebsite.service.ArticleTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/article-tags")
public class ArticleTagController {

    @Autowired
    private ArticleTagService articleTagService;

    // 获取文章关联的所有标签
    @GetMapping("/article/{articleId}")
    public ResponseEntity<List<ArticleTagDTO>> getTagsByArticleId(@PathVariable Integer articleId) {
        List<ArticleTagDTO> tags = articleTagService.getTagsByArticleId(articleId);
        return new ResponseEntity<>(tags, HttpStatus.OK);
    }

    // 为文章添加标签
    @PostMapping
    public ResponseEntity<Void> addTagToArticle(@RequestBody ArticleTagDTO articleTagDTO) {
        articleTagService.addTagToArticle(articleTagDTO);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    // 从文章中移除标签
    @DeleteMapping("/article/{articleId}/tag/{tagId}")
    public ResponseEntity<Void> removeTagFromArticle(@PathVariable Integer articleId, @PathVariable Integer tagId) {
        articleTagService.removeTagFromArticle(articleId, tagId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
