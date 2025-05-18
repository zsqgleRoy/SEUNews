// 校验字符串是否非空
export const isStringNotEmpty = (str: string | undefined | null): boolean => {
    return str!== null && str!== undefined && str.trim()!== '';
};

// 校验数组是否非空
export const isArrayNotEmpty = <T>(arr: T[] | undefined | null): boolean => {
    return arr!== null && arr!== undefined && arr.length > 0;
};

// 校验对象是否非空（即至少有一个可枚举属性）
export const isObjectNotEmpty = (obj: Record<string, any> | undefined | null): boolean => {
    return obj!== null && obj!== undefined && Object.keys(obj).length > 0;
};

// 校验数字是否有效（非 NaN 且非 null、undefined）
export const isNumberValid = (num: number | undefined | null): boolean => {
    return num!== null && num!== undefined &&!isNaN(num);
};    