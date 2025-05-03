package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.MediaDTO;
import com.royzhang.seunewswebsite.service.MediaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/media")
public class MediaController {

    @Autowired
    private MediaService mediaService;

    @GetMapping
    public ResponseEntity<List<MediaDTO>> getAllMedia() {
        List<MediaDTO> mediaList = mediaService.getAllMedia();
        return new ResponseEntity<>(mediaList, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<MediaDTO> getMediaById(@PathVariable Integer id) {
        MediaDTO media = mediaService.getMediaById(id);
        if (media != null) {
            return new ResponseEntity<>(media, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PostMapping
    public ResponseEntity<MediaDTO> createMedia(@RequestBody MediaDTO mediaDTO) {
        MediaDTO createdMedia = mediaService.createMedia(mediaDTO);
        return new ResponseEntity<>(createdMedia, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<MediaDTO> updateMedia(@PathVariable Integer id, @RequestBody MediaDTO mediaDTO) {
        MediaDTO updatedMedia = mediaService.updateMedia(id, mediaDTO);
        if (updatedMedia != null) {
            return new ResponseEntity<>(updatedMedia, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMedia(@PathVariable Integer id) {
        mediaService.deleteMedia(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/article/{articleId}")
    public ResponseEntity<List<MediaDTO>> getMediaByArticleId(@PathVariable Integer articleId) {
        List<MediaDTO> mediaList = mediaService.getMediaByArticleId(articleId);
        return new ResponseEntity<>(mediaList, HttpStatus.OK);
    }
}
