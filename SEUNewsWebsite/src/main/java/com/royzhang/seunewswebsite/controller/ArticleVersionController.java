package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.ArticleVersionDTO;
import com.royzhang.seunewswebsite.service.ArticleVersionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/article-versions")
public class ArticleVersionController {

    @Autowired
    private ArticleVersionService articleVersionService;

    @GetMapping("/article/{articleId}")
    public ResponseEntity<List<ArticleVersionDTO>> getAllVersionsByArticleId(@PathVariable Integer articleId) {
        List<ArticleVersionDTO> versions = articleVersionService.getAllVersionsByArticleId(articleId);
        return new ResponseEntity<>(versions, HttpStatus.OK);
    }

    @GetMapping("/{versionId}")
    public ResponseEntity<ArticleVersionDTO> getVersionById(@PathVariable Integer versionId) {
        ArticleVersionDTO version = articleVersionService.getVersionById(versionId);
        if (version != null) {
            return new ResponseEntity<>(version, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PostMapping
    public ResponseEntity<ArticleVersionDTO> createArticleVersion(@RequestBody ArticleVersionDTO articleVersionDTO) {
        ArticleVersionDTO createdVersion = articleVersionService.createArticleVersion(articleVersionDTO);
        return new ResponseEntity<>(createdVersion, HttpStatus.CREATED);
    }

    @PutMapping("/{versionId}")
    public ResponseEntity<ArticleVersionDTO> updateArticleVersion(@PathVariable Integer versionId, @RequestBody ArticleVersionDTO articleVersionDTO) {
        ArticleVersionDTO updatedVersion = articleVersionService.updateArticleVersion(versionId, articleVersionDTO);
        if (updatedVersion != null) {
            return new ResponseEntity<>(updatedVersion, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/{versionId}")
    public ResponseEntity<Void> deleteArticleVersion(@PathVariable Integer versionId) {
        articleVersionService.deleteArticleVersion(versionId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
