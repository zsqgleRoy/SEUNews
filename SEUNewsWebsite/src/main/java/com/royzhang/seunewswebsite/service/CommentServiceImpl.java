package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.CommentDTO;
import com.royzhang.seunewswebsite.entity.Comment;
import com.royzhang.seunewswebsite.repository.CommentRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
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
        List<Object[]> results = commentRepository.findCommentsWithUserInfo(articleId);
        return results.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    private CommentDTO convertToDTO(Object[] result) {
        return CommentDTO.builder()
                .commentId((Integer) result[0])
                .content((String) result[1])
                .publishDate((Date) result[2])
                .userId((Integer) result[3])
                .username((String) result[4])
                .avatar((String) result[5])
                .ip((String) result[6])
                .build();
    }

    @Override
    public CommentDTO createComment(CommentDTO commentDTO) {
        commentDTO.setIsDeleted(0);
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


    private CommentDTO convertToDTO(Comment comment) {
        return CommentDTO.builder()
                .commentId(comment.getCommentId())
                .articleId(comment.getArticleId())
                .userId(comment.getUserId())
                .content(comment.getContent())
                .publishDate(comment.getPublishDate())
                .ip(comment.getIp())
                .isDeleted(comment.getIsDeleted())
                .username(comment.getUser().getUsername()) // 从关联用户获取
                .avatar(comment.getUser().getAvatar())     // 从关联用户获取
                .build();
    }

    @Override
    public List<CommentDTO> getCommentsByUserId(Integer userId) {
        List<Comment> comments = commentRepository.findCommentsWithUserByUserId(userId);
        return comments.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }
}
