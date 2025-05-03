package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleCategoryDTO;
import com.royzhang.seunewswebsite.entity.ArticleCategory;
import com.royzhang.seunewswebsite.repository.ArticleCategoryRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ArticleCategoryServiceImpl implements ArticleCategoryService {

    @Autowired
    private ArticleCategoryRepository articleCategoryRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<ArticleCategoryDTO> getAllCategoriesByArticleId(Integer articleId) {
        List<ArticleCategory> articleCategories = articleCategoryRepository.findByArticleId(articleId);
        return articleCategories.stream()
                .map(category -> modelMapper.map(category, ArticleCategoryDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public void addCategoryToArticle(ArticleCategoryDTO articleCategoryDTO) {
        ArticleCategory articleCategory = modelMapper.map(articleCategoryDTO, ArticleCategory.class);
        articleCategoryRepository.save(articleCategory);
    }

    @Override
    public void removeCategoryFromArticle(Integer articleId, Integer categoryId) {
        articleCategoryRepository.deleteByArticleIdAndCategoryId(articleId, categoryId);
    }
}
