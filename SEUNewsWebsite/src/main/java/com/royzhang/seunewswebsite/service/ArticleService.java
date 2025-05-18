package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleDTO;
import com.royzhang.seunewswebsite.dto.Article.ArticleFrontDTO;
import com.royzhang.seunewswebsite.dto.Article.ArticleInsertDTO;
import com.royzhang.seunewswebsite.dto.Article.ArticleUpdateDTO;
import com.royzhang.seunewswebsite.entity.Article;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * 文章服务接口，定义了文章相关的业务操作方法。
 */
public interface ArticleService {

    /**
     * 获取所有文章列表。
     *
     * @return 文章 DTO 列表
     */
    List<ArticleDTO> getAllArticles();

    /**
     * 根据文章 ID 获取文章信息。
     *
     * @param id 文章 ID
     * @return 文章 DTO
     */
    ArticleDTO getArticleById(Integer id);

    /**
     * 创建一篇新文章。
     *
     * @param articleDTO 文章 DTO
     * @return 创建后的文章 DTO
     */
    ArticleDTO createArticle(ArticleDTO articleDTO);

    /**
     * 更新指定 ID 的文章信息。
     *
     * @param id                文章 ID
     * @param articleUpdateDTO  文章 DTO
     * @return 更新状态
     */
    boolean updateArticle(Integer id, ArticleUpdateDTO articleUpdateDTO);

    /**
     * 删除指定 ID 的文章。
     *
     * @param id 文章 ID
     */
    void deleteArticle(Integer id);

    /**
     * 根据文章状态进行分页查询文章列表。
     *
     * @param status   文章状态
     * @param isDelete
     * @param pageable 分页信息
     * @return 分页的文章前端 DTO 列表
     */
    Page<ArticleDTO> selectAllArticles(Article.ArticleStatus status, Integer isDelete, Pageable pageable);

    Page<ArticleDTO> selectAllArticlesByTagId(Article.ArticleStatus status, Integer isDelete, Pageable pageable, Integer tagId);

    /**
     * 保存文章信息。
     *
     * @param articleInsertDTO 文章插入 DTO
     * @return 是否保存成功
     */
    boolean saveArticle(ArticleInsertDTO articleInsertDTO);

    Page<ArticleDTO> selectArticlesByTitle(String title, Article.ArticleStatus status, Pageable pageable);

    boolean createArticleShare(Integer articleId);

    List<ArticleFrontDTO> getArticleByAuthorId(Integer authorid);

    void deleteArticlesByIds(List<Integer> ids);

    Page<ArticleDTO> selectDeletedArticles(int isDelete, Pageable pageable);
}