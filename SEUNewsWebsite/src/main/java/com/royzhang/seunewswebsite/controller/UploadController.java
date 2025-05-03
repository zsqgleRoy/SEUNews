package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.Article.MediaDTO;
import com.royzhang.seunewswebsite.dto.Article.MediaReturnDTO;
import com.royzhang.seunewswebsite.service.MediaService;
import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import jakarta.annotation.PostConstruct;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/upload")
public class UploadController {

    @Autowired
    private MediaService mediaService;

    // 允许的图片类型白名单
    private static final List<String> ALLOWED_MIME_TYPES = Arrays.asList(
            "image/jpeg",
            "image/png",
            "image/gif",
            "image/webp"
    );

    @Value("${upload.news-img-path}")
    private String uploadPath;

    @Value("${upload.access-url}")
    private String accessBaseUrl;

    // 初始化时创建目录
    @PostConstruct
    public void init() throws IOException {
        Path path = Paths.get(uploadPath);
        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }
    }

    @PostMapping("/newsImg")
    public ResponseEntity<ApiResponse<MediaReturnDTO>> handleFileUpload(
            @RequestParam("file") MultipartFile file,
            @RequestHeader("Authorization") String token) {
        try {
            // 1. 权限验证//========================================================
            if (validateToken(token)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(ApiResponse.error("未授权的访问" + token)
                        );
            }

            // 2. 文件校验
            if (file.isEmpty()) {
                return ResponseEntity.badRequest()
                        .body(ApiResponse.error("文件不能为空"));
            }

            if (!ALLOWED_MIME_TYPES.contains(file.getContentType())) {
                return ResponseEntity.badRequest()
                        .body(ApiResponse.error("仅支持JPEG/PNG/GIF/WEBP格式"));
            }

            // 3. 生成安全文件名
            String originalFilename = file.getOriginalFilename();
            String fileExt = null;
            if (originalFilename != null) {
                fileExt = getFileExtension(originalFilename);
            }
            String safeFilename = generateSafeFilename(fileExt);

            // 4. 安全存储路径
            Path targetPath = Paths.get(uploadPath).resolve(safeFilename);
            if (!targetPath.normalize().startsWith(uploadPath)) {
                throw new IOException("非法文件路径");
            }

            // 5. 保存文件
            Files.copy(file.getInputStream(), targetPath);

            // 6. 生成访问URL
            MediaReturnDTO info = new MediaReturnDTO();

            info.setUrl(String.format("%s/%s", accessBaseUrl, safeFilename));
            // 记录日志
            logUploadSuccess(originalFilename, safeFilename, file.getSize());
            System.out.println(info.getError() + "" + info.getData());
            return ResponseEntity.ok()
                    .header("Content-Type", "application/json")
                    .body(ApiResponse.success("上传成功", info));


        } catch (IOException e) {
            logUploadError(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error("文件上传失败"));
        }
    }

    // 辅助方法
    private String generateSafeFilename(String fileExt) {
        String timestamp = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS"));
        String uuid = UUID.randomUUID().toString().substring(0, 8);
        return String.format("%s_%s.%s", timestamp, uuid, fileExt);
    }

    private String getFileExtension(String filename) {
        int dotIndex = filename.lastIndexOf(".");
        if (dotIndex == -1) return "bin";
        return filename.substring(dotIndex + 1).toLowerCase();
    }

    private boolean validateToken(String token) {
        return token == null || token.isEmpty();
    }

    private void logUploadSuccess(String originalName, String savedName, long size) {
        String log = String.format("[SUCCESS] Original: %s, Saved: %s, Size: %d bytes, Time: %s",
                originalName,
                savedName,
                size,
                LocalDateTime.now());
        System.out.println(log);
    }

    private void logUploadError(Exception e) {
        String log = String.format("[ERROR] %s - %s",
                LocalDateTime.now(),
                e.getMessage());
        System.out.println(log);
    }

    // 统一响应格式
    @Getter
    @Setter
    private static class ApiResponse<T> {
        private int code;
        private String message;
        private T data;

        private ApiResponse(int code, String message, T data) {
            this.code = code;
            this.message = message;
            this.data = data;
        }

        public static <T> ApiResponse<T> success(String message, T data) {
            return new ApiResponse<>(200, message, data);
        }

        public static <T> ApiResponse<T> error(String message) {
            return new ApiResponse<>(500, message, null);
        }
    }
}