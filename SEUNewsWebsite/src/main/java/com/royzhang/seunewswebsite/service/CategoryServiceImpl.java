// CategoryServiceImpl.java
package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.CategoryDTO;
import com.royzhang.seunewswebsite.entity.Category;
import com.royzhang.seunewswebsite.repository.CategoryRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<CategoryDTO> getAllCategories() {
        List<Category> categories = categoryRepository.findAll();
        return categories.stream()
                .map(category -> modelMapper.map(category, CategoryDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public CategoryDTO getCategoryById(Integer id) {
        Optional<Category> categoryOptional = categoryRepository.findById(id);
        return categoryOptional.map(category -> modelMapper.map(category, CategoryDTO.class)).orElse(null);
    }

    @Override
    public CategoryDTO createCategory(CategoryDTO categoryDTO) {
        Category category = modelMapper.map(categoryDTO, Category.class);
        Category savedCategory = categoryRepository.save(category);
        return modelMapper.map(savedCategory, CategoryDTO.class);
    }

    @Override
    public CategoryDTO updateCategory(Integer id, CategoryDTO categoryDTO) {
        Optional<Category> categoryOptional = categoryRepository.findById(id);
        if (categoryOptional.isPresent()) {
            Category category = categoryOptional.get();
            category.setName(categoryDTO.getName());
            category.setDescription(categoryDTO.getDescription());
            Category updatedCategory = categoryRepository.save(category);
            return modelMapper.map(updatedCategory, CategoryDTO.class);
        }
        return null;
    }

    @Override
    public void deleteCategory(Integer id) {
        categoryRepository.deleteById(id);
    }
}