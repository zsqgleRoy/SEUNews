package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.*;
import com.royzhang.seunewswebsite.dto.user.UserDTO;
import com.royzhang.seunewswebsite.entity.Article;
import com.royzhang.seunewswebsite.entity.ArticleTagId;
import com.royzhang.seunewswebsite.repository.ArticleRepository;
import com.royzhang.seunewswebsite.repository.ArticleTagIdRepository;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeMap;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleRepository articleRepository;

    @Autowired
    private ArticleTagIdRepository articleTagIdRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private ModelMapper modelMapper;

    // 初始化类型映射
    private final TypeMap<ArticleInsertDTO, Article> articleInsertTypeMap;

    public ArticleServiceImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;

        // 显式配置所有字段映射
        this.articleInsertTypeMap = modelMapper.createTypeMap(ArticleInsertDTO.class, Article.class)
                .addMappings(mapper -> {
                    mapper.skip(Article::setArticleId);
                    mapper.map(ArticleInsertDTO::getAuthorId, Article::setAuthorId);
                });

        // 配置全局策略（严格匹配 + 忽略歧义）
        modelMapper.getConfiguration()
                .setMatchingStrategy(MatchingStrategies.STRICT)
                .setAmbiguityIgnored(true);
    }

    @Override
    public List<ArticleDTO> getAllArticles() {
        return articleRepository.findAll().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public ArticleDTO getArticleById(Integer id) {
        return articleRepository.findById(id)
                .map(ArticleDTO::new)
                .orElse(null);
    }

    @Override
    @Transactional
    public ArticleDTO createArticle(ArticleDTO articleDTO) {
        Article article = modelMapper.map(articleDTO, Article.class);
        Article savedArticle = articleRepository.save(article);
        return modelMapper.map(savedArticle, ArticleDTO.class);
    }

    @Override
    @Transactional
    public boolean updateArticle(Integer id, ArticleUpdateDTO articleUpdateDTO) {
        try {
            Article article = articleRepository.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("文章不存在"));
            modelMapper.map(articleUpdateDTO, article);
            articleRepository.save(article);
            return true;
        } catch (IllegalArgumentException e) {
            // 文章不存在的异常处理
            throw e;
        } catch (Exception e) {
            // 其他异常处理
            throw new RuntimeException("更新文章失败，具体原因: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public void deleteArticle(Integer id) {
        articleRepository.deleteById(id);
    }

    @Override
    public Page<ArticleDTO> selectAllArticles(Article.ArticleStatus status, Integer isDelete, Pageable pageable) {
        if (status == null) {
            return Page.empty();
        }
        Page<Article> articles = articleRepository.findByStatusAndIsDeleted(status, isDelete, pageable);
        return articles.map(ArticleDTO::new);
    }

    private boolean isMatch(Article article, ArticleDTO dto) {
        return article != null && dto != null && article.getArticleId().equals(dto.getArticle_id());
    }

    public ArticleDTO convertToDTO(Article article) {
        ArticleDTO dto = modelMapper.map(article, ArticleDTO.class);
        dto.setAuthor(userService.getUserById(article.getAuthorId()).getUsername());
        return dto;
    }

    @Override
    @Transactional
    public boolean saveArticle(ArticleInsertDTO dto) {
        try {
            Article article = articleInsertTypeMap.map(dto);
            article.setLastOperatorId(dto.getAuthorId());
            Article savedArticle = articleRepository.save(article);
            Integer articleId = savedArticle.getArticleId();

            if (dto.getTag() != null && dto.getTag() != 0) {
                ArticleTagId articleTagId = new ArticleTagId();
                articleTagId.setArticleId(articleId);
                articleTagId.setTagId(dto.getTag());
                articleTagIdRepository.save(articleTagId);
            }

            return true;
        } catch (Exception e) {
            throw new RuntimeException("保存文章失败", e);
        }
    }
    @Override
    public Page<ArticleDTO> selectArticlesByTitle(String title, Article.ArticleStatus status, Pageable pageable){
        if (status == null) {
            return Page.empty();
        }
        Page<Article> articles = articleRepository.findByTitleAndStatus(title, status, pageable);
        return articles.map(article -> {
            UserDTO autho = userService.getUserById(article.getAuthorId());
            return new ArticleDTO(article, autho);
        });
    }

    @Override
    public boolean createArticleShare(Integer articleId) {
        return articleRepository.increaseShare(articleId)!=0;
    }

    /**
     * 根据作者 ID 获取文章的前端数据传输对象列表
     * @param authorId 作者的 ID
     * @return 文章前端数据传输对象列表
     */
    public List<ArticleFrontDTO> getArticleByAuthorId(Integer authorId) {
        List<Article> articles = articleRepository.findArticlesWithMediasByAuthorId(authorId);
        List<ArticleFrontDTO> articleFrontDTOS = new ArrayList<>();
        for (Article article : articles) {
            ArticleFrontDTO dto = new ArticleFrontDTO(article);
            articleFrontDTOS.add(dto);
        }
        return articleFrontDTOS;

    }

    @Override
    public void deleteArticlesByIds(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) {
            return;
        }
        Integer lastOperatorId = ids.get(0);
        List<Integer> newIds = new ArrayList<>(ids.subList(1, ids.size()));
        articleRepository.deleteByIds(newIds, lastOperatorId);
    }

    @Override
    public Page<ArticleDTO> selectDeletedArticles(int isDelete, Pageable pageable) {
        Page<Article> articles = articleRepository.findByIsDeleted(isDelete, pageable);
        return articles.map(ArticleDTO::new);
    }
}