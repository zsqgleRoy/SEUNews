package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.TagDTO;
import com.royzhang.seunewswebsite.entity.Tag;
import com.royzhang.seunewswebsite.repository.TagRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class TagServiceImpl implements TagService {

    @Autowired
    private TagRepository tagRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<TagDTO> getAllTags() {
        List<Tag> tags = tagRepository.findAll();
        return tags.stream()
                .map(tag -> modelMapper.map(tag, TagDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public TagDTO getTagById(Integer id) {
        Optional<Tag> tagOptional = tagRepository.findById(id);
        return tagOptional.map(tag -> modelMapper.map(tag, TagDTO.class)).orElse(null);
    }

    @Override
    public TagDTO createTag(TagDTO tagDTO) {
        Tag tag = modelMapper.map(tagDTO, Tag.class);
        Tag savedTag = tagRepository.save(tag);
        return modelMapper.map(savedTag, TagDTO.class);
    }

    @Override
    public TagDTO updateTag(Integer id, TagDTO tagDTO) {
        Optional<Tag> tagOptional = tagRepository.findById(id);
        if (tagOptional.isPresent()) {
            Tag tag = tagOptional.get();
            tag.setLabel(tagDTO.getLabel());
            Tag updatedTag = tagRepository.save(tag);
            return modelMapper.map(updatedTag, TagDTO.class);
        }
        return null;
    }

    @Override
    public void deleteTag(Integer id) {
        tagRepository.deleteById(id);
    }

    @Override
    public Optional<TagDTO> findTagByName(String label) {
        Optional<Tag> tagOptional = tagRepository.findByLabel(label);
        return tagOptional.map(tag -> modelMapper.map(tag, TagDTO.class));
    }
}
