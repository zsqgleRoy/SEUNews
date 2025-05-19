export enum OrderStatus {
  UNPAID = 'UNPAID',
  PAID = 'PAID',
  CANCELLED = 'CANCELLED',
  REFUNDED = 'REFUNDED',
}

export interface Order {
  id:number;
  outTradeNo: string;
  uid: number;
  status: OrderStatus;
  totalAmount: number;
  createTime: string;

}

export interface PaginationResult<T> {
    content: T[];
    totalElements: number;
    totalPages: number;
    number: number;
    size: number;
}