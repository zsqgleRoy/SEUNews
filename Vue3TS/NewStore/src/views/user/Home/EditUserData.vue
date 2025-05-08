<template>
    <div class="user-profile-container">
        <div class="top-menu" v-if="isMobile">
            <BackButton/>
            <h1>修改资料</h1>
            <el-button link :type="'success'" class="top-save" @click="saveData">保存</el-button>
        </div>
      <!-- 渐变背景层 -->
      <div class="profile-gradient">

      </div>
  
      <!-- 头像区域 -->
      <div class="avatar-section">
        <div class="avatar-wrapper">
            <ImageUpload @imgData="getImageData" :width="isMobile? 100: 150" :height="isMobile? 100: 150" :title="'更换头像'" :url="userInfo.avatar" ></ImageUpload>
        </div>
      </div>
  
      <!-- 主要内容 -->
      <div class="profile-content">
        
        <el-button class="saveNtn" color="#626aef" @click="saveData" v-if="!isMobile">保存</el-button>
        <!-- 用户信息卡片 -->
        <div class="info-card">
            <el-row :gutter="20" class="form-row">
                <el-col :span="150">
                    <div class="input-group">
                        <label class="label">
                            <span >账&nbsp;&nbsp;号: </span>
                        </label>
                        <el-input v-model="userInfo.email" placeholder="邮箱" disabled ></el-input>
                    </div>
                </el-col>
                <el-col :span="150">
                    <div class="input-group">
                        <label class="label">
                            <span>昵&nbsp;&nbsp;称: </span>
                        </label>
                        <el-input 
                            v-model="userInfo.username" 
                            placeholder="昵称"
                            clearable
                            @input="handleUsernameInput"
                            :class="{ 'is-valid': usernameStatus === 'valid', 'is-invalid': usernameStatus === 'invalid' }"
                        >
                        <template #suffix>
                            <div v-if="usernameStatus === 'checking'" class="loading-icon">
                                <i class="el-icon-loading" ></i>
                            </div>
                            <i 
                                v-else-if="usernameStatus === 'valid'" 
                                class="el-icon-success valid-icon" 
                            ></i>
                            <i 
                                v-else-if="usernameStatus === 'invalid'" 
                                class="el-icon-error invalid-icon" 
                            ></i>
                        </template>
                        </el-input>
                        <div v-if="usernameStatus === 'invalid'" class="error-msg">
                        该昵称已被占用
                        </div>
                    </div>
                </el-col>
                <el-col :span="150">
                    <div class="input-group">
                        <label class="label">
                            <span >姓&nbsp;&nbsp;名: </span>
                        </label>
                        <el-input v-model="userInfo.name" 
                        placeholder="姓名"
                        clearable
                        ></el-input>
                    </div>
                </el-col>
                <el-col :span="150">
                    <div class="input-group">
                        <label class="label">
                            <span >手机号: </span>
                        </label>
                        <el-input v-model="userInfo.phone" 
                        placeholder="手机号"
                        clearable
                        ></el-input>
                    </div>
                </el-col>
                <el-col :span="150">

                <div class="input-group">
                    <label class="label">
                        <span >生&nbsp;&nbsp;日: </span>
                    </label>
                    <el-date-picker
                        v-model="userInfo.birthday"
                        type="date"
                        placeholder="Pick one or more dates"
                        />
                </div>
                </el-col>
            </el-row>
        </div>
  
        <!-- 编辑表单卡片 -->
        <div class="form-card">
            <el-row :gutter="20" class="form-row">
                <el-col :span="150">
                    <div class="input-group">
                        <label class="label">
                            <span >点&nbsp;&nbsp;赞</span>
                        </label>
                        <el-switch
                            v-model="likeValue"
                            :active-action-icon="View"
                            :inactive-action-icon="Hide"
                        />
                    </div>
                </el-col>
                <el-col :span="150">
                    <div class="input-group">
                        <label class="label">
                            <span >收&nbsp;&nbsp;藏</span>
                        </label>
                        <el-switch
                            v-model="likeValue"
                            :active-action-icon="View"
                            :inactive-action-icon="Hide"
                        />
                    </div>
                </el-col>
                <el-col :span="150">
                    <div class="input-group">
                        <label class="label">
                            <span>评&nbsp;&nbsp;论</span>
                        </label>
                        <el-switch
                            v-model="likeValue"
                            :active-action-icon="View"
                            :inactive-action-icon="Hide"
                        />
                    </div>
                </el-col>
                <el-col :span="150">
                    <div class="input-group">
                        <label class="label">
                            <span>转&nbsp;&nbsp;发</span>
                        </label>
                        <el-switch
                            v-model="likeValue"
                            :active-action-icon="View"
                            :inactive-action-icon="Hide"
                        />
                    </div>
                </el-col>
                <el-col :span="150">
                    <div class="input-group">
                        <label class="label">
                            <span >投&nbsp;&nbsp;币</span>
                        </label>
                        <el-switch
                                v-model="likeValue"
                                :active-action-icon="View"
                                :inactive-action-icon="Hide"
                            />
                    </div>
                </el-col>
            </el-row>
        </div>
      </div>
    </div>
</template>
  
<script setup lang="ts">

