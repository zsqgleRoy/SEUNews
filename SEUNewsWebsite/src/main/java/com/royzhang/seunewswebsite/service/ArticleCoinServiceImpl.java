package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleCoinDTO;
import com.royzhang.seunewswebsite.entity.ArticleCoin;
import com.royzhang.seunewswebsite.repository.ArticleCoinRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ArticleCoinServiceImpl implements ArticleCoinService {

    @Autowired
    private ArticleCoinRepository articleCoinRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<ArticleCoinDTO> getAllCoinsByArticleId(Integer articleId) {
        List<ArticleCoin> coins = articleCoinRepository.findByArticleId(articleId);
        return coins.stream()
                .map(coin -> modelMapper.map(coin, ArticleCoinDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public ArticleCoinDTO getCoinById(Integer coinId) {
        Optional<ArticleCoin> coinOptional = articleCoinRepository.findById(coinId);
        return coinOptional.map(coin -> modelMapper.map(coin, ArticleCoinDTO.class)).orElse(null);
    }

    @Override
    @Transactional
    public ArticleCoinDTO createCoin(ArticleCoinDTO coinDTO) {
        Integer num = articleCoinRepository.saveCoins(
                coinDTO.getUserId(), coinDTO.getArticleId(), coinDTO.getCoinCount(), coinDTO.getCoinDate());
        if (num == null || num <= 0) return null;
        return coinDTO;
    }

    @Override
    public void deleteCoin(Integer coinId) {
        articleCoinRepository.deleteById(coinId);
    }

    @Override
    public Integer getTotalCoinsForArticle(Integer articleId) {
        List<ArticleCoin> coins = articleCoinRepository.findByArticleId(articleId);
        return coins.stream().mapToInt(ArticleCoin::getCoinCount).sum();
    }

    @Override
    public boolean isArticleCoinedByUser(Integer userId, Integer articleId){
        return articleCoinRepository.existsByUserIdAndArticleId(userId, articleId);
    }
}
