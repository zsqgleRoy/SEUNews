package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.CommentDTO;
import com.royzhang.seunewswebsite.entity.Comment;
import com.royzhang.seunewswebsite.repository.CommentRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<CommentDTO> getCommentsByArticleId(Integer articleId) {
        // 从数据库中获取指定文章 ID 的评论实体列表
        List<Comment> comments = commentRepository.findByArticleId(articleId);
        // 将实体列表转换为 DTO 列表
        return comments.stream()
                .map(comment -> modelMapper.map(comment, CommentDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public CommentDTO createComment(CommentDTO commentDTO) {
        // 将 DTO 转换为实体
        Comment comment = modelMapper.map(commentDTO, Comment.class);
        // 保存评论实体到数据库
        Comment savedComment = commentRepository.save(comment);
        // 将保存后的实体转换为 DTO 并返回
        return modelMapper.map(savedComment, CommentDTO.class);
    }

    @Override
    public void deleteComment(Integer commentId) {
        // 根据评论 ID 从数据库中删除评论实体
        commentRepository.deleteById(commentId);
    }

    @Override
    public CommentDTO getCommentById(Integer commentId) {
        // 根据评论 ID 从数据库中查找评论实体
        Optional<Comment> commentOptional = commentRepository.findById(commentId);
        // 如果找到评论实体，则将其转换为 DTO 并返回；否则返回 null
        return commentOptional.map(comment -> modelMapper.map(comment, CommentDTO.class)).orElse(null);
    }

    @Override
    public CommentDTO updateComment(Integer commentId, CommentDTO commentDTO) {
        // 根据评论 ID 从数据库中查找评论实体
        Optional<Comment> commentOptional = commentRepository.findById(commentId);
        if (commentOptional.isPresent()) {
            // 获取评论实体
            Comment comment = commentOptional.get();
            // 更新评论实体的属性
            comment.setContent(commentDTO.getContent());
            comment.setUserId(commentDTO.getUserId());
            // 保存更新后的评论实体到数据库
            Comment updatedComment = commentRepository.save(comment);
            // 将更新后的实体转换为 DTO 并返回
            return modelMapper.map(updatedComment, CommentDTO.class);
        }
        return null;
    }
}
