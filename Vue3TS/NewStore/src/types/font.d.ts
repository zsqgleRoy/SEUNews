// 1. 声明字体文件类型
declare module '*.ttf' {
    const content: string;
    export default content;
  }
  
  declare namespace CSS {
    interface Properties {
      'font-family': 'KaiTi-GB2312' | 'var(--font-family-kai)' | string;
    }
  }
  