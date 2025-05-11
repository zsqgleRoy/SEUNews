# System Diagrams and Visual Documentation

> **Relevant source files**
> * [images/2025-05-03-09-05-23-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-09-05-23-image.png)
> * [images/2025-05-03-09-20-50-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-09-20-50-image.png)
> * [images/2025-05-03-09-21-19-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-09-21-19-image.png)
> * [images/2025-05-03-09-27-24-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-09-27-24-image.png)
> * [images/2025-05-03-09-51-12-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-09-51-12-image.png)
> * [images/2025-05-03-10-00-35-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-10-00-35-image.png)
> * [images/2025-05-03-10-02-45-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-10-02-45-image.png)
> * [images/2025-05-03-10-04-57-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-10-04-57-image.png)
> * [images/2025-05-03-10-05-07-image.png](https://github.com/zsqgleRoy/SEUNews/blob/9be5e28c/images/2025-05-03-10-05-07-image.png)

## Purpose and Scope

This document provides comprehensive visual representations of the SEU News system architecture, component interactions, data flows, and key system processes. These diagrams serve as technical reference material for developers working on the codebase, offering insights into system organization, architecture decisions, and component relationships.

For information about static resource handling specifically, see [Static Resource Management](/zsqgleRoy/SEUNews/2.1-static-resource-management).

## System Architecture Overview

The SEU News system follows a modern web application architecture with clear separation between frontend, backend, and database components. The architecture is designed to support a full-featured news website with user management, article management, and monetization features.

### High-Level System Architecture

```

```

Sources: images/2025-05-03-09-05-23-image.png

### Backend Architecture

The backend follows the Spring MVC architecture pattern with clear separation of concerns between controllers, services, and repositories.

```mermaid
flowchart TD

subgraph Entity_Layer ["Entity Layer"]
end

subgraph DTO_Layer ["DTO Layer"]
end

subgraph Repository_Layer ["Repository Layer"]
end

subgraph Service_Layer ["Service Layer"]
end

subgraph Controller_Layer ["Controller Layer"]
    Client["Client"]
end

Controller["ArticleController"]
FavController["ArticleFavoriteController"]
LikeController["ArticleLikeController"]
AuthController["Authentication Controller"]
AService["ArticleService"]
FavService["ArticleFavoriteService"]
LikeService["ArticleLikeService"]
UserService["UserService"]
ARepo["ArticleRepository"]
FavRepo["ArticleFavoriteRepository"]
LikeRepo["ArticleLikeRepository"]
UserRepo["UserRepository"]
DTO["ArticleDTO"]
InsertDTO["ArticleInsertDTO"]
UpdateDTO["ArticleUpdateDTO"]
FrontDTO["ArticleFrontDTO"]
Entity["Article"]
FavEntity["ArticleFavorite"]
LikeEntity["ArticleLike"]
CoinEntity["ArticleCoin"]

    Client --> Controller
    Controller --> AService
    FavController --> FavService
    LikeController --> LikeService
    AService --> ARepo
    FavService --> FavRepo
    LikeService --> LikeRepo
    ARepo --> Entity
    FavRepo --> FavEntity
    LikeRepo --> LikeEntity
    Controller --> DTO
    Controller --> InsertDTO
    Controller --> UpdateDTO
    Controller --> FrontDTO
    AService --> DTO
    AService --> InsertDTO
    AService --> UpdateDTO
```

Sources: images/2025-05-03-09-05-23-image.png

## Domain Model Representation

The system is built around several key domain entities, with Articles being the central concept.

### Core Domain Models

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
    }
    class ArticleFavorite {
    }
    class ArticleCoin {
    }
    class Comment {
    }
    class Category {
    }
    class Tag {
    }
    class Media {
    }
    class User {
        +Integer userId
        +String userName
        +String password
        +String email
        +Boolean isAuthor
    }
    class Role {
    }
    class VIP {
    }
    class Order {
    }
    class ChatRecord {
    }
    class ArticleStatus {
        «enumeration»
        DRAFT
        PUBLISHED
    }
    Article -- ArticleLike : receives
    Article -- ArticleFavorite : receives
    Article -- ArticleCoin : receives
    Article -- Comment : has
    Article -- Category : belongs to
    Article -- Tag : has
    Article -- Media : contains
    User -- Article : authors
    User -- ArticleLike : gives
    User -- ArticleFavorite : creates
    User -- ArticleCoin : gives
    User -- Comment : writes
    User -- Role : has
    User -- VIP : subscribes to
    User -- Order : places
    User -- ChatRecord : participates in
