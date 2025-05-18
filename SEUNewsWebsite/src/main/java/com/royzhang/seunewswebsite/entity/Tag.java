package com.royzhang.seunewswebsite.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "tags")
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "articles")
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Tag {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="tag_id")
    @EqualsAndHashCode.Include
    private Integer tagId;

    @Column(name="label")
    private String label;

    @Column(name="path")
    private String path;

    @JsonIgnoreProperties("articles")
    @ManyToMany(mappedBy = "tags")
    @JsonBackReference
    private Set<Article> articles = new HashSet<>();

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Tag)) return false;
        return tagId != null && tagId.equals(((Tag) o).getTagId());
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}
