// src/shims.d.ts
declare module 'lunar-javascript' {
  export function fromDate(date: Date): any;
    
  class Solar {
      static fromDate(date: Date): Solar;
      getLunar(): Lunar;
  }

    export  class Lunar {
      isLeapMonth(): boolean;
      getMonthInChinese(): string;
      getDayInChinese(): string;
      getYearInGanZhi(): string;
      getYearShengXiao(): string;
      getJieQi(): string | null;
      getJie(): string | null;
      getQi(): string | null;
  }
  }
  