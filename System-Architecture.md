# System Architecture

> **Relevant source files**
> * [README.md](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/README.md)
> * [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java)

## Purpose and Scope

This document describes the high-level architecture of the SEUNews system, illustrating the relationships between the frontend (Vue3/TypeScript), backend (Spring Boot), and database (MySQL) components. It provides a comprehensive overview of how these systems interact to deliver a cohesive news platform.

For details about how static resources (images, videos, and music) are specifically configured and managed, see [Static Resource Management](/zsqgleRoy/SEUNews/2.1-static-resource-management).

## High-Level Architecture Overview

The SEUNews system implements a modern web application architecture with clear separation of concerns between client and server components.

### System Layers Diagram

```mermaid
flowchart TD

subgraph External_Resources ["External Resources"]
end

subgraph Backend_Layer ["Backend Layer"]
end

subgraph Frontend_Layer ["Frontend Layer"]
end

Browser["Web Browser"]
SPA["Vue3 + TypeScript SPA"]
API["Spring Boot Controllers"]
Services["Service Layer"]
Repositories["Repository Layer"]
Database["MySQL Database"]
StaticResources["File System Storage"]

    Browser --> SPA
    API --> Services
    Services --> Repositories
    Repositories --> Database
    SPA --> API
    API --> SPA
    API --> StaticResources
    SPA --> StaticResources
```

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java)

## Component Interaction Flow

The following diagram illustrates how user requests flow through the system:

