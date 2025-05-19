export interface VipDurationOption {
  id:number;
  label: string;
  value: number;
  price: number;
  discount?: number;  // 新增折扣字段
}

export interface VipType {
  id: number;
  type: string;
  durations: string;
  durationsValue: number;
  discount: number;
}