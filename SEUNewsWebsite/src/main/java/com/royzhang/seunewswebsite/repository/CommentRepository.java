package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

    List<Comment> findByArticleId(Integer articleId);
}
