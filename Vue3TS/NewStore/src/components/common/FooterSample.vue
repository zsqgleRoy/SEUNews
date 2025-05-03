<template>
  <footer class="footer">
    <!-- 页脚头部 -->
    <div class="footer-header">
      <div class="footer-logo">
        <svg-logo class="svglogo" />
      </div>
      <h1 class="footer-title">东南新闻网</h1>
    </div>


    <!-- 底部版权 -->
    <div class="footer-bottom">
      <p>Copyright &copy; 2025 - {{ currentYear }} 东南新闻网开发小组 版权所有</p>
    </div>
  </footer>
</template>

<script setup lang="ts">
  import svgLogo from "@/components/common/svglogo.vue";
  const currentYear = new Date().getFullYear();
</script>

<style scoped lang="scss">
.footer {
  background: linear-gradient(135deg, #004ecc, #6b00bc);
  color: #fff;
  padding: 30px 20px;
  font-family: sans-serif;
}

.footer-header {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
}

.svglogo {
  height: 40px;
  margin-right: 10px;
}

.footer-title {
  font-size: 1.5rem;
  font-weight: bold;
  color: #ffd700;
}

h3 {
  color: #ffd700;
  border-bottom: 2px solid rgba(255, 255, 255, 0.2);
  padding-bottom: 8px;
  margin-bottom: 15px;
}

ul {
  list-style: none;
  padding: 0;
}

li {
  line-height: 1.8;
}

a {
  color: #fff;
  text-decoration: none;
  transition: color 0.3s;
}

a:hover {
  color: #ffd700;
}

.footer-bottom {
  text-align: center;
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}
</style>
