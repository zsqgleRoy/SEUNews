<template>
    <div class="bg-gray-900 min-h-screen p-8 text-white">
      <div class="max-w-3xl mx-auto bg-gray-800 rounded-lg shadow-lg p-6 space-y-6">
        <h1 class="text-3xl font-bold text-center">个人信息管理</h1>
        <form @submit.prevent="saveInfo">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label for="name" class="block text-sm font-medium text-gray-300">姓名</label>
              <input
                type="text"
                id="name"
                v-model="info.name"
                class="mt-1 block w-full px-3 py-2 border border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 bg-gray-700 text-white"
              />
            </div>
            <div>
              <label for="email" class="block text-sm font-medium text-gray-300">邮箱</label>
              <input
                type="email"
                id="email"
                v-model="info.email"
                class="mt-1 block w-full px-3 py-2 border border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 bg-gray-700 text-white"
              />
            </div>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label for="phone" class="block text-sm font-medium text-gray-300">电话</label>
              <input
                type="tel"
                id="phone"
                v-model="info.phone"
                class="mt-1 block w-full px-3 py-2 border border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 bg-gray-700 text-white"
              />
            </div>
            <div>
              <label for="address" class="block text-sm font-medium text-gray-300">地址</label>
              <input
                type="text"
                id="address"
                v-model="info.address"
                class="mt-1 block w-full px-3 py-2 border border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 bg-gray-700 text-white"
              />
            </div>
          </div>
          <div class="flex justify-end">
            <button
              type="submit"
              class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
            >
              保存信息
            </button>
          </div>
        </form>
        <div class="bg-gray-700 rounded-lg p-4">
          <h2 class="text-xl font-bold mb-2">当前个人信息</h2>
          <p><span class="font-medium">姓名:</span> {{ info.name }}</p>
          <p><span class="font-medium">邮箱:</span> {{ info.email }}</p>
          <p><span class="font-medium">电话:</span> {{ info.phone }}</p>
          <p><span class="font-medium">地址:</span> {{ info.address }}</p>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  
  const info = ref({
    name: '',
    email: '',
    phone: '',
    address: ''
  });
  
  const saveInfo = () => {
    // 这里可以添加保存信息到后端的逻辑
    console.log('保存的信息:', info.value);
  };
  </script>
  
  <style scoped>
  
</style>    