package com.royzhang.seunewswebsite.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import lombok.*;

@Entity
@Table(name = "articles")
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "tags")
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Article {
    @Id
    @Column(name = "article_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private Integer articleId;

    @Column(name = "title")
    private String title;

    @Column(columnDefinition = "Text")
    private String content;

    @Column(name = "publish_date")
    private Date publishDate;

    @Column(name = "update_date")
    private Date updateDate;

    @Column(name = "author_id")
    private Integer authorId;

    @Column(name = "like_num")
    private long likeNum;

    @Column(name = "coin_num")
    private long coinNum;

    @Column(name = "favorit_num")
    private long favoritNum;

    @Column(name = "share_num")
    private long shareNum;

    @Column(name = "last_operator_id")
    private Integer lastOperatorId;

    @Enumerated(EnumType.STRING)
    private ArticleStatus status;

    @Column(name = "head_image_url")
    private String headImageUrl;

    @Column(name = "is_deleted")
    private Integer isDeleted;

    public enum ArticleStatus {
        DRAFT, PUBLISHED
    }

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(
            name = "article_tags",
            joinColumns = @JoinColumn(name = "article_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    @JsonManagedReference
    private Set<Tag> tags = new HashSet<>();

    public void addTag(Tag tag) {
        tags.add(tag);
        tag.getArticles().add(this);
    }

    public void removeTag(Tag tag) {
        tags.remove(tag);
        tag.getArticles().remove(this);
    }

    public void replaceTags(Set<Tag> newTags) {
        Set<Tag> currentTags = new HashSet<>(this.tags);

        currentTags.stream()
                .filter(tag -> !newTags.contains(tag))
                .forEach(tag -> {
                    tag.getArticles().remove(this);
                    this.tags.remove(tag);
                });

        newTags.stream()
                .filter(tag -> !currentTags.contains(tag))
                .forEach(tag -> {
                    tag.getArticles().add(this);
                    this.tags.add(tag);
                });
    }

    public void syncTags(Set<Tag> newTags) {
        Set<Tag> toRemove = new HashSet<>(this.tags);
        toRemove.removeAll(newTags);

        Set<Tag> toAdd = new HashSet<>(newTags);
        toAdd.removeAll(this.tags);

        toRemove.forEach(tag -> {
            tag.getArticles().remove(this);
            this.tags.remove(tag);
        });

        toAdd.forEach(tag -> {
            tag.getArticles().add(this);
            this.tags.add(tag);
        });
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Article)) return false;
        return articleId != null && articleId.equals(((Article) o).getArticleId());
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}
