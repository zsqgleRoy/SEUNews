<template>
    <div class="container">
        <input
            type="text"
            v-model="searchQuery"
            :class="{ show: isSearching }"
            @keypress="handleKeyPress"
            placeholder="搜索..."
            title="搜索"
        />
        <div class="search" @click="toggleSearch">
            <!-- 根据 isSearching 状态动态显示搜索图标或关闭图标 -->
            <span :class="{ 'search-icon':!isSearching, 'close-icon': isSearching }"></span>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

// 定义响应式变量
const searchQuery = ref('');
const isSearching = ref(false);

// 处理按键事件，当按下回车键时触发搜索
const handleKeyPress = (e: KeyboardEvent) => {
    if (e.key === 'Enter') {
        showContent();
    }
};

// 触发搜索事件，将搜索内容通过自定义事件传递给父组件
const showContent = () => {
    const searchEvent = new CustomEvent('search', { detail: searchQuery.value });
    document.dispatchEvent(searchEvent);
    toggleSearch();
};

// 切换搜索状态
const toggleSearch = () => {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
        searchQuery.value = '';
    }
};
</script>

<style scoped>
.container {
    position: relative;
    float: right;
    max-width: 200px;
    height: 50px;
}

.container .search {
    position: absolute;
    right: 0;
    width: 50px;
    height: 50px;
    background-color: rgba(255, 255, 255, 0.2);
    border-radius: 50%;
    transition: all 1s;
    z-index: 4;
    box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.4);
    cursor: pointer;
}

.container .search:hover {
    cursor: pointer;
    background-color: rgba(255, 255, 255, 0.4);
}

.container .search-icon::before,
.container .close-icon::before,
.container .search-icon::after,
.container .close-icon::after {
    content: "";
    position: absolute;
    background: white;
    transition: all 0.3s ease; /* 添加过渡效果 */
}

.container .search-icon::before {
    top: 30px;
    right: 0;
    bottom: 0;
    left: 27px;
    width: 13px;
    height: 3px;
    transform: rotate(45deg);
}

.container .search-icon::after {
    top: 13px;
    right: 0;
    bottom: 0;
    left: 13px;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    border: 4px solid white;
}

.container .close-icon::before {
    top: 23px;
    left: 12px;
    width: 25px;
    height: 2px;
    transform: rotate(-45deg);
}

.container .close-icon::after {
    top: 23px;
    left: 12px;
    width: 25px;
    height: 2px;
    transform: rotate(45deg);
}

.container input {
    font-family: "Inconsolata", monospace;
    position: absolute;
    right: 0;
    width: 50px;
    height: 50px;
    outline: none;
    border: 2px solid yellow;
    background-color: rgba(255, 255, 255, 0.4);
    color: white;
    text-shadow: none;
    padding: 0 60px 0 20px;
    border-radius: 30px;
    box-shadow: 0 0 10px 0 rgba(52, 152, 219, 0.3);
    transition: all 1s;
    opacity: 0;
    z-index: 3;
    font-weight: bolder;
    letter-spacing: 0.1em;
}

.container input.show {
    width: 250px;
    opacity: 1;
    cursor: text;
    border-color: yellow;
}

.container input::placeholder {
    color: white;
    opacity: 0.8;
    font-weight: bolder;
}
</style>
