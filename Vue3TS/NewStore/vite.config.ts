import { fileURLToPath, URL } from 'node:url'
import tailwindcss from '@tailwindcss/vite'
import { defineConfig } from 'vite' // 导入 loadEnv
import vue from '@vitejs/plugin-vue'
import { initialURL } from "./src/lib/urls.js"

export default defineConfig(({ mode }) => {
  return {
    plugins: [
      vue(),
      tailwindcss(),
    ],
    resolve: {
      alias: {
        '@': fileURLToPath(new URL('./src', initialURL.LOCAL_URL))
      },
    },
    server: {
      host: initialURL.BASE_URL,
      port: initialURL.LOCAL_PORT,
      open: true,
      target: 'http://seunewsbac.pgrm.cc/',
      changeOrigin: true,
      allowedHosts: ['876z16167z.vicp.fun',
         'localhost',
         'seunews.pgrm.cc',
         'seunewsbac.pgrm.cc'],
    },
  }
})