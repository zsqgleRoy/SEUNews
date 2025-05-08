package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleLikeDTO;
import com.royzhang.seunewswebsite.entity.ArticleLike;
import com.royzhang.seunewswebsite.repository.ArticleLikeRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ArticleLikeServiceImpl implements ArticleLikeService {

    @Autowired
    private ArticleLikeRepository articleLikeRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<ArticleLikeDTO> getAllLikesByArticleId(Integer articleId) {
        List<ArticleLike> likes = articleLikeRepository.findByArticleId(articleId);
        return likes.stream()
                .map(like -> modelMapper.map(like, ArticleLikeDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public ArticleLikeDTO createLike(ArticleLikeDTO likeDTO) {
        ArticleLike like = modelMapper.map(likeDTO, ArticleLike.class);
        ArticleLike savedLike = articleLikeRepository.save(like);
        return modelMapper.map(savedLike, ArticleLikeDTO.class);
    }

    @Override
    @Transactional
    public void deleteLike(Integer userId, Integer articleId) {
        articleLikeRepository.deleteByUserIdAndArticleId(userId, articleId);
    }

    @Override
    public boolean isArticleLikedByUser(Integer userId, Integer articleId) {
        return articleLikeRepository.existsByUserIdAndArticleId(userId, articleId);
    }
}
