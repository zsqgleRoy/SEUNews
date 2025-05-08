import { ref } from "vue";

const ip = ref<string | null>(null);
const province = ref<string | null>(null);
const error = ref<string | null>(null);

export const getIP = async () => {
    try {
        const response = await fetch('https://api64.ipify.org?format=json');
        if (!response.ok) {
        throw new Error('网络响应异常');
        }
        const data = await response.json();
        ip.value = data.ip;
        return ip.value;
    } catch (error) {
        console.error('获取 IP 地址时出错:', error);
    }
};

// @/api/getIP.ts
export const getProvinceByIP = async (IP: string) => {
    try {
      const response = await fetch(`http://ip-api.com/json/${IP}`);
      const data = await response.json();
      
      // 英文份名到中文的映射表（需完整覆盖所有可能的返回值）
      const provinceMap: Record<string, string> = {
        Beijing: '北京',
        Tianjin: '天津',
        Hebei: '河北',
        Shanxi: '山西',
        InnerMongolia: '内蒙古',
        Liaoning: '辽宁',
        Jilin: '吉林',
        Heilongjiang: '黑龙江',
        Shanghai: '上海',
        Jiangsu: '江苏',
        Zhejiang: '浙江',
        Anhui: '安徽',
        Fujian: '福建',
        Jiangxi: '江西',
        Shandong: '山东',
        Henan: '河南',
        Hubei: '湖北',
        Hunan: '湖南',
        Guangdong: '广东',
        Guangxi: '广西壮族',
        Hainan: '海南',
        Chongqing: '重庆',
        Sichuan: '四川',
        Guizhou: '贵州',
        Yunnan: '云南',
        Tibet: '西藏',
        Shaanxi: '陕西',
        Gansu: '甘肃',
        Qinghai: '青海',
        Ningxia: '宁夏回族',
        Xinjiang: '新疆',
        Taiwan: '台湾',
        HongKong: '香港',
        Macao: '澳门',
        // 其他可能的返回值补充...
      };
  
      if (data.status === 'success') {
        // 使用映射表转换英文为中文，未匹配则返回原始值
        return provinceMap[data.regionName] || data.regionName;
      }
      return '未知地点';
    } catch (error) {
      return '未知地点';
    }
  };
  