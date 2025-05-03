package com.royzhang.seunewswebsite.dto.Article;

public class CategoryDTO {
    private Integer categoryId;
    private String name;
    private String description;

    // 构造函数、Getter 和 Setter

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
