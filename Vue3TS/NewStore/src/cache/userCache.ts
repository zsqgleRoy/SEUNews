// src/cache/userCache.ts

export interface UserInfo {
  user_id: number;
  username: string;
  email: string;
  registerDate: Date;
  avatar: string;
  isAuthor: string;
  expires: number;
}

const USER_KEY = 'user_info';

// 初始化缓存
const loadUserCache = () => {
  try {
    const cachedData = localStorage.getItem(USER_KEY);
    if (cachedData) {
      const parsedData = JSON.parse(cachedData);
      // 处理旧缓存数据兼容性
      if (!parsedData.expires) {
        return null;
      }
      return {
        ...parsedData,
        registerDate: new Date(parsedData.registerDate),
        expires: parsedData.expires
      } as UserInfo;
    }
  } catch (error) {
    console.error('用户缓存加载失败:', error);
    localStorage.removeItem(USER_KEY);
  }
  return null;
};

// 保存用户缓存
const saveUserCache = (user: UserInfo) => {
  try {
    localStorage.setItem(USER_KEY, JSON.stringify(user));
  } catch (error) {
    console.error('用户缓存保存失败:', error);
  }
};

// 获取用户缓存（自动检查有效性）
export const getUserCache = () => {
  const cachedData = localStorage.getItem(USER_KEY);
  if (!cachedData) return null;
  
  try {
    const parsedData = JSON.parse(cachedData);
    const user: UserInfo = {
      ...parsedData,
      registerDate: new Date(parsedData.registerDate),
      expires: parsedData.expires
    };
    // 检查缓存是否过期
    if (Date.now() > user.expires) {
      console.log('用户缓存已过期');
      clearUserCache();
      return null;
    }
    return user;
  } catch (error) {
    console.error('用户缓存解析失败:', error);
    localStorage.removeItem(USER_KEY);
    return null;
  }
};

// 更新用户缓存
const updateUserCache = (updates: Partial<UserInfo>) => {
  const currentUser = getUserCache();
  if (currentUser) {
    saveUserCache({ 
      ...currentUser, 
      ...updates,
      expires: Date.now() + 24 * 60 * 60 * 1000 // 每次更新延长有效期
    });
  }
};

// 清除用户缓存
const clearUserCache = () => {
  localStorage.removeItem(USER_KEY);
};

export default {
  loadUserCache,
  saveUserCache,
  getUserCache,
  updateUserCache,
  clearUserCache
};