import BackButton from '@/components/common/BackButton.vue';
import { Hide, View } from '@element-plus/icons-vue'
import { onMounted, ref, reactive, watch, onBeforeUnmount } from 'vue';
import ImageUpload from '@/components/common/user/avatar/ImageUpload.vue';
import userCache, { type UserInfo } from '@/cache/userCache';
import { debounce } from 'lodash-es'
import axios from 'axios'
import { initialURL } from '@/lib/urls';
import { ElMessage } from 'element-plus';
const isMobile = ref(window.innerWidth < 768);
const userInfo = ref<UserInfo>({
    user_id: 0,
    username: '',
    registerDate: new Date(),
    avatar: '',
    name: '',
    email: '',
    isAuthor: "aaa", 
    expires: 0 
});
Object.assign(userInfo.value, userCache.getUserCache());
const completed = ref(true);  //完整性标注
type UsernameStatus = 'init' | 'checking' | 'valid' | 'invalid';
const usernameStatus = ref<UsernameStatus>('init')
let abortController: AbortController | null = null
const user_name_value = ref('');
const birthValue = ref('')
const likeValue = ref();
onMounted(()=>{
    user_name_value.value = userInfo.value.username;
    // console.log(userInfo.value);
})
const saveData = async () => {
    if(userInfo.value.username.length <= 2){
        completed.value = false;
        ElMessage.warning("昵称不能少于2个字");
        return
    } else if(!completed.value){
        ElMessage.warning("资料不完整");
        return
    } else {
        try{
            const { data } = await axios.put<UserInfo>(
            `${initialURL.SERVER_URL}/api/user/${userInfo.value.user_id}`,
            userInfo.value
            )
            userCache.updateUserCache(data)
            ElMessage.success("保存成功");
        } catch (error) {
            ElMessage.error("保存失败");
        }
    }
}


const emit = defineEmits(['imgData'])
const getImageData = (data:{ url: string }) => {
  userInfo.value.avatar = data.url
  emit('imgData', userInfo.value.avatar)
}

const checkUsername = async (username: string) => {
  if (abortController) {
    abortController.abort()
  }

  abortController = new AbortController()
  
  try {
    if (username.trim() == user_name_value.value) {
      usernameStatus.value = 'init'
      completed.value = true;
      return
    }

    usernameStatus.value = 'checking'

    const { data } = await axios.get<boolean>(
      `${initialURL.SERVER_URL}/api/user/setusername/${encodeURIComponent(username)}`,
      {
        signal: abortController.signal
      }
    )

    usernameStatus.value = data ? 'invalid' : 'valid'
    if(usernameStatus.value === 'invalid'){
        completed.value = false;
        ElMessage.warning('昵称已被占用');
    } else completed.value = true;
  } catch (error) {
    if (!axios.isCancel(error)) {
      console.error('检查用户名出错:', error)
      usernameStatus.value = 'init'
    }
  } finally {
    abortController = null
  }
}

// 使用 lodash 的防抖函数（300ms）
const debouncedCheck = debounce(checkUsername, 300)

const handleUsernameInput = (value: string) => {
  if (value.length >= 2) { // 至少2个字符才触发检查
    debouncedCheck(value)
  } else {
    usernameStatus.value = 'init'
    debouncedCheck.cancel()
  }
}

// 在组件卸载时取消所有请求
onBeforeUnmount(() => {
  if (abortController) {
    abortController.abort()
  }
  debouncedCheck.cancel()
})
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
        user-select: none;
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
            top: 55px;
            height: 20vh;
            margin-top: 0;
        }
    }
    .top-save{
        position: absolute;
        left: 85%;
        z-index: 9999;
    }
    .saveNtn{
        margin: -50px 20px 40px;
        display: block;
        float: right;
    }
    .avatar-section {
        position: relative;
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
        margin: 0 auto;

        @media screen and (max-width: 640px) {
            width: 100vw;
            padding: 0;
            max-width: 100vw;
            radius: 0;
            background-color: white;
            
        }
    }

    .top-menu {
        display: flex;
        align-items: center;
        background: rgba(255, 255, 255, 0.95);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.3);
        backdrop-filter: blur(10px);
        padding: 10px;
    }

    .top-menu h1 {
        margin: 0 auto;
        color: transparent;
        background: linear-gradient(135deg, #0055ff, #6b00bc);
        -webkit-background-clip: text;
        background-clip: text;
        border-image: linear-gradient(135deg, #0055ff, #6b00bc) 1;
        text-transform: uppercase;
        font-size: 18px;
    }

    .info-card, .form-card {
        clear: both;
        background: white;
        border-radius: 1.5rem;
        padding: 3rem;
        margin-bottom: 1.5rem;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        @media screen and (max-width: 640px) {
            padding: 0.5rem 1.5rem;
            margin-bottom: 0.5rem;
            box-shadow: none;
            border-radius: 0;
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
    .loading-icon {
        color: #409eff;
        animation: rotating 2s linear infinite;
    }

    .valid-icon {
    color: #67c23a;
    }

    .invalid-icon {
    color: #f56c6c;
    }

    .error-msg {
        display: flex;
        align-items: center;
        color: #f56c6c;
        font-size: 12px;
        line-height: 1;
        padding-top: 4px;
    }

    @keyframes rotating {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
    }
</style>