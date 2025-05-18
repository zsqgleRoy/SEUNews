package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.TagDTO;

import java.util.List;
import java.util.Optional;

public interface TagService {
    // 获取所有标签
    List<TagDTO> getAllTags();

    // 根据 ID 获取标签
    TagDTO getTagById(Integer id);

    // 创建标签
    TagDTO createTag(TagDTO tagDTO);

    // 更新标签信息
    TagDTO updateTag(Integer id, TagDTO tagDTO);

    // 删除标签
    void deleteTag(Integer id);

    // 根据标签名查找标签
    Optional<TagDTO> findTagByName(String name);
}
