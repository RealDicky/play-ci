import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  publicDir: process.env.VITE_PUBLIC_PATH || 'public',
  plugins: [vue()]
})
