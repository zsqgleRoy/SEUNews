package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.ArticleCoinDTO;
import com.royzhang.seunewswebsite.service.ArticleCoinService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/article-coins")
public class ArticleCoinController {

    @Autowired
    private ArticleCoinService articleCoinService;

    // 获取文章的所有投币记录
    @GetMapping("/article/{articleId}")
    public ResponseEntity<List<ArticleCoinDTO>> getAllCoinsByArticleId(@PathVariable Integer articleId) {
        List<ArticleCoinDTO> coins = articleCoinService.getAllCoinsByArticleId(articleId);
        return new ResponseEntity<>(coins, HttpStatus.OK);
    }

    // 根据投币 ID 获取投币记录
    @GetMapping("/{coinId}")
    public ResponseEntity<ArticleCoinDTO> getCoinById(@PathVariable Integer coinId) {
        ArticleCoinDTO coin = articleCoinService.getCoinById(coinId);
        if (coin != null) {
            return new ResponseEntity<>(coin, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    // 创建投币记录
    @PostMapping
    public ResponseEntity<ArticleCoinDTO> createCoin(@RequestBody ArticleCoinDTO coinDTO) {
        ArticleCoinDTO createdCoin = articleCoinService.createCoin(coinDTO);
        return new ResponseEntity<>(createdCoin, HttpStatus.CREATED);
    }

    // 删除投币记录
    @DeleteMapping("/{coinId}")
    public ResponseEntity<Void> deleteCoin(@PathVariable Integer coinId) {
        articleCoinService.deleteCoin(coinId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    // 统计文章的总投币数
    @GetMapping("/total/{articleId}")
    public ResponseEntity<Integer> getTotalCoinsForArticle(@PathVariable Integer articleId) {
        Integer totalCoins = articleCoinService.getTotalCoinsForArticle(articleId);
        return new ResponseEntity<>(totalCoins, HttpStatus.OK);
    }
}
