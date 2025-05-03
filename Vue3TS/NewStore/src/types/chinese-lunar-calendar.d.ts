// 1. 定义 lunar 数据结构
interface LunarData {
  year: number;
  month: number;
  day: number;
  animal: string; // 生肖
  term: string; // 节气
  // 其他字段参考库文档：
}

// 2. 声明模块导出
declare module 'chinese-lunar-calendar' {
  /**
   * 将公历日期转换为农历
   * @param solarDate 公历日期（Date 或时间戳）
   * @returns 农历对象
   */
  export function getLunar(solarDate: Date | number): LunarData;
}
