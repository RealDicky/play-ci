import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  publicDir: import.meta.env.PUBLIC_PATH || 'public',
  plugins: [vue()]
})
