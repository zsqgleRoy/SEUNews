<template>
  <div class="bg-white p-8 rounded-lg shadow-md space-y-6">
    <h2 class="text-2xl font-bold text-center text-gray-800">会员充值</h2>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div
        v-for="(duration, index) in durationOptions"
        :key="index"
        class="border p-4 rounded-md hover:bg-gray-100 cursor-pointer"
        :class="{ 'border-blue-500 bg-blue-100': selectedDuration === duration }"
        @click="selectDuration(duration)"
      >
        <p class="text-lg font-semibold text-gray-800">{{ duration.label }}</p>
        <p class="text-gray-600">{{ duration.price }} 元</p>
      </div>
    </div>
    <button
      @click="handleRecharge"
      class="bg-blue-500 text-white py-2 px-4 rounded-md w-full hover:bg-blue-600"
      :disabled="!selectedDuration"
    >
      立即充值
    </button>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue';

interface DurationOption {
  label: string;
  price: number;
  months: number;
}

const durationOptions: DurationOption[] = [
  { label: '1 个月会员', price: 20, months: 1 },
  { label: '3 个月会员', price: 50, months: 3 },
  { label: '12 个月会员', price: 180, months: 12 },
];

const selectedDuration = ref<DurationOption | null>(null);

const selectDuration = (duration: DurationOption) => {
  selectedDuration.value = duration;
};

const handleRecharge = () => {
  if (selectedDuration.value) {
    alert(`你选择了 ${selectedDuration.value.label}，需支付 ${selectedDuration.value.price} 元`);
    // 这里可以添加实际的充值逻辑
  }
};
</script>    