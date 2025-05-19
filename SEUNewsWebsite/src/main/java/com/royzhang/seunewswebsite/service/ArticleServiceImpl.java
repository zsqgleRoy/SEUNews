package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.*;
import com.royzhang.seunewswebsite.dto.user.UserDTO;
import com.royzhang.seunewswebsite.entity.Article;
import com.royzhang.seunewswebsite.entity.Tag;
import com.royzhang.seunewswebsite.repository.ArticleRepository;
import com.royzhang.seunewswebsite.repository.TagRepository;
import jakarta.persistence.EntityManager;
import org.hibernate.Hibernate;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeMap;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.ErrorResponseException;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleRepository articleRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private TagRepository tagRepository;

    @Autowired
    private EntityManager entityManager;

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
    @Transactional(readOnly = true)
    public ArticleDTO getArticleById(Integer id) {
        //System.out.println(id);
        //System.out.println("aaaaaaaaaaaaaaaaa\n\n\n\n\n\n\n\n\n\n\n\n\n");
        //articleRepository.findByIdWithTags(id).ifPresent(article -> {
        //    System.out.println("Tags: " + article.getTags());
        //});
        //System.out.println("aaaaaaaaaaaaaaaaa\n\n\n\n\n\n\n\n\n\n\n\n\n");
        Article article = articleRepository.findByIdWithTags(id).orElseThrow();
        entityManager.detach(article);
        article = articleRepository.findByIdWithTags(id).orElseThrow();
        return new ArticleDTO(article);
    }


    @Override
    @Transactional
    public ArticleDTO createArticle(ArticleDTO articleDTO) {
        Article article = modelMapper.map(articleDTO, Article.class);
        Set<Tag> managedTags = new HashSet<>();
        for (Tag tag : article.getTags()) {
            Tag managedTag = tagRepository.findById(tag.getTagId())
                    .orElseThrow(() -> new ErrorResponseException(HttpStatus.BAD_REQUEST));
            managedTags.add(managedTag);
        }
        article.setTags(managedTags);
        Article savedArticle = articleRepository.save(article);
        return modelMapper.map(savedArticle, ArticleDTO.class);
    }



    private boolean isContentIdentical(Article article, ArticleUpdateDTO dto) {
        boolean baseFieldsMatch = Objects.equals(article.getTitle(), dto.getTitle())
                && Objects.equals(article.getContent(), dto.getContent())
                && Objects.equals(article.getStatus(), dto.getStatus())
                && Objects.equals(article.getHeadImageUrl(), dto.getHeadImageUrl());

        Set<Integer> currentTagIds = article.getTags().stream()
                .map(Tag::getTagId)
                .collect(Collectors.toSet());
        Set<Integer> dtoTagIds = dto.getTags() != null ?
                new HashSet<>(dto.getTags()) : Collections.emptySet();

        return baseFieldsMatch && currentTagIds.equals(dtoTagIds);
    }
    @Override
    @Transactional
    public boolean updateArticle(Integer id, ArticleUpdateDTO articleUpdateDTO) {
        try {
            Article article = articleRepository.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("文章不存在"));

            if (isContentIdentical(article, articleUpdateDTO)) {
                throw new RuntimeException("新闻内容无变化");
            }
            Set<Tag> newTags = new HashSet<>();
            if (articleUpdateDTO.getTags() != null) {
                for (Integer tagId : articleUpdateDTO.getTags()) {
                    if (!tagRepository.existsById(tagId)) {
                        throw new IllegalArgumentException("无效标签ID: " + tagId);
                    }
                    Tag tag = tagRepository.getReferenceById(tagId);
                    newTags.add(tag);
                }
            }
            modelMapper.map(articleUpdateDTO, article);
            article.setTags(newTags);
            article.setUpdateDate(new Date());
            return true;
        } catch (IllegalArgumentException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException("更新文章失败，具体原因: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public void deleteArticle(Integer id) {
        articleRepository.deleteById(id);
    }

    @Override
    @Transactional
    public Page<ArticleDTO> selectAllArticles(Article.ArticleStatus status, Integer isDelete, Pageable pageable) {
        if (status == null) {
            return Page.empty();
        }
        Page<Article> articles = articleRepository.findByStatusAndIsDeleted(status, isDelete, pageable);
        articles.getContent().forEach(article -> Hibernate.initialize(article.getTags()));
        return articles.map(ArticleDTO::new);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<ArticleDTO> selectAllArticlesByTagId(Article.ArticleStatus status, Integer isDelete, Pageable pageable, Integer tagId) {
        if (status == null || tagId == null) {
            return Page.empty();
        }
        Page<Article> articles = articleRepository.findByStatusAndTag(status, isDelete, tagId, pageable);
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
            Article article = modelMapper.map(dto, Article.class);
            article.setLastOperatorId(article.getAuthorId());
            Set<Tag> managedTags = new HashSet<>();
            for (Integer tagId : dto.getTags()) {
                Tag managedTag = tagRepository.findById(tagId)
                    .orElseThrow(() -> new ErrorResponseException(HttpStatus.BAD_REQUEST));
                managedTags.add(managedTag);
            }
            article.setTags(managedTags);
            Article savedArticle = articleRepository.save(article);
            return savedArticle != null;
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
    @Transactional
    public Page<ArticleDTO> selectDeletedArticles(int isDelete, Pageable pageable) {
        Page<Article> articles = articleRepository.findByIsDeleted(isDelete, pageable);
        return articles.map(ArticleDTO::new);
    }
}