```mermaid
sequenceDiagram
  participant User
  participant Browser
  participant VueSPA
  participant Controller
  participant Service
  participant Repository
  participant DB
  participant FileSystem

  User->Browser: Access website or interact
  Browser->VueSPA: Load application
  VueSPA->Controller: HTTP Request
  Controller->Service: Call service method
  Service->Repository: Data access
  Repository->DB: Execute query
  DB->Repository: Return data
  Repository->Service: Map to entities
  Service->Controller: Process & return DTOs
  Controller->VueSPA: JSON Response
  VueSPA->Browser: Update UI
  VueSPA->Controller: Request resource
  Controller->FileSystem: Fetch via WebConfig mapping
  FileSystem->Controller: Return resource
  Controller->VueSPA: Deliver resource
  VueSPA->Browser: Display resource
  VueSPA->Browser: Client-side routing
  Browser->User: Update view
```

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java L11-L15](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java#L11-L15)

## Frontend Architecture

The frontend is built as a Single Page Application (SPA) using Vue3 and TypeScript, providing a responsive and interactive user interface.

### Key Frontend Components

```mermaid
flowchart TD

subgraph API_Communication ["API Communication"]
end

subgraph Vue3_SPA_Components ["Vue3 SPA Components"]
end

App["App Component"]
Router["Vue Router"]
Store["Vuex/Pinia Store"]
ArticleComponents["Article Components"]
UserComponents["User Components"]
AdminComponents["Admin Components"]
HTTPClient["Axios/Fetch Client"]
Backend["Spring Boot Backend"]

    App --> Router
    App --> Store
    Router --> ArticleComponents
    Router --> UserComponents
    Router --> AdminComponents
    Store --> ArticleComponents
    Store --> UserComponents
    Store --> AdminComponents
    ArticleComponents --> HTTPClient
    UserComponents --> HTTPClient
    AdminComponents --> HTTPClient
    HTTPClient --> Backend
```

## Backend Architecture

The backend follows the Spring MVC architecture with a layered design for separation of concerns.

### Spring MVC Implementation

```mermaid
flowchart TD

subgraph Entity_Layer ["Entity Layer"]
end

subgraph Repository_Layer ["Repository Layer"]
end

subgraph Service_Layer ["Service Layer"]
end

subgraph Controller_Layer ["Controller Layer"]
end

AC["ArticleController"]
UC["UserController"]
AFC["ArticleFavoriteController"]
ALC["ArticleLikeController"]
ACC["ArticleCoinController"]
AS["ArticleService"]
US["UserService"]
AFS["ArticleFavoriteService"]
ALS["ArticleLikeService"]
ACS["ArticleCoinService"]
AR["ArticleRepository"]
UR["UserRepository"]
AFR["ArticleFavoriteRepository"]
ALR["ArticleLikeRepository"]
ACR["ArticleCoinRepository"]
AE["Article"]
UE["User"]
AFE["ArticleFavorite"]
ALE["ArticleLike"]
ACE["ArticleCoin"]

    AC --> AS
    UC --> US
    AFC --> AFS
    ALC --> ALS
    ACC --> ACS
    CC --> CS
    AS --> AR
    US --> UR
    AFS --> AFR
    ALS --> ALR
    ACS --> ACR
    CS --> CR
    AR --> AE
    UR --> UE
    AFR --> AFE
    ALR --> ALE
    ACR --> ACE
    CR --> CE
```

### Request Processing Pipeline

The Spring Boot backend processes requests through a well-defined pipeline:

1. **Request Handling**: Controllers receive HTTP requests and validate inputs
2. **Authentication & Authorization**: Security checks are performed
3. **Business Logic**: Services implement the business logic
4. **Data Access**: Repositories interact with the database
5. **Response Formation**: Controllers transform data into appropriate DTOs and return JSON responses

## Static Resource Configuration

SEUNews implements a custom approach to static resource management through Spring's `WebMvcConfigurer` interface.

```mermaid
flowchart TD

subgraph Physical_Storage_Locations ["Physical Storage Locations"]
end

subgraph URL_Mappings ["URL Mappings"]
end

I["/static/news-images/**"]
V["/static/news-videos/**"]
M["/static/news-music/**"]
ID["file:D:/uploads/NewsImg/"]
VD["file:D:/uploads/NewsVideo/"]
MD["file:D:/uploads/NewsMusic/"]
WebConfig["WebConfig class"]

    I --> ID
    V --> VD
    M --> MD
    WebConfig --> I
    WebConfig --> V
    WebConfig --> M
```

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java L11-L15](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java#L11-L15)

## Client-Side Routing Support

The system supports client-side routing for the SPA by configuring specific view controllers to forward requests to the frontend application:

```mermaid
flowchart TD

subgraph Forward_Target ["Forward Target"]
end

subgraph URL_Patterns ["URL Patterns"]
end

Root["/"]
SimplePattern["/{x:[\w\-]+}"]
ComplexPattern["/{x:^(?!api|admin|static|favicon.ico).*$}"]
Index["index.html"]
WebConfig["WebConfig.addViewControllers()"]

    Root --> Index
    SimplePattern --> Index
    ComplexPattern --> Index
    WebConfig --> Root
    WebConfig --> SimplePattern
    WebConfig --> ComplexPattern
```

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java L16-L21](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java#L16-L21)

## Domain Model Architecture

The system's core domain model is centered around Articles, with various related entities to support user interactions and content management:

```mermaid
classDiagram
    class Article {
        +Integer articleId
        +String title
        +String content
        +Date publishDate
        +Date updateDate
        +Integer authorId
        +ArticleStatus status
        +Long likeNum
        +Long coinNum
        +Long favoriteNum
        +Long shareNum
    }
    class ArticleLike {
        +Integer likeId
        +Integer articleId
        +Integer userId
        +Date createTime
    }
    class ArticleFavorite {
        +Integer favoriteId
        +Integer articleId
        +Integer userId
        +Date createTime
    }
    class ArticleCoin {
        +Integer coinId
        +Integer articleId
        +Integer userId
        +Integer coinNum
        +Date createTime
    }
    class Comment {
    }
    class Category {
    }
    class Tag {
    }
    class User {
        +Integer userId
        +String userName
        +String password
        +String email
        +Boolean isAuthor
        +String avatar
    }
    class Role {
    }
    Article -- ArticleLike : receives
    Article -- ArticleFavorite : receives
    Article -- ArticleCoin : receives
    Article -- Comment : has
    Article -- Category : belongs to
    Article -- Tag : has
    User -- Article : authors
    User -- ArticleLike : gives
    User -- ArticleFavorite : creates
    User -- ArticleCoin : gives
    User -- Comment : writes
    User -- Role : has
```

## Data Flow Architecture

The following diagram illustrates the data flow through the system components:

```mermaid
flowchart TD

subgraph Spring_MVC_Backend ["Spring MVC Backend"]
    Client["Vue3 Client"]
end

Controller["Controllers"]
DTOs["DTOs"]
Service["Services"]
Repository["Repositories"]
Entity["Entity Model"]
Database["MySQL Database"]
FileSystem["External File Storage"]

    Client --> Controller
    Controller --> DTOs
    Controller --> Service
    Service --> Repository
    Repository --> Entity
    Entity --> Database
    Database --> Entity
    Entity --> Repository
    Repository --> Service
    Service --> DTOs
    DTOs --> Controller
    Controller --> Client
    Controller --> FileSystem
    FileSystem --> Controller
```

## API Gateway Pattern

The controller layer acts as an API Gateway, providing a unified entry point for frontend requests and handling cross-cutting concerns:

```mermaid
flowchart TD

subgraph Core_Services ["Core Services"]
end

subgraph CrossCutting_Concerns ["Cross-Cutting Concerns"]
end

subgraph API_Gateway_Layer ["API Gateway Layer"]
    Client["Vue3 Client"]
end

ArticleAPI["ArticleController"]
UserAPI["UserController"]
AuthAPI["AuthController"]
MediaAPI["MediaController"]
Auth["Authentication"]
Validation["Input Validation"]
ErrorHandling["Error Handling"]
ResourceMapping["Resource Mapping"]
ArticleService["ArticleService"]
UserService["UserService"]
MediaService["MediaService"]

    Client --> ArticleAPI
    Client --> UserAPI
    Client --> AuthAPI
    Client --> MediaAPI
    ArticleAPI --> Auth
    ArticleAPI --> Validation
    ArticleAPI --> ErrorHandling
    ArticleAPI --> ArticleService
    UserAPI --> Auth
    UserAPI --> Validation
    UserAPI --> ErrorHandling
    UserAPI --> UserService
    MediaAPI --> Auth
    MediaAPI --> ResourceMapping
    MediaAPI --> MediaService
```

## Summary

The SEUNews application implements a modern, layered architecture with clear separation of concerns. The system follows a client-server model with:

1. **Frontend Layer**: A Vue3/TypeScript Single Page Application
2. **Backend Layer**: Spring Boot implementing MVC pattern with controllers, services, and repositories
3. **Database Layer**: MySQL database for persistent storage
4. **External Storage**: File system storage for media content

Key architectural patterns used include:

* MVC (Model-View-Controller)
* Repository pattern for data access
* DTO pattern for API communication
* Layered architecture for separation of concerns
* Single Page Application for frontend
* REST API for communication between frontend and backend

The system's architecture provides a solid foundation for a scalable, maintainable news website with rich features for content management and user interaction.

Sources: [SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/SEUNewsWebsite/src/main/java/com/royzhang/seunewswebsite/WebConfig.java)

 [README.md](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/README.md)