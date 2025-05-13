后端数据接口路径列表
用户相关接口 (UserController)
获取所有用户:
路径: /api/user (GET)
接受: 无参数
返回: List<UserDTO> UserController.java:26-35
根据ID获取用户:
路径: /api/user/{id} (GET)
接受: 路径参数 id (Integer)
返回: UserDTO UserController.java:37-49
创建用户:
路径: /api/user (POST)
接受: UserDTO (包含用户名、密码、邮箱等信息)
返回: UserDTO UserController.java:51-60
更新用户:
路径: /api/user/{id} (PUT)
接受: 路径参数 id (Integer) 和 UserDTO (JSON)
返回: UserDTO UserController.java:62-74
删除用户:
路径: /api/user/{id} (DELETE)
接受: 路径参数 id (Integer)
返回: 无内容 UserController.java:76-85
根据用户名查找用户:
路径: /api/user/username/{username} (GET)
接受: 路径参数 username (String)
返回: UserBaseInfoDTO UserController.java:87-96
用户登录:
路径: /api/user/login (POST)
接受: UserDTO (包含 username 和 password)
返回: 成功时返回 UserBaseInfoDTO，失败时返回错误信息 UserController.java:99-113
用户注册:
路径: /api/user/register (POST)
接受: UserDTO (包含用户信息)
返回: 成功时返回 UserBaseInfoDTO，失败时返回错误信息 UserController.java:114-131
文章相关接口 (ArticleController)
获取所有文章:
路径: /api/articles (GET)
接受: 无参数
返回: List<ArticleDTO> ArticleController.java:38-42
根据ID获取文章:
路径: /api/articles/{id} (GET)
接受: 路径参数 id (Integer)
返回: ArticleDTO ArticleController.java:49-67
创建文章:
路径: /api/articles (POST)
接受: ArticleDTO (包含文章标题、内容等信息)
返回: ArticleDTO ArticleController.java:74-78
更新文章:
路径: /api/articles/{id} (PUT)
接受: 路径参数 id (Integer) 和 ArticleUpdateDTO (JSON)
返回: Boolean ArticleController.java:86-89
删除文章:
路径: /api/articles/{id} (DELETE)
接受: 路径参数 id (Integer)
返回: 无内容 ArticleController.java:96-100
根据状态获取文章列表:
路径: /api/articles/all (GET)
接受: 查询参数 status (Article.ArticleStatus) 和分页信息
返回: Page<ArticleDTO> ArticleController.java:108-115
分页获取文章列表:
路径: /api/articles/list (GET)
接受: 查询参数 page (int), pageSize (int), status (Article.ArticleStatus)
返回: Page<ArticleDTO> ArticleController.java:124-133
搜索文章:
路径: /api/articles/search (GET)
接受: 查询参数 keyword, tag, subTag, page, pageSize, status
返回: Page<?> ArticleController.java:145-160
发布文章:
路径: /api/articles/publish (POST)
接受: ArticleInsertDTO (文章信息)
返回: 成功时返回 "OK" 字符串，失败时返回错误信息 ArticleController.java:167-180
更新文章:
路径: /api/articles/update{id} (PUT)
接受: 路径参数 id (int) 和 ArticleUpdateDTO (JSON)
返回: 成功时返回成功信息，失败时返回错误信息 ArticleController.java:186-198
评论相关接口 (CommentController)
获取文章评论:
路径: /comments/article/{articleId} (GET)
接受: 路径参数 articleId (Integer)
返回: List<CommentDTO> CommentController.java:19-23
创建评论:
路径: /comments (POST)
接受: CommentDTO (包含文章ID、用户ID、评论内容等)
返回: CommentDTO CommentController.java:25-29
删除评论:
路径: /comments/{commentId} (DELETE)
接受: 路径参数 commentId (Integer)
返回: 无内容 CommentController.java:31-35
文章点赞相关接口 (ArticleLikeController)
获取文章的所有点赞:
路径: /api/article-likes/article/{articleId} (GET)
接受: 路径参数 articleId (Integer)
返回: List<ArticleLikeDTO> ArticleLikeController.java:19-23
根据ID获取点赞:
路径: /api/article-likes/{likeId} (GET)
接受: 路径参数 likeId (Integer)
返回: ArticleLikeDTO ArticleLikeController.java:25-32
创建点赞:
路径: /api/article-likes (POST)
接受: ArticleLikeDTO (包含用户ID和文章ID)
返回: ArticleLikeDTO ArticleLikeController.java:34-38
删除点赞:
路径: /api/article-likes/{likeId} (DELETE)
接受: 路径参数 likeId (Integer)
返回: 无内容 ArticleLikeController.java:40-44
检查用户是否点赞文章:
路径: /api/article-likes/user/{userId}/article/{articleId} (GET)
接受: 路径参数 userId (Integer) 和 articleId (Integer)
返回: Boolean ArticleLikeController.java:46-50
AI相关接口 (AIController)
AI问答:
路径: /api/ask (GET)
接受: 查询参数 msg (String), sessionId (String), user_id (Integer)
返回: String (AI回复) AIController.java:31-47
获取聊天历史:
路径: /api/history (GET)
接受: 查询参数 user_id (Integer)
返回: List<ChatRecord> AIController.java:59-72
文件上传接口 (FileUploadController)
上传图片:
路径: /upload (POST)
接受: MultipartFile 命名为 "image" 的文件
返回: ImageResponse (包含 url 字段) FileUploadController.java:24-51
数据类型说明
UserDTO: 包含用户ID、用户名、密码、邮箱、注册日期、头像等信息 UserDTO.java:11-18

UserBaseInfoDTO: 不包含密码的用户基本信息 UserBaseInfoDTO.java:11-17

ArticleDTO: 包含文章ID、标题、内容、发布日期、作者等信息 ArticleDTO.java:14-29

ArticleInsertDTO: 用于文章创建的数据类型 ArticleInsertDTO.java:12-21

CommentDTO: 包含评论ID、文章ID、用户ID、内容和发布日期 CommentDTO.java:6-12

ArticleLikeDTO: 包含点赞ID、用户ID、文章ID和点赞日期 ArticleLikeDTO.java:5-9

Notes
所有接口路径均为相对路径，需要在实际使用时加上后端服务器基础URL
大部分接口使用标准的RESTful设计风格，使用HTTP方法（GET、POST、PUT、DELETE）来表示不同操作
数据交互主要使用JSON格式，但文件上传使用multipart/form-data格式
接口返回的状态码遵循HTTP标准：200(成功)、201(创建成功)、204(删除成功)、400(请求错误)、404(资源不存在)、500(服务器错误)