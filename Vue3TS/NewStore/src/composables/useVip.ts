import { ref } from 'vue';
import { vipApi } from '@/api/vip';
import type { VipType, VipDurationOption } from '@/types/vip';

export function useVip() {
  const loading = ref(false);
  const error = ref<Error | null>(null);
  const vipOptions = ref<VipDurationOption[]>([]);

  const fetchVipOptions = async () => {
    try {
      loading.value = true;
      const data = await vipApi.getVipOptions();
      
      // 转换后端数据为前端需要的格式
      vipOptions.value = data.map(vip => ({
        label: `${vip.durations}`, 
        value: vip.durationsValue,
        price: calculateBasePrice(vip.type, vip.durationsValue),
        discount: vip.discount
      }));
    } catch (err) {
      error.value = err as Error;
    } finally {
      loading.value = false;
    }
  };

  const calculateBasePrice = (type: string, duration: number): number => {
    const base = type.startsWith('SVIP') ? 30 : 20;
    return base * duration;
  };

  return {
    loading,
    error,
    vipOptions,
    fetchVipOptions
  };
}