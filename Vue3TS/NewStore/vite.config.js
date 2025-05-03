import { fileURLToPath, URL } from 'node:url';
import tailwindcss from '@tailwindcss/vite';
import { defineConfig } from 'vite'; // 导入 loadEnv
import vue from '@vitejs/plugin-vue';
import { initialURL } from "./src/lib/urls.js";
export default defineConfig(({ mode }) => {
    return {
        plugins: [
            vue(),
            tailwindcss(),
        ],
        build: {
            ignoreBuildErrors: true,
            // 或更精细控制（仅忽略 TS 错误）
            // ssr: { noExternal: ['vue'] } // 可选
        },
        resolve: {
            alias: {
                '@': fileURLToPath(new URL('./src', import.meta.url))
            },
        },
        server: {
            host: initialURL.BASE_URL,
            port: initialURL.LOCAL_PORT,
            open: true,
            allowedHosts: ['876z16167z.vicp.fun',
                'localhost',
                'seunews.pgrm.cc',
                'seunewsbac.pgrm.cc'],
        },
    };
});
