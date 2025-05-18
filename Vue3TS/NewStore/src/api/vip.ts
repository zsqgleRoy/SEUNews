import axios from 'axios';
import type { VipType } from '@/types/vip';

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