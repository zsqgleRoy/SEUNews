import { SlateDescendant, SlateElement, SlateText } from '@wangeditor/editor'

declare module '@wangeditor/editor' {
    // 扩展 Text
    interface SlateText {
        text: string
    }

    // 扩展 Element
    interface SlateElement {
        type: string
        children: SlateDescendant[]
    }
}

// src/types/wangeditor.d.ts
declare module '@wangeditor/editor-for-vue' {
    import type { DefineComponent } from 'vue'
  
    type EditorComponent = DefineComponent<
      {
        modelValue: string
        defaultConfig: Record<string, any>
        mode: 'default' | 'simple'
      },
      {},
      any
    >
  
    export const Editor: EditorComponent
    export const Toolbar: DefineComponent
  }