```

Sources: images/2025-05-03-09-05-23-image.png

## Database Schema

The database schema supports all aspects of the news website including articles, users, interactions, and monetization.

```
#mermaid-l6mzl49rq1s{font-family:ui-sans-serif,-apple-system,system-ui,Segoe UI,Helvetica;font-size:16px;fill:#333;}@keyframes edge-animation-frame{from{stroke-dashoffset:0;}}@keyframes dash{to{stroke-dashoffset:0;}}#mermaid-l6mzl49rq1s .edge-animation-slow{stroke-dasharray:9,5!important;stroke-dashoffset:900;animation:dash 50s linear infinite;stroke-linecap:round;}#mermaid-l6mzl49rq1s .edge-animation-fast{stroke-dasharray:9,5!important;stroke-dashoffset:900;animation:dash 20s linear infinite;stroke-linecap:round;}#mermaid-l6mzl49rq1s .error-icon{fill:#dddddd;}#mermaid-l6mzl49rq1s .error-text{fill:#222222;stroke:#222222;}#mermaid-l6mzl49rq1s .edge-thickness-normal{stroke-width:1px;}#mermaid-l6mzl49rq1s .edge-thickness-thick{stroke-width:3.5px;}#mermaid-l6mzl49rq1s .edge-pattern-solid{stroke-dasharray:0;}#mermaid-l6mzl49rq1s .edge-thickness-invisible{stroke-width:0;fill:none;}#mermaid-l6mzl49rq1s .edge-pattern-dashed{stroke-dasharray:3;}#mermaid-l6mzl49rq1s .edge-pattern-dotted{stroke-dasharray:2;}#mermaid-l6mzl49rq1s .marker{fill:#999;stroke:#999;}#mermaid-l6mzl49rq1s .marker.cross{stroke:#999;}#mermaid-l6mzl49rq1s svg{font-family:ui-sans-serif,-apple-system,system-ui,Segoe UI,Helvetica;font-size:16px;}#mermaid-l6mzl49rq1s p{margin:0;}#mermaid-l6mzl49rq1s .entityBox{fill:#ffffff;stroke:#dddddd;}#mermaid-l6mzl49rq1s .relationshipLabelBox{fill:#dddddd;opacity:0.7;background-color:#dddddd;}#mermaid-l6mzl49rq1s .relationshipLabelBox rect{opacity:0.5;}#mermaid-l6mzl49rq1s .labelBkg{background-color:rgba(221, 221, 221, 0.5);}#mermaid-l6mzl49rq1s .edgeLabel .label{fill:#dddddd;font-size:14px;}#mermaid-l6mzl49rq1s .label{font-family:ui-sans-serif,-apple-system,system-ui,Segoe UI,Helvetica;color:#333;}#mermaid-l6mzl49rq1s .edge-pattern-dashed{stroke-dasharray:8,8;}#mermaid-l6mzl49rq1s .node rect,#mermaid-l6mzl49rq1s .node circle,#mermaid-l6mzl49rq1s .node ellipse,#mermaid-l6mzl49rq1s .node polygon{fill:#ffffff;stroke:#dddddd;stroke-width:1px;}#mermaid-l6mzl49rq1s .relationshipLine{stroke:#999;stroke-width:1;fill:none;}#mermaid-l6mzl49rq1s .marker{fill:none!important;stroke:#999!important;stroke-width:1;}#mermaid-l6mzl49rq1s :root{--mermaid-font-family:"trebuchet ms",verdana,arial,sans-serif;}tracks_changesbelongs_tohascontainsreceivesreceivesreceiveshasauthorsgivescreatesgiveswriteshassubscribes_toplacesparticipates_incategorizestagsassigned_topurchased_byARTICLESintarticle_idPKvarchartitletextcontentdatetimepublish_datedatetimeupdate_dateintauthor_idFKenumstatusintis_deletedintlast_operator_idbigintlike_numbigintcoin_numbigintfavorit_numbigintshare_numARTICLE_VERSIONSARTICLE_CATEGORIESARTICLE_TAGSMEDIAARTICLE_LIKESARTICLE_FAVORITESARTICLE_COINSCOMMENTSUSERSintuser_idPKvarcharuser_namevarcharpasswordvarcharemailenumis_authorvarcharavatarUSER_ROLE_RELATIONSUSER_VIP_RELATIONSORDERSCHAT_RECORDSCATEGORIESTAGSUSER_ROLESVIP
```

Sources: images/2025-05-03-09-05-23-image.png

## Request Processing Flow

The system processes requests using a standard flow pattern with support for Single Page Application (SPA) routing.

```mermaid
sequenceDiagram
  participant User
  participant Browser
  participant Vue3SPA
  participant SpringMVC
  participant Service
  participant Repository
  participant Database

  User->Browser: Enter URL or Click Link
  Browser->SpringMVC: HTTP Request
  SpringMVC->Repository: Get Resource
  Repository->SpringMVC: Return Resource
  SpringMVC->Browser: Return File
  Browser->User: Display Resource
  SpringMVC->Service: Call Service Method
  Service->Repository: Query Data
  Repository->Database: SQL Query
  Database->Repository: Return Data
  Repository->Service: Return Entities
  Service->SpringMVC: Return DTOs
  SpringMVC->Browser: Return JSON
  Browser->Vue3SPA: Update State
  Vue3SPA->User: Update UI
  SpringMVC->Browser: Forward to index.html
  Browser->Vue3SPA: Initialize SPA
  Vue3SPA->User: Render Page
