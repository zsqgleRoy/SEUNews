package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.TagDTO;
import com.royzhang.seunewswebsite.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/tags")
public class TagController {

    @Autowired
    private TagService tagService;

    @GetMapping
    public ResponseEntity<List<TagDTO>> getAllTags() {
        List<TagDTO> tags = tagService.getAllTags();
        return new ResponseEntity<>(tags, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<TagDTO> getTagById(@PathVariable Integer id) {
        TagDTO tag = tagService.getTagById(id);
        if (tag != null) {
            return new ResponseEntity<>(tag, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PostMapping
    public ResponseEntity<TagDTO> createTag(@RequestBody TagDTO tagDTO) {
        TagDTO createdTag = tagService.createTag(tagDTO);
        return new ResponseEntity<>(createdTag, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<TagDTO> updateTag(@PathVariable Integer id, @RequestBody TagDTO tagDTO) {
        TagDTO updatedTag = tagService.updateTag(id, tagDTO);
        if (updatedTag != null) {
            return new ResponseEntity<>(updatedTag, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTag(@PathVariable Integer id) {
        tagService.deleteTag(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/name/{name}")
    public ResponseEntity<TagDTO> findTagByName(@PathVariable String name) {
        Optional<TagDTO> tagOptional = tagService.findTagByName(name);
        return tagOptional.map(tagDTO -> new ResponseEntity<>(tagDTO, HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }
    @GetMapping("/list")
    public ResponseEntity<List<TagDTO>> findAllTags() {
        List<TagDTO> tags = tagService.getAllTags();
        return new ResponseEntity<>(tags, HttpStatus.OK);
    }
}
