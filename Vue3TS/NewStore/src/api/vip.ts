import axios from 'axios';
import type { VipType } from '@/types/vip';
import { initialURL } from '@/lib/urls';

const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL,
  timeout: 5000
});

export const vipApi = {
  async getVipOptions(): Promise<VipType[]> {
    try {
      const response = await apiClient.get<VipType[]>('/api/vips');
      return response.data;
    } catch (error) {
      console.error('Error fetching VIP options:', error);
      throw error;
    }
  }
};

export const VIP_STATUS = {
  NOT_SUBSCRIBED: 1, // 未开通
  EXPIRED: 2,        // 已过期
  ACTIVE: 3,         // 有效
  ERROR: 4           // 异常
}


export async function checkUserVipStatus(userId: number) {
  try {
    const response = await fetch(`${initialURL.SERVER_URL}/api/user-vip-relations/user/${userId}`);
    if (!response.ok) throw new Error('请求失败');
    const vipRelations = await response.json();
    const nowUTC = new Date();

    if (!vipRelations || vipRelations.length === 0) {
      return {
        status: 1,
        remainingDays: 0
      };
    }
    const latestVip = [...vipRelations]
      .sort((a, b) => new Date(b.expireTime).getTime() - new Date(a.expireTime).getTime())
      .find(Boolean);

    const expireTime = new Date(latestVip.expireTime);
    const timeDiff = expireTime.getTime() - nowUTC.getTime();
    const remainingDays = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)); // 计算剩余天数

    if (expireTime < nowUTC) {
      return {
        status: 2,
        remainingDays: remainingDays
      };
    }

    // 有效：最新记录的过期时间晚于当前时间
    return {
      status: 3,
      remainingDays: remainingDays
    };
  } catch (error) {
    console.error('VIP 状态检测失败:', error);
    return {
      status: 4, // 异常状态
      remainingDays: -1 // 异常时返回 -1
    };
  }
}

