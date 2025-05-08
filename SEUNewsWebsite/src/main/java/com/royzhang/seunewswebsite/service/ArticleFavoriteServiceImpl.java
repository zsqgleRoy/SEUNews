package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleFavoriteDTO;
import com.royzhang.seunewswebsite.entity.ArticleFavorite;
import com.royzhang.seunewswebsite.repository.ArticleFavoriteRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ArticleFavoriteServiceImpl implements ArticleFavoriteService {

    @Autowired
    private ArticleFavoriteRepository articleFavoriteRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<ArticleFavoriteDTO> getAllFavoritesByUserId(Integer userId) {
        List<ArticleFavorite> favorites = articleFavoriteRepository.findByUserId(userId);
        return favorites.stream()
                .map(favorite -> modelMapper.map(favorite, ArticleFavoriteDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public ArticleFavoriteDTO createFavorite(ArticleFavoriteDTO favoriteDTO) {
        ArticleFavorite favorite = modelMapper.map(favoriteDTO, ArticleFavorite.class);
        ArticleFavorite savedFavorite = articleFavoriteRepository.save(favorite);
        return modelMapper.map(savedFavorite, ArticleFavoriteDTO.class);
    }

    @Override
    @Transactional
    public void deleteFavorite(Integer userId, Integer articleId) {
        articleFavoriteRepository.deleteByUserIdAndArticleId(userId, articleId);
    }

    @Override
    public boolean isArticleFavoritedByUser(Integer userId, Integer articleId) {
        return articleFavoriteRepository.existsByUserIdAndArticleId(userId, articleId);
    }
}
