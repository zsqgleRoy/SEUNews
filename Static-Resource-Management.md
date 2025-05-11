# Static Resource Management

> **Relevant source files**
> * [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java)
> * [images/2025-05-03-09-05-23-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-09-05-23-image.png)
> * [images/2025-05-03-09-51-12-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-09-51-12-image.png)

This page documents the static resource management system in the SEU News website, explaining how various media files are configured, stored, and served to users. The system handles multiple media types including images, videos, and music files that are associated with news articles.

For information about media handling in article management, see [Article Management System](/zsqgleRoy/SEUNews/5-article-management-system).

## Overview

The SEU News system implements a custom static resource handling mechanism that maps specific URL patterns to physical file locations outside the application. This allows the separation of uploadable content from the application code, making the system more maintainable and scalable.

Static resources in this context refer to:

1. News images (photos, graphics, etc.)
2. News videos
3. News audio/music files

These media files are stored in predefined directories on the server's file system and are accessible through mapped URL paths.

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java L11-L15](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java#L11-L15)

## Configuration

The static resource management is configured in the `WebConfig` class which implements Spring's `WebMvcConfigurer` interface. This configuration maps URL patterns to physical file locations.

### Static Resource Mapping Configuration

```

```

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java L11-L15](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java#L11-L15)

The key configuration is implemented in the `addResourceHandlers` method of the `WebConfig` class:

1. URL patterns are defined using Ant-style pattern matching
2. Each pattern is associated with a physical file location using the `addResourceLocations` method
3. The `file:` prefix indicates that resources are stored on the file system rather than the classpath

## Resource Types and Storage

The system manages three main types of static resources:

| Resource Type | URL Pattern | Physical Location |
| --- | --- | --- |
| News Images | `/static/news-images/**` | `D:/uploads/NewsImg/` |
| News Videos | `/static/news-videos/**` | `D:/uploads/NewsVideo/` |
| News Music | `/static/news-music/**` | `D:/uploads/NewsMusic/` |

### Storage Structure

```

```

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java L13-L14](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java#L13-L14)

## Resource Access Flow

The following diagram illustrates how static resources are requested and served in the SEU News system:

```

```

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java L11-L15](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java#L11-L15)

## Integration with Domain Model

Static resources are related to news articles in the domain model. Each article can contain multiple media items:

```

```

The `url` field in the Media entity typically contains the relative path to the resource (e.g., `/static/news-images/example.jpg`), which is resolved by the Spring MVC framework using the configuration defined in `WebConfig`.

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java L11-L15](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java#L11-L15)

## Resource Retrieval in Frontend

In the Vue3 frontend, static resources are typically referenced using their URL paths. For example, an image might be displayed using:

```

```

The browser will automatically make a request to the appropriate URL, which will be handled by the Spring MVC framework according to the mappings defined in `WebConfig`.

## SPA Routing and Static Resources

The `WebConfig` class also configures view controllers to handle SPA routing, ensuring that routes are properly forwarded to the frontend application while still allowing static resource requests to be processed correctly:

```

```

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java L16-L21](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java#L16-L21)

The view controller configuration ensures that:

1. Requests to `/static/**` paths are handled by the static resource handler
2. All other non-API paths are forwarded to `index.html` to allow the SPA to handle routing

## Best Practices and Considerations

When working with the static resource management system in SEU News, consider the following:

1. **Resource organization**: Maintain a consistent organization within each resource directory
2. **File naming**: Use consistent naming conventions for uploaded files
3. **Access control**: Remember that files in these directories are publicly accessible
4. **Resource validation**: Implement validation for uploaded content before saving to these directories
5. **Backup strategy**: Include these directories in regular backup procedures

## Deployment Considerations

When deploying the SEU News system to a new environment, the following adjustments might be necessary:

1. Create the required directories (`D:/uploads/NewsImg/`, etc.) or update the configuration to use different paths
2. Ensure proper file permissions for the directories
3. Consider using a CDN or object storage service for high-traffic deployments
4. Update the configuration if the directory structure differs between development and production environments