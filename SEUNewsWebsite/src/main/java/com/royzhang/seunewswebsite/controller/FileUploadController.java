package com.royzhang.seunewswebsite.controller;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@RestController
public class FileUploadController {

    @Value("${upload.path}")
    private String uploadPath;

    @PostMapping("/upload")
    public ResponseEntity<?> uploadImage(@RequestParam("image") MultipartFile file) {
        if (file.isEmpty()) {
            return new ResponseEntity<>("未上传图片", HttpStatus.BAD_REQUEST);
        }

        try {
            // 确保上传目录存在
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 生成唯一的文件名
            String fileName = UUID.randomUUID().toString() + "-" + file.getOriginalFilename();
            Path filePath = Paths.get(uploadPath, fileName);

            // 保存文件
            Files.write(filePath, file.getBytes());

            // 返回图片的访问 URL
            String imageUrl = "/static/Upload/NewsImg/" + fileName;
            return new ResponseEntity<>(new ImageResponse(imageUrl), HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>("图片上传失败", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Setter
    @Getter
    static class ImageResponse {
        private String url;

        public ImageResponse(String url) {
            this.url = url;
        }

    }
}
