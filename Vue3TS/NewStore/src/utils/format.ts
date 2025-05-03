import {ArticleStatus} from "@/api/news"
// 格式化日期
export const formatDate = (date: Date | string | number, format = 'YYYY-MM-DD'): string => {
    let d: Date;
    if (typeof date === 'string') {
        d = new Date(date);
    } else if (typeof date === 'number') {
        d = new Date(date);
    } else {
        d = date;
    }

    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    const hour = String(d.getHours()).padStart(2, '0');
    const minute = String(d.getMinutes()).padStart(2, '0');
    const second = String(d.getSeconds()).padStart(2, '0');

    return format
      .replace('YYYY', String(year))
      .replace('MM', month)
      .replace('DD', day)
      .replace('HH', hour)
      .replace('mm', minute)
      .replace('ss', second);
};

// 格式化数字，添加千位分隔符
export const formatNumber = (num: number): string => {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
};

// 截取字符串并添加省略号
export const truncateString = (str: string, length: number): string => {
    if (str.length <= length) {
        return str;
    }
    return str.slice(0, length) + '...';
};

export const formatStatus = (status: ArticleStatus) : String =>{
    if(status === ArticleStatus.PUBLISH)
        return "已发布";
    else
        return "编辑中";
};
