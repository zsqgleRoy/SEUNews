package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.MediaDTO;

import java.util.List;

public interface MediaService {
    // 获取所有媒体资源
    List<MediaDTO> getAllMedia();

    // 根据 ID 获取媒体资源
    MediaDTO getMediaById(Integer id);

    // 创建媒体资源
    MediaDTO createMedia(MediaDTO mediaDTO);

    // 更新媒体资源信息
    MediaDTO updateMedia(Integer id, MediaDTO mediaDTO);

    // 删除媒体资源
    void deleteMedia(Integer id);

    // 根据文章 ID 获取媒体资源列表
    List<MediaDTO> getMediaByArticleId(Integer articleId);

    String getHeadImageUrl(Integer articleId);

    boolean saveMedia(MediaDTO mediaDTO);
}
