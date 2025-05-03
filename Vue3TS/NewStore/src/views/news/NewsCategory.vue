<template>
    <div class="block block-category">
        <h2 class="section-title">新闻分类</h2>
        <div class="category-grid">
            <div class="category-item" v-for="(category, index) in categories" :key="index">
                <router-link :to="category?.path" class="category-link">
                    <img :src="category?.icon" alt="分类图标" class="category-icon">
                </router-link>
            </div>
        </div>
    </div>
</template>

<script lang="ts" setup>

const props = defineProps({
    categories: {
        type: Array,
        default: () => []
    }
});
</script>

<style scoped lang="scss">
.block {
    background-color: rgba(255, 255, 255, 0.9);
    border-radius: 20px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
    padding: 2rem;
    margin-bottom: 1rem;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.block:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 36px rgba(0, 0, 0, 0.15);
}

.section-title {
    color: transparent;
    font-size: 1.8rem;
    margin-bottom: 1.5rem;
    border-bottom: 5px solid transparent;
    background: linear-gradient(135deg, #0055ff, #6b00bc);
    -webkit-background-clip: text;
    background-clip: text;
    border-image: linear-gradient(135deg, #0055ff, #6b00bc) 1;
    padding-bottom: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.category-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(64px, 1fr));
    gap: 2rem;
}

.category-item {
    text-align: center;
    border-radius: 16px;
    padding: 0.5rem;
    transition: background-color 0.3s ease, transform 0.3s ease;
    background-color: rgba(255, 255, 255, 0.7);
}

.category-item:hover {
    background-color: #ecf0f1;
    transform: translateY(-5px);
}

.category-link {
    text-decoration: none;
    color: inherit;
}

.category-icon {
    width: 100%;
    height: auto;
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
}

.category-name {
    font-size: 1.2rem;
    color: #3498db;
    font-weight: 600;
    display: flex;
    flex-direction: column;
    align-items: center;
}
</style>
    