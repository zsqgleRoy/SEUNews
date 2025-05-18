// src/utils/validate.ts
export const isStringNotEmpty = (str: string): boolean => {
    return !!str.trim();
};

// 验证邮箱格式
export const validateEmail = (email: string): boolean => {
    const regex = /^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]{2,}$/;
    return regex.test(email);
};

// 验证密码强度
export const validatePassword = (password: string): boolean => {
    // 密码长度至少为 6 位，包含至少一个字母和一个数字
    const regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;
    return regex.test(password);
};

// 验证手机号码格式
export const validatePhoneNumber = (phone: string): boolean => {
    const regex = /^1[3-9]\d{9}$/;
    return regex.test(phone);
};

// 验证身份证号码格式
export const validateIDCard = (idCard: string): boolean => {
    // 18 位身份证号码正则表达式
    const regex18 = /^[1-9]\d{5}(18|19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[0-9Xx]$/;
    // 15 位身份证号码正则表达式
    const regex15 = /^[1-9]\d{5}\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}$/;

    if (idCard.length === 18) {
        if (!regex18.test(idCard)) {
            return false;
        }
        // 18 位身份证号码的加权因子
        const weightFactor = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
        // 18 位身份证号码的校验码
        const checkCode = ['1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'];

        const idCardArray = idCard.split('');
        let sum = 0;
        for (let i = 0; i < 17; i++) {
            sum += parseInt(idCardArray[i]) * weightFactor[i];
        }
        const mod = sum % 11;
        const lastChar = idCardArray[17].toUpperCase();
        return lastChar === checkCode[mod];
    } else if (idCard.length === 15) {
        return regex15.test(idCard);
    }
    return false;
};