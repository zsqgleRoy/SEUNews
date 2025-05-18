<template>
    <div class="top-menu" v-if="isMobile">
        <BackButton/>
        <h1>用户管理</h1>
    </div>
  <div class="user-management">
    <!-- 在操作栏添加状态筛选 -->
    <div class="operation-bar">
      <el-input
        v-model="searchKeyword"
        placeholder="搜索用户名或邮箱"
        style="width: 300px; margin-right: 10px"
        @keyup.enter="handleSearch"
      />
      <el-select
        v-model="filterStatus"
        placeholder="用户状态"
        style="width: 120px; margin-right: 10px"
      >
        <el-option label="全部" value="all" />
        <el-option label="正常" value="0" />
        <el-option label="已删除" value="1" />
      </el-select>
      <el-button type="primary" @click="handleSearch">搜索</el-button>
      <el-button type="success" @click="handleCreate">添加用户</el-button>
    </div>

    <!-- 用户表格添加状态列 -->
    <el-table :data="filteredUsers" border style="width: 100%" v-loading="loading">
      <el-table-column prop="user_id" label="ID" width="80" />
      <el-table-column prop="username" label="用户名" width="150" />
      <el-table-column prop="email" label="邮箱" width="200" />
      <el-table-column prop="phone" label="电话" width="150" />
      <el-table-column prop="name" label="姓名" width="120" />
      <el-table-column prop="isAuthor" label="作者状态" width="100">
        <template #default="{ row }">
          {{ isAuthorMap[row.isAuthor] }}
        </template>
      </el-table-column>
      <el-table-column prop="isDeleted" label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.isDeleted ? 'danger' : 'success'">
            {{ row.isDeleted ? '已删除' : '正常' }}
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column label="操作" fixed="right" width="135">
        <template #default="{ row }">
          <el-button size="small" @click="handleEdit(row)" v-if="row.user_id !== 2">
            编辑
          </el-button>
          <el-button
            v-if="row.user_id !== 2"
            size="small"
            :type="row.isDeleted ? 'success' : 'danger'"
            @click="toggleUserStatus(row)"
          >
            {{ row.isDeleted ? '恢复' : '删除' }}
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 添加/编辑对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="isEdit ? '编辑用户' : '添加用户'"
      width="600px"
    >
      <el-form
        ref="formRef"
        :model="formData"
        :rules="formRules"
        label-width="100px"
      >
        <el-form-item label="用户名" prop="username">
          <el-input v-model="formData.username" />
        </el-form-item>
        <el-form-item label="密码" prop="password" v-if="!isEdit">
          <el-input v-model="formData.password" type="password" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="formData.email" />
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="formData.phone" />
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="formData.name" />
        </el-form-item>
        <el-form-item label="生日" prop="birthday">
          <el-date-picker
            v-model="formData.birthday"
            type="date"
            value-format="YYYY-MM-DD"
          />
        </el-form-item>
        <el-form-item label="作者状态" prop="isAuthor">
          <el-select v-model="formData.isAuthor">
            <el-option
              v-for="item in isAuthorOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitForm">确认</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'
import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'
import BackButton from '@/components/common/BackButton.vue';
import { initialURL } from '@/lib/urls'

interface User {
  user_id: number
  username: string
  password?: string
  email: string
  phone: string
  name: string
  birthday: string
  isAuthor: string
  registerDate: string
  avatar?: string
  isDeleted: number
}
const isMobile = ref(window.innerWidth < 768);
// 状态管理
const userList = ref<User[]>([])
const loading = ref(false)
const searchKeyword = ref('')
const dialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref<FormInstance>()
// 添加状态筛选
const filterStatus = ref('all')
// 表单数据
const formData = reactive<User>({
  user_id: 0,
  username: '',
  password: '',
  email: '',
  phone: '',
  name: '',
  birthday: '',
  isAuthor: 'NO',
  registerDate: '',
  isDeleted: 0
})

// 表单验证规则
const formRules = reactive<FormRules<User>>({
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '长度在3到20个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '长度在6到20个字符', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
  ],
  phone: [
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
  ]
})

// 计算属性处理筛选逻辑
const filteredUsers = computed(() => {
  return userList.value.filter(user => {
    const matchesSearch = !searchKeyword.value || 
      user.username.includes(searchKeyword.value) ||
      user.email.includes(searchKeyword.value)
    
    const matchesStatus = filterStatus.value === 'all' || 
      user.isDeleted.toString() === filterStatus.value
      
    return matchesSearch && matchesStatus
  })
})

// 作者状态选项
const isAuthorOptions = [
  { value: 'TRUE', label: '是' },
  { value: 'FALSE', label: '否' }
]

const isAuthorMap: Record<string, string> = {
  TRUE: '是',
  FALSE: '否'
}

// 修改后的状态切换方法
const toggleUserStatus = async (user: User) => {
  try {
    const action = user.isDeleted ? '恢复' : '删除'
    await ElMessageBox.confirm(`确认${action}该用户？`, '提示', {
      confirmButtonText: '确认',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    // 调用修改后的API接口，假设后端接口改为接收PATCH请求
    const { data } = await axios.delete(
      `${initialURL.SERVER_URL}/api/user/${user.user_id}`
    )
    ElMessage.success(`${action}成功`)
    const index = userList.value.findIndex(u => u.user_id === user.user_id)
    if (index !== -1) {
      userList.value[index].isDeleted = userList.value[index].isDeleted==1?0:1;
    }
  } catch (error) {
    if (!(error as Error).toString().includes('cancel')) {
      ElMessage.error('取消操作')
    }
  }
}

// 获取用户列表
const fetchUsers = async () => {
  try {
    loading.value = true
    const { data } = await axios.get<User[]>(`${initialURL.SERVER_URL}/api/user`)
    userList.value = data
  } catch (error) {
    ElMessage.error('获取用户列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索用户
const handleSearch = async () => {
  if (!searchKeyword.value) return fetchUsers()
  try {
    loading.value = true
    const { data } = await axios.get<User>(
      `${initialURL.SERVER_URL}/api/user/username/${searchKeyword.value}`
    )
    userList.value = data ? [data] : []
  } catch (error) {
    ElMessage.error('搜索用户失败')
  } finally {
    loading.value = false
  }
}

// 初始化表单
const resetForm = () => {
  formData.user_id = 0
  formData.username = ''
  formData.password = ''
  formData.email = ''
  formData.phone = ''
  formData.name = ''
  formData.birthday = ''
  formData.isAuthor = 'FALSE'
}

// 打开创建对话框
const handleCreate = () => {
  resetForm()
  isEdit.value = false
  dialogVisible.value = true
}

// 打开编辑对话框
const handleEdit = (user: User) => {
  Object.assign(formData, user)
  isEdit.value = true
  dialogVisible.value = true
}

// 提交表单
const submitForm = async () => {
  if (!formRef.value) return
  try {
    await formRef.value.validate()
    
    if (isEdit.value) {
      await axios.put(`${initialURL.SERVER_URL}/api/user/${formData.user_id}`, formData)
      ElMessage.success('更新成功')
    } else {
      await axios.post(`${initialURL.SERVER_URL}/api/user`, formData)
      ElMessage.success('创建成功')
    }
    
    dialogVisible.value = false
    await fetchUsers()
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

// 初始化
onMounted(() => {
  fetchUsers()
})
</script>

<style scoped>
.user-management {
  padding: 20px;
}

.operation-bar {
  margin-bottom: 20px;
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
</style>