```

Sources: images/2025-05-03-09-05-23-image.png

## Static Resource Management

The system uses custom configuration to map static resources to specific directories. This ensures proper organization and access to media files like images, videos, and music used in news articles.

```mermaid
flowchart TD

subgraph Spring_Boot_Configuration ["Spring Boot Configuration"]
end

subgraph File_System_Locations ["File System Locations"]
end

subgraph URL_Patterns ["URL Patterns"]
end

NI["/static/news-images/**"]
NV["/static/news-videos/**"]
NM["/static/news-music/**"]
IF["D:/uploads/NewsImg/"]
VF["D:/uploads/NewsVideo/"]
MF["D:/uploads/NewsMusic/"]
WC["WebConfig"]

    NI --> IF
    NV --> VF
    NM --> MF
    WC --> NI
    WC --> NV
    WC --> NM
```

Sources: images/2025-05-03-09-05-23-image.png

The configuration for static resources is managed in the WebConfig class, which extends `WebMvcConfigurer` to override resource handling methods.

## Article Management Flow

The flow of article creation, editing, and publishing is central to the SEU News system. This diagram maps the process to specific code entities.

```mermaid
flowchart TD

User["User/Author"]
NewArticle["New Article"]
ArticleController["ArticleController"]
ArticleService["ArticleService"]
ArticleRepository["ArticleRepository"]
Database["Database"]
ExistingArticle["Existing Article"]
ArticleInteraction["Article Interaction"]
InteractionController["LikeController/FavoriteController/CoinController"]
InteractionService["LikeService/FavoriteService/CoinService"]
InteractionRepo["LikeRepository/FavoriteRepository/CoinRepository"]

    User --> NewArticle
    NewArticle --> ArticleController
    ArticleController --> ArticleService
    ArticleService --> ArticleRepository
    ArticleRepository --> Database
    User --> ExistingArticle
    ExistingArticle --> ArticleController
    User --> ArticleInteraction
    ArticleInteraction --> InteractionController
    InteractionController --> InteractionService
    InteractionService --> InteractionRepo
    InteractionRepo --> Database
```

Sources: images/2025-05-03-09-05-23-image.png, images/2025-05-03-09-20-50-image.png

## User Authentication and Authorization

The authentication and authorization flow illustrates how users are authenticated and how permissions are managed.

```mermaid
sequenceDiagram
  participant User
  participant Frontend
  participant AuthController
  participant AuthService
  participant UserRepository
  participant JwtUtil

  User->Frontend: Enter credentials
  Frontend->AuthController: POST /api/auth/login
  AuthController->AuthService: authenticate(username, password)
  AuthService->UserRepository: findByUsername(username)
  UserRepository-->AuthService: User entity
  AuthService->JwtUtil: Verify password
  JwtUtil-->AuthService: generateToken(userDetails)
  AuthService-->AuthController: JWT token
  AuthController-->Frontend: Authentication result with token
  AuthService-->AuthController: 200 OK with JWT token
  AuthController-->Frontend: Store token in localStorage
  Frontend->User: Authentication exception
  Frontend->AuthController: 401 Unauthorized
  AuthController->JwtUtil: Show error message
  Note over Frontend,JwtUtil: For subsequent requests
  JwtUtil-->AuthController: Request with JWT in header
  AuthController-->Frontend: validateToken(token)
```

Sources: images/2025-05-03-09-20-50-image.png, images/2025-05-03-09-21-19-image.png

## Frontend Component Structure

This diagram maps the Vue3 frontend components to their responsibilities in the SEU News application, showing the hierarchy and relationships between components.

```mermaid
flowchart TD

subgraph Reusable_Components ["Reusable Components"]
end

subgraph Page_Components ["Page Components"]
end

subgraph Layout_Components ["Layout Components"]
end

subgraph App_Container ["App Container"]
end

App["App.vue - Main Application Container"]
Router["Vue Router - Route Management"]
Store["Vuex Store - State Management"]
Header["Header.vue - Navigation & User Info"]
Footer["Footer.vue - Site Information"]
Sidebar["Sidebar.vue - Navigation Categories"]
HomePage["HomePage.vue - Landing Page"]
ArticlePage["ArticlePage.vue - Article Display"]
EditorPage["EditorPage.vue - Article Editor"]
ProfilePage["ProfilePage.vue - User Profile"]
AdminPage["AdminPage.vue - Admin Dashboard"]
ArticleCard["ArticleCard.vue - Article Preview"]
CommentSection["CommentSection.vue - User Comments"]
LikeButton["LikeButton.vue - Like Functionality"]
FavoriteButton["FavoriteButton.vue - Favorite Functionality"]
CoinButton["CoinButton.vue - Coin Contribution"]
MediaUploader["MediaUploader.vue - Media Upload"]

    App --> Router
    App --> Store
    App --> Header
    App --> Footer
    App --> Sidebar
    Router --> HomePage
    Router --> ArticlePage
    Router --> EditorPage
    Router --> ProfilePage
    Router --> AdminPage
    HomePage --> ArticleCard
    ArticlePage --> CommentSection
    ArticlePage --> LikeButton
    ArticlePage --> FavoriteButton
    ArticlePage --> CoinButton
    EditorPage --> MediaUploader
    Store --> ArticleCard
    Store --> CommentSection
    Store --> LikeButton
    Store --> FavoriteButton
    Store --> CoinButton
```

Sources: images/2025-05-03-09-21-19-image.png, images/2025-05-03-09-27-24-image.png

## API Endpoints

The following table documents the main API endpoints in the SEU News system:

| Endpoint | Method | Description | Controller | Service Method |
| --- | --- | --- | --- | --- |
| `/api/article` | GET | Get all articles | ArticleController | findAll() |
| `/api/article/{id}` | GET | Get article by ID | ArticleController | findById() |
| `/api/article` | POST | Create a new article | ArticleController | insert() |
| `/api/article/{id}` | PUT | Update an existing article | ArticleController | update() |
| `/api/article/{id}` | DELETE | Delete an article | ArticleController | delete() |
| `/api/article/like/{id}` | POST | Like an article | ArticleLikeController | like() |
| `/api/article/favorite/{id}` | POST | Favorite an article | ArticleFavoriteController | favorite() |
| `/api/article/coin/{id}` | POST | Give coins to an article | ArticleCoinController | giveCoin() |
| `/api/user/register` | POST | Register a new user | UserController | register() |
| `/api/user/login` | POST | User login | UserController | login() |
| `/api/user/{id}` | GET | Get user information | UserController | findById() |
| `/api/category` | GET | Get all categories | CategoryController | findAll() |
| `/api/comment/{articleId}` | GET | Get comments for an article | CommentController | getByArticleId() |
| `/api/comment` | POST | Add a comment | CommentController | insert() |

Sources: images/2025-05-03-09-27-24-image.png, images/2025-05-03-10-00-35-image.png

## Data Transfer Objects (DTOs)

DTOs are used to transfer data between layers of the application. The following class diagram shows the key DTOs used in the article management system:

```mermaid
classDiagram
    class ArticleDTO {
        +Integer articleId
        +String title
        +String content
        +Date publishDate
        +Date updateDate
        +Integer authorId
        +String authorName
        +String status
        +Long likeNum
        +Long coinNum
        +Long favoriteNum
        +Long shareNum
        +List<CategoryDTO> categories
        +List<TagDTO> tags
        +List<MediaDTO> media
    }
    class ArticleInsertDTO {
        +String title
        +String content
        +Integer authorId
        +List<Integer> categoryIds
        +List<Integer> tagIds
        +List<MediaInsertDTO> media
    }
    class ArticleUpdateDTO {
        +Integer articleId
        +String title
        +String content
        +String status
        +List<Integer> categoryIds
        +List<Integer> tagIds
        +List<MediaInsertDTO> media
    }
    class ArticleFrontDTO {
        +Integer articleId
        +String title
        +String summary
        +String coverImage
        +Date publishDate
        +String authorName
        +Long likeNum
        +Long viewNum
        +List<String> categories
    }
    class UserDTO {
        +Integer userId
        +String userName
        +String email
        +Boolean isAuthor
        +String avatar
        +List<RoleDTO> roles
    }
    class CategoryDTO {
        +Integer categoryId
        +String categoryName
        +String description
    }
    class TagDTO {
        +Integer tagId
        +String tagName
    }
    class MediaDTO {
        +Integer mediaId
        +String mediaType
        +String url
        +String description
    }
    class MediaInsertDTO {
        +String mediaType
        +String url
        +String description
    }
    ArticleDTO --> CategoryDTO : contains
    ArticleDTO --> TagDTO : contains
    ArticleDTO --> MediaDTO : contains
    ArticleInsertDTO --> MediaInsertDTO : contains
    ArticleUpdateDTO --> MediaInsertDTO : contains
```

Sources: images/2025-05-03-09-27-24-image.png, images/2025-05-03-10-00-35-image.png

## Deployment Architecture

This diagram illustrates how the SEU News system is deployed in a production environment.

```mermaid
flowchart TD

subgraph Data_Layer ["Data Layer"]
end

subgraph Application_Layer ["Application Layer"]
end

subgraph Web_Layer ["Web Layer"]
end

NginxLB["Nginx Load Balancer"]
WebServer1["Web Server 1"]
WebServer2["Web Server 2"]
AppServer1["Spring Boot App Server 1"]
AppServer2["Spring Boot App Server 2"]
MySQL["MySQL Database"]
Redis["Redis Cache"]
FileStorage["File Storage Server"]
Client["Client Browsers"]

    NginxLB --> WebServer1
    NginxLB --> WebServer2
    WebServer1 --> AppServer1
    WebServer2 --> AppServer2
    AppServer1 --> MySQL
    AppServer2 --> MySQL
    AppServer1 --> Redis
    AppServer2 --> Redis
    AppServer1 --> FileStorage
    AppServer2 --> FileStorage
    Client --> NginxLB
```

Sources: images/2025-05-03-10-00-35-image.png, images/2025-05-03-10-02-45-image.png

## System Component Responsibilities

The following table summarizes the responsibilities of the major components in the SEU News system:

| Component | Description | Responsibilities |
| --- | --- | --- |
| Vue3 Frontend | Single-page application | - User interface rendering- Client-side state management- Form validation- User interaction handling |
| ArticleController | REST API controller | - Handle article-related HTTP requests- Validate input data- Transform between DTOs and service layer |
| ArticleService | Business logic service | - Apply business rules- Coordinate operations- Transform between DTOs and entities |
| ArticleRepository | Data access layer | - Perform CRUD operations on article entities- Execute database queries |
| UserController/Service | User management | - Handle authentication/authorization- User registration- Profile management |
| StaticResourceController | Media handling | - Handle uploads/downloads of images, videos, and music- Validate media files |
| WebConfig | Configuration | - Configure resource handling- Set up security- Define cors policy |

Sources: images/2025-05-03-09-05-23-image.png, images/2025-05-03-09-20-50-image.png, images/2025-05-03-09-21-19-image.png