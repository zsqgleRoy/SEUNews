package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleTagDTO;
import com.royzhang.seunewswebsite.entity.ArticleTag;
import com.royzhang.seunewswebsite.repository.ArticleTagRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ArticleTagServiceImpl implements ArticleTagService {

    @Autowired
    private ArticleTagRepository articleTagRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<ArticleTagDTO> getTagsByArticleId(Integer articleId) {
        List<ArticleTag> articleTags = articleTagRepository.findByArticleId(articleId);
        return articleTags.stream()
                .map(tag -> modelMapper.map(tag, ArticleTagDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public void addTagToArticle(ArticleTagDTO articleTagDTO) {
        ArticleTag articleTag = modelMapper.map(articleTagDTO, ArticleTag.class);
        articleTagRepository.save(articleTag);
    }

    @Override
    public void removeTagFromArticle(Integer articleId, Integer tagId) {
        articleTagRepository.deleteByArticleIdAndTagId(articleId, tagId);
    }
}
