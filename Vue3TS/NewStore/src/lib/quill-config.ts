import Quill, { type QuillOptions } from 'quill';

// 定义精确的 Font 类型
interface FontAttributor {
  attrName: string;
  keyName: string;
  scope: any;
  whitelist: string[];
}

// 定义 Size 类型
interface SizeAttributor {
  whitelist: string[];
}

// 安全导入方法
const getQuillModule = <T>(path: string): T => {
  const module = Quill.import<T>(path);
  if (!module) {
    throw new Error(`Quill module ${path} not found`);
  }
  return module;
};

// 自定义字体白名单
const fontFamily = ['SimSun', 'SimHei', 'Microsoft-YaHei', 'KaiTi', 'FangSong', 'Arial', 'pingfang'];
const Font: FontAttributor = getQuillModule<FontAttributor>('formats/font');
Font.whitelist = fontFamily;

// 正确注册方式
Quill.register(
  {
    'formats/font': Font
  }, 
  true
);

// 自定义文字大小
const fontSize = ['10px', '12px', '14px', '16px', '20px', '24px', '36px'];
const Size: SizeAttributor = getQuillModule<SizeAttributor>('attributors/style/size');
Size.whitelist = fontSize;

// 正确注册方式 
Quill.register(
  {
    'attributors/style/size': Size
  },
  true
);



// 工具栏配置
export const toolbarOptions = [
  [
    "bold", "italic", "underline", "strike", "blockquote", "code-block",
    { header: 1 }, { header: 2 }, { list: "ordered" }, { list: "bullet" },
    { indent: "-1" }, { indent: "+1" }, { align: [] }
  ],
  [{ size: fontSize }],
  [{ header: [1, 2, 3, 4, 5, 6, false] }],
  [{ font: fontFamily }],
];

// 默认配置
export const quillConfig: QuillOptions = {
  theme: 'snow',
  modules: {
    toolbar: toolbarOptions
  }
};