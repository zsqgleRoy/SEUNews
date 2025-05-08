<template>
    <div class="comment-section" :class="{ mobile: isMobile }">
        <!-- 评论列表 -->
        <div class="comment-list" v-loading="isLoading">
            <div v-for="comment in comments" :key="comment.commentId" class="comment-item">
                <el-avatar 
                    :src="comment.avatar" 
                    class="avatar" 
                    @click="goToUserProfile(comment.userId)"
                />
                <div class="content">
                    <div class="header">
                        <span 
                            class="username" 
                            @click="goToUserProfile(comment.userId)"
                        >{{ comment.username }}</span>
                        <el-button
                            v-if="canDelete(comment.userId)"
                            type="danger"
                            size="small"
                            @click="handleDelete(comment.commentId)"
                            class="delete-btn"
                        >
                            删除
                        </el-button>
                    </div>
                    <div class="text">{{ comment.content }}</div>
                    <div class="date">{{ formatDate(comment.publishDate) }} &nbsp;&nbsp;-&nbsp;&nbsp; {{ comment.province }}</div>                    
                </div>
            </div>
            <div v-if="comments.length === 0" class="no-comments">
                <p>抢沙发</p>
            </div>
        </div>
        <!-- 评论输入区 -->
        <div class="comment-input" :class="{ fixed: isMobile }">
            <el-input
                v-model="newComment"
                type="textarea"
                :rows="isMobile ? 1 : 2"
                placeholder="留下您的见解..."
                maxlength="300"
            />
            <el-button 
                type="primary" 
                @click="submitComment"
                :disabled="!newComment.trim()"
                class="submit-btn"
            >
                发送
            </el-button>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { onActivated, onMounted, ref } from 'vue';
    import { CommentService } from '@/api/commentService';
    import type { Comment, CommentForm } from '@/types/comment';
    import { ElMessage } from 'element-plus';
    import userCache from '@/cache/userCache';
    import { getProvinceByIP } from '@/api/getIP';
    import { useRoute, useRouter } from 'vue-router';

    const props = defineProps<{
        articleId: number;
    }>();

    // 响应式数据
    const router = useRouter();
    const comments = ref<(Comment & { province?: string })[]>([]);
    const newComment = ref<string>('');
    const isLoading = ref(false);
    const isMobile = ref(window.innerWidth < 768);
    const route = useRoute();
    // 检查屏幕尺寸变化
    window.addEventListener('resize', () => {
        isMobile.value = window.innerWidth < 768;
    });

    // 格式化时间
    const formatDate = (date: Date) => {
        const now = new Date();
        const diffMs = now.getTime() - date.getTime(); // 时间差（毫秒）
        const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24)); // 相差天数（向下取整）
        const diffHours = Math.floor(diffMs / (1000 * 60 * 60)); // 相差小时数

        // 格式化时间部分（HH:mm）
        const timeStr = date.toLocaleTimeString('zh-CN', {
            hour: '2-digit',
            minute: '2-digit'
        });

        if (diffDays === 0) {
            // 今天（24小时内）
            return `${timeStr}`;
        } else if (diffDays === 1) {
            // 昨天（24-48小时内）
            return `昨天 ${timeStr}`;
        } else if (diffDays > 1 && diffDays <= 7) {
            return `${diffDays}天前`;
        } else {
            // 超过7天，显示完整日期（避免“30天前”等过长显示）
            return date.toLocaleDateString('zh-CN', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit'
            });
        }
    };


    // 加载评论
    const loadComments = async () => {
        try {
            isLoading.value = true;
            const fetchedComments = await CommentService.getComments(props.articleId);
            const commentsWithProvince = await Promise.all(
                fetchedComments.map(async (comment) => {
                    if (comment.ip) {
                        const province = await getProvinceByIP(comment.ip);
                        return { ...comment, province };
                    }
                    return { ...comment, province: '未知地点' };
                })
            );
            comments.value = commentsWithProvince;
        } catch (error) {
            ElMessage.error('加载评论失败');
        } finally {
            isLoading.value = false;
        }
    };

    // 提交评论
    const submitComment = async () => {
        if (!newComment.value.trim()) return;
        else if (userCache.getUserCache()?.user_id === undefined) {
            ElMessage.warning('请先登录');
            return;
        }
        try {
            const form: CommentForm = {
                articleId: props.articleId,
                content: newComment.value,
            };

            const created = await CommentService.createComment(form);
            comments.value.unshift({
                ...created,
                avatar: userCache.getUserCache()?.avatar || '/default-avatar.png',
                username: userCache.getUserCache()?.username || '匿名用户'
            });
            newComment.value = '';
            ElMessage.success('评论成功');
        } catch (error) {
            ElMessage.error('评论失败');
        }
    };

    // 删除评论
    const handleDelete = async (commentId: number) => {
        try {
            await CommentService.deleteComment(commentId);
            comments.value = comments.value.filter(c => c.commentId !== commentId);
            ElMessage.success('删除成功');
        } catch (error) {
            ElMessage.error('删除失败');
        }
    };

    // 权限检查
    const canDelete = (userId: number) => {
        return userId === userCache.getUserCache()?.user_id;
    };

    // 点击头像/昵称跳转用户主页，这里先预留函数
    const goToUserProfile = (userId: number) => {
        router.push(`/userInfo/${userId}`)
    };

    onMounted(()=>{
        loadComments();
    })

    onActivated(()=>{   
        loadComments();
    })
</script>

<style scoped lang="scss">
.comment-section {
    max-width: 800px;
    margin: 0 auto;
    position: relative;

    &.mobile {
        padding: 0 10px;
    }
}

.comment-input {
    display: flex;
    gap: 15px;
    align-items: center;

    :deep(.el-textarea__inner) {
        border-radius: 8px;
        padding: 12px;
    }

    &.fixed {
        position: fixed;
        bottom: 0;
        left: 0;
        right: 0;
        background-color: white;
        padding: 10px;
        box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
    }
}

.comment-list {
    .comment-item {
        display: flex;
        gap: 15px;
        padding: 15px 0;
        border-bottom: 1px solid #eee;

        .avatar {
            flex-shrink: 0;
            width: 44px;
            height: 44px;
            cursor: pointer;
        }

        .content {
            flex-grow: 1;

            .header {
                display: flex;
                align-items: center;
                height: 15px;
                gap: 5px;

                .username {
                    font-size: 10px;
                    color: var(--el-color-primary);
                    margin-bottom: 4px;
                    cursor: pointer;
                }

                .province {
                    font-size: 12px;
                    color: #666;
                    margin-left: 8px;
                }

                .delete-btn {
                    margin-left: auto;
                }
            }

            .text {
                font-size: 15px;
                font-weight: 600;
                font-family: '楷体_gb2312';
            }

            .date {
                color: #999;
                font-size: 0.6rem;
                margin-top: 4px;
            }
        }
    }
}
.no-comments{
    text-align: center;
    font-size: 1.2rem;
    color: #999;
    margin: 20px;
}
</style>    