package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleVersionDTO;
import com.royzhang.seunewswebsite.entity.ArticleVersion;
import com.royzhang.seunewswebsite.repository.ArticleVersionRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ArticleVersionServiceImpl implements ArticleVersionService {

    @Autowired
    private ArticleVersionRepository articleVersionRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<ArticleVersionDTO> getAllVersionsByArticleId(Integer articleId) {
        List<ArticleVersion> versionList = articleVersionRepository.findByArticleId(articleId);
        return versionList.stream()
                .map(version -> modelMapper.map(version, ArticleVersionDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public ArticleVersionDTO getVersionById(Integer versionId) {
        Optional<ArticleVersion> versionOptional = articleVersionRepository.findById(versionId);
        return versionOptional.map(version -> modelMapper.map(version, ArticleVersionDTO.class)).orElse(null);
    }

    @Override
    public ArticleVersionDTO createArticleVersion(ArticleVersionDTO articleVersionDTO) {
        ArticleVersion articleVersion = modelMapper.map(articleVersionDTO, ArticleVersion.class);
        ArticleVersion savedVersion = articleVersionRepository.save(articleVersion);
        return modelMapper.map(savedVersion, ArticleVersionDTO.class);
    }

    @Override
    public ArticleVersionDTO updateArticleVersion(Integer versionId, ArticleVersionDTO articleVersionDTO) {
        Optional<ArticleVersion> versionOptional = articleVersionRepository.findById(versionId);
        if (versionOptional.isPresent()) {
            ArticleVersion articleVersion = versionOptional.get();
            articleVersion.setContent(articleVersionDTO.getContent());
            articleVersion.setVersionNumber(articleVersionDTO.getVersionNumber());
            ArticleVersion updatedVersion = articleVersionRepository.save(articleVersion);
            return modelMapper.map(updatedVersion, ArticleVersionDTO.class);
        }
        return null;
    }

    @Override
    public void deleteArticleVersion(Integer versionId) {
        articleVersionRepository.deleteById(versionId);
    }
}
