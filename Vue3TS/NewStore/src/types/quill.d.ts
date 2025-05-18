import '@vueup/vue-quill';

declare module '@vueup/vue-quill' {
  interface QuillEditor {
    getQuill: () => {
      getSelection: (focus?: boolean) => { index: number } | null;
      insertEmbed: (index: number, type: string, value: string) => void;
      setSelection: (index: number, source?: 'silent' | 'user' | 'api') => void;
    };
  }
}
/// 在类型声明文件（如 quill.d.ts）中添加：
declare module 'quill' {
  interface Quill {
    on(eventName: 'selection-change', handler: (range: { index: number; length: number } | null) => void): void;
    format(name: string, value: any): void;
    getFormat(range?: number | { index: number; length: number }): Record<string, any>;
  }
  class FontStyle extends AttributorStyle {}
}