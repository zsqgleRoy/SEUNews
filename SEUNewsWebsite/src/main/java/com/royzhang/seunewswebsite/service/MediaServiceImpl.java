package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.MediaDTO;
import com.royzhang.seunewswebsite.entity.Article;
import com.royzhang.seunewswebsite.entity.Media;
import com.royzhang.seunewswebsite.repository.MediaRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class MediaServiceImpl implements MediaService {

    @Autowired
    private MediaRepository mediaRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<MediaDTO> getAllMedia() {
        List<Media> mediaList = mediaRepository.findAll();
        return mediaList.stream()
                .map(media -> modelMapper.map(media, MediaDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public MediaDTO getMediaById(Integer id) {
        Optional<Media> mediaOptional = mediaRepository.findById(id);
        return mediaOptional.map(media -> modelMapper.map(media, MediaDTO.class)).orElse(null);
    }

    @Override
    public MediaDTO createMedia(MediaDTO mediaDTO) {
        Media media = modelMapper.map(mediaDTO, Media.class);
        Media savedMedia = mediaRepository.save(media);
        return modelMapper.map(savedMedia, MediaDTO.class);
    }

    @Override
    public MediaDTO updateMedia(Integer id, MediaDTO mediaDTO) {
        Optional<Media> mediaOptional = mediaRepository.findById(id);
        if (mediaOptional.isPresent()) {
            Media media = mediaOptional.get();
            media.setFilePath(mediaDTO.getFilePath());
            media.setArticleId(mediaDTO.getArticleId());
            Media updatedMedia = mediaRepository.save(media);
            return modelMapper.map(updatedMedia, MediaDTO.class);
        }
        return null;
    }

    @Override
    public void deleteMedia(Integer id) {
        mediaRepository.deleteById(id);
    }

    @Override
    public List<MediaDTO> getMediaByArticleId(Integer articleId) {
        List<Media> mediaList = mediaRepository.findByArticleId(articleId);
        return mediaList.stream()
                .map(media -> modelMapper.map(media, MediaDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public String getHeadImageUrl(Integer article_id) {
        return mediaRepository.findByArticleId(article_id).get(0).getFilePath();
    }

    @Override
    public boolean saveMedia(MediaDTO mediaDTO){
        Media media = modelMapper.map(mediaDTO, Media.class);
        Media savedMedia = mediaRepository.save(media);
        return savedMedia != null;
    }
}
