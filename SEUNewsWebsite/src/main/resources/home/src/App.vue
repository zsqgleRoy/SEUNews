<template>
  <div id="app">
    <header>
      <Navbar />
    </header>
    <main>
      <RouterView />
    </main>
  </div>
</template>

<script setup lang="ts">
import { RouterView } from 'vue-router';
import Navbar from './components/navbar.vue';

</script>

<style scoped>
#app {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  min-width: 500px;
}

main {
  flex: 1;
  background-color: #f5f5f5;
  padding: 10px;
}
</style>
