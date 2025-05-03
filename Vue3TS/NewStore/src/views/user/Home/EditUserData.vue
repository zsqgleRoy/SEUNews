<template>
    <div class="user-profile-container">
      <!-- 渐变背景层 -->
      <div class="profile-gradient">

      </div>
  
      <!-- 头像区域 -->
      <div class="avatar-section">
        <div class="avatar-wrapper">
            <ImageUpload :width="150" :height="150" :title="'更换头像'"></ImageUpload>
        </div>
      </div>
  
      <!-- 主要内容 -->
      <div class="profile-content">
        <!-- 用户信息卡片 -->
        <div class="info-card">
            <el-row :gutter="20" class="form-row">
                <el-col :span="150">
                    <div class="input-group">
                        <el-label class="label">
                            <span >昵称: </span>
                        </el-label>
                        <el-input v-model="userInfo.name" placeholder="昵称"></el-input>
                    </div>
                </el-col>
                <el-col :span="150">

                    <div class="input-group">
                        <el-label class="label">
                            <span >邮箱: </span>
                        </el-label>
                        <el-input v-model="userInfo.email" placeholder="邮箱"></el-input>
                    </div>
                </el-col>
                <el-col :span="150">
                    <div class="input-group">
                        <el-label class="label">
                            <span >手机号: </span>
                        </el-label>
                        <el-input v-model="userInfo.phone" placeholder="手机号"></el-input>
                    </div>
                </el-col>
                <el-col :span="150">

                <div class="input-group">
                    <el-label class="label">
                        <span >生日: </span>
                    </el-label>
                    <el-input v-model="userInfo.phone" placeholder="手机号"></el-input>
                </div>
                </el-col>
            </el-row>
        </div>
  
        <!-- 编辑表单卡片 -->
        <div class="form-card">
          <!-- 表单内容 -->
        </div>
      </div>
    </div>
</template>
  
<script setup lang="ts">
import ImageUpload from '@/components/common/user/avatar/ImageUpload.vue';
import { el } from 'element-plus/es/locale/index.mjs';
const props = defineProps({
    userInfo: {
        type: Object,
        default: () => ({
            avatar: '',
            name: '',
            email: '',
            phone: '',
        })
    },
    userLevel: {
        type: Number,
        default: 0
    }
});

</script>

<style scoped lang="scss">
    .label {
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 1.5rem;
        font-weight: bold;
        color: #333;
        font-family: "楷体_GB2312";
        min-width: 80px;
        margin-right: 5px;
        @media screen and (max-width: 640px) {
            font-size: 1.1rem;
            min-width: 60px;
            justify-content: start;
            margin-right: 6px;
            align-items: center;
        }
    }
    .user-profile-container {
        position: relative;
        height: 100vh;
        padding: 2rem 1rem;
        background: #f8f9fa;

        @media screen and (max-width: 640px) {
            padding: 0;
            background-color: white;
            margin: 0;
        }
    }

    .profile-gradient {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 30vh;
        background: linear-gradient(135deg, #6366f1 0%, #a855f7 50%, #ec4899 100%);
        @media screen and (max-width: 640px) {
            height: 20vh;
            margin-top: 0;
        }
    }

    .avatar-section {
        position: relative;
        z-index: 999;
        margin-top: 10.5vh;
        text-align: center;

        @media screen and (max-width: 640px) {
            padding-top: 12.3vh;
            margin-top: 0;
            text-align: center;
        }

        .avatar-wrapper {
            display: inline-block;
            position: relative;
            width: auto;
            height: 40%;
            overflow: hidden; // 防止内容溢出
            box-sizing: content-box; // 确保边框不计算在尺寸内

            border: 4px solid white;
            border-radius: 50%;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;

            @media screen and (max-width: 640px) {
                width: 100px;
                height: 100px;
                border-width: 3px;
            }
        }

        .avatar-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center center;
        }

        .avatar-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            margin: -4px;
            @media screen and (max-width: 640px) {
                margin: -3px;
            }
        }
    }

    .profile-content {
        position: relative;
        z-index: 10;
        max-width: 90vw;
        margin: 2rem auto;

        @media screen and (max-width: 640px) {
            width: 100vw;
            padding: 0;
            max-width: 100vw;
            radius: 0;
            background-color: white;
            
        }
    }

    .info-card, .form-card {
        background: white;
        border-radius: 1.5rem;
        padding: 3rem;
        margin-bottom: 1.5rem;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        @media screen and (max-width: 640px) {
            padding: 1rem;
            margin-bottom: 0.5rem;
            box-shadow: none;
            border-radius: 0;
            padding: 0.5rem;
        }
    }

    .form-row {
        display: grid;
        gap: 1rem;
        grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
        @media screen and (max-width: 640px) {
            grid-template-columns: repeat(auto-fit, minmax(50vw, 1fr));
            gap: 1.5rem;
        }
    }

    .input-group {
        display: flex;
        gap: 0.5rem;
        
        :deep(.el-input) {
            flex: 1;
        }
        
        .el-button {
            flex-shrink: 0;
        }
    }

    .progress-bar {
        height: 0.75rem;
        border-radius: 9999px;
        background-color: #e5e7eb;
        overflow: hidden;
        
        &-fill {
            height: 100%;
            background: linear-gradient(to right, #8b5cf6, #ec4899);
            transition: width 0.5s ease;
        }
    }

    .form-actions {
        display: flex;
        gap: 0.75rem;
        justify-content: flex-end;
        margin-top: 1.5rem;
        
        .el-button {
            padding-left: 1.5rem;
            padding-right: 1.5rem;
            border-radius: 9999px;
            transition: all 0.2s ease;
            
            &:hover {
            transform: translateY(-1px);
            }
        }
    }

    .level-badge {
        display: inline-flex;
        align-items: center;
        padding: 0.5rem 1rem;
        border-radius: 9999px;
        background: linear-gradient(to right, #3b82f6, #8b5cf6);
        color: white;
    }
</style>