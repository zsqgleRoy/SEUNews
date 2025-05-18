<template>
    <el-button
        text
        :type="'primary'"
        class="custom-text-button"
        @click="More"
    >
        更多&nbsp;&nbsp;<el-icon><DArrowRight /></el-icon>
    </el-button>
</template>

<script lang="ts" setup>
    import { useRouter } from 'vue-router';
    const router = useRouter();
    const props = defineProps({
        tagId: {
            type: Number,
            required: true
        }
    })
    const More = () => {
        router.push(`/newsList/${props.tagId}`);
    }
</script>

<style scoped lang="scss">
  .custom-text-button, .el-button--text:hover {
    background: none !important;
    border: none !important;
  }
</style>