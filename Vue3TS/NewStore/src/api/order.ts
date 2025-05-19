import axios from 'axios';
import { type Order, type PaginationResult, OrderStatus } from '@/types/order';
import { initialURL } from '@/lib/urls';

const API_BASE_URL = initialURL.SERVER_URL+'/api' || '/api';

export const orderService = {
  async getAllOrders(page: number, size: number): Promise<PaginationResult<Order>> {
    const { data } = await axios.get(`${API_BASE_URL}/orders`, {
      params: { page: page - 1, size } // 转换为0-based
    });
    return {
      content: data.content,
      totalElements: data.totalElements,
      totalPages: data.totalPages,
      number: data.number + 1, // 转换回1-based
      size: data.size
    };
  },

  async getByOutTradeNo(outTradeNo: string): Promise<Order> {
    const { data } = await axios.get(`${API_BASE_URL}/orders/${outTradeNo}`);
    return data.content;
  },

  async getByUserId(userId: number, status?: OrderStatus): Promise<Order[]> {
    const params = status ? { status } : {};
    const { data } = await axios.get(`${API_BASE_URL}/orders/user/${userId}`, { params });
    return data.content;
  },

  async updateStatus(outTradeNo: string, status: OrderStatus): Promise<void> {
    await axios.put(`${API_BASE_URL}/orders/${outTradeNo}/status`, { status });
  }
};
