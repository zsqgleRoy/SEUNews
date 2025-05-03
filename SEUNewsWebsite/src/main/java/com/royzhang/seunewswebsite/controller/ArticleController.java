package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.ArticleDTO;
import com.royzhang.seunewswebsite.dto.Article.ArticleFrontDTO;
import com.royzhang.seunewswebsite.dto.Article.ArticleInsertDTO;
import com.royzhang.seunewswebsite.dto.Article.ArticleUpdateDTO;
import com.royzhang.seunewswebsite.entity.Article;
import com.royzhang.seunewswebsite.entity.User;
import com.royzhang.seunewswebsite.repository.UserRepository;
import com.royzhang.seunewswebsite.service.ArticleService;
import com.royzhang.seunewswebsite.service.UserService;
import jakarta.persistence.Table;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/articles")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;

    /**
     * 获取所有文章列表
     * @return 文章列表
     */
    @GetMapping
    public ResponseEntity<List<ArticleDTO>> getAllArticles() {
        List<ArticleDTO> articles = articleService.getAllArticles();
        return new ResponseEntity<>(articles, HttpStatus.OK);
    }

    /**
     * 根据文章ID获取文章信息
     * @param id 文章ID
     * @return 文章信息
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getArticleById(@PathVariable Integer id) {
        ArticleDTO article = articleService.getArticleById(id);
        if (article == null) {
            return ResponseEntity.notFound().build();
        }

        User author = userRepository.findById(article.getAuthorId())
                .orElse(null);

        if (author == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("Author not found with id: " + article.getAuthorId());
        }

        article.setAuthor(author.getUsername());
        article.setAvatar(author.getAvatar());
        return ResponseEntity.ok(article);
    }

    /**
     * 创建文章
     * @param articleDTO 文章DTO
     * @return 创建后的文章信息
     */
    @PostMapping
    public ResponseEntity<ArticleDTO> createArticle(@RequestBody ArticleDTO articleDTO) {
        ArticleDTO createdArticle = articleService.createArticle(articleDTO);
        return new ResponseEntity<>(createdArticle, HttpStatus.CREATED);
    }

    /**
     * 更新文章信息
     * @param id                文章ID
     * @param articleUpdateDTO  文章DTO
     * @return 更新后的文章信息
     */
    @PutMapping("/{id}")
    public Boolean updateArticle(@PathVariable Integer id, @RequestBody ArticleUpdateDTO articleUpdateDTO) {
        return articleService.updateArticle(id, articleUpdateDTO);
    }

    /**
     * 删除文章
     * @param id 文章ID
     * @return 响应状态
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteArticle(@PathVariable Integer id) {
        articleService.deleteArticle(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    /**
     * 根据文章状态分页查询文章列表
     * @param status 文章状态
     * @param pageable 分页信息
     * @return 分页的文章前端DTO列表
     */
    @GetMapping("/all")
    public ResponseEntity<Page<ArticleFrontDTO>> listAllArticles(
            @RequestParam Article.ArticleStatus status,
            Pageable pageable
    ) {
        Page<ArticleFrontDTO> selectedArticles = articleService.selectAllArticles(status, pageable);
        return ResponseEntity.ok(selectedArticles);
    }

    /**
     * 分页获取文章列表
     * @param page 页码
     * @param pageSize 每页数量
     * @param status 文章状态
     * @return 文章列表
     */
    @GetMapping("/list")
    public ResponseEntity<Page<ArticleFrontDTO>> getNewsList(
            @RequestParam int page,
            @RequestParam int pageSize,
            @RequestParam Article.ArticleStatus status
    ) {
        Pageable pageable = org.springframework.data.domain.PageRequest.of(page - 1, pageSize);
        Page<ArticleFrontDTO> articles = articleService.selectAllArticles(status, pageable);
        return ResponseEntity.ok(articles);
    }

    /**
     * 分页获取文章列表
     * @param keyword 关键词
     * @param tag 类型
     * @param subTag 次级类型
     * @param page 页码
     * @param pageSize 每页数量
     * @param status 文章状态
     * @return 文章列表
     */
    @GetMapping("/search")
    public ResponseEntity<Page<?>> getNewsListBySearch(
            @RequestParam String keyword,
            @RequestParam String tag,
            @RequestParam String subTag,
            @RequestParam int page,
            @RequestParam int pageSize,
            @RequestParam Article.ArticleStatus status
    ) {
        if (tag.equals("新闻")){
        }
        else return null;
        Pageable pageable = org.springframework.data.domain.PageRequest.of(page - 1, pageSize);
        Page<ArticleDTO> articles = articleService.selectArticlesByTitle(keyword, status, pageable);
        return ResponseEntity.ok(articles);
    }

    /**
     * 发布文章
     * @param articleInsertDTO 文章插入DTO
     * @return 响应信息
     */
    @PostMapping("/publish")
    public ResponseEntity<String> publishArticle(@RequestBody ArticleInsertDTO articleInsertDTO) {
        try {
            articleInsertDTO.setAuthorId(userService.findUserIdByUsername(articleInsertDTO.getAuthor()));
            if (articleService.saveArticle(articleInsertDTO)) {
                return new ResponseEntity<>("OK", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("新闻保存失败，请稍后重试", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            // 这里可以添加日志记录，例如：log.error("保存文章失败", e);
            return new ResponseEntity<>("新闻保存失败，请稍后重试", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    /**
     * 发布文章
     * @param articleUpdateDTO 文章插入DTO
     * @return 响应信息
     */
    @PutMapping("/update{id}")
    public ResponseEntity<String> updateArticle(@PathVariable int id, @RequestBody ArticleUpdateDTO articleUpdateDTO) {
        try {
            if (articleService.updateArticle(id, articleUpdateDTO)) {
                return new ResponseEntity<>("新闻更新成功", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("新闻保存失败，请稍后重试", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            // 这里可以添加日志记录，例如：log.error("保存文章失败", e);
            return new ResponseEntity<>("新闻保存失败，请稍后重试", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}