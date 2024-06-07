# 使用官方的 Node.js 镜像作为基础镜像
FROM node:20-alpine

# 设置工作目录
WORKDIR /app

# 安装项目依赖
RUN npm install -g pnpm

# 复制 package.json 和 package-lock.json
COPY package*.json ./

RUN pnpm install

# 复制所有项目文件到工作目录
COPY . .

# 构建项目
RUN npm run build

# 使用 Nginx 作为前端服务器
FROM nginx:stable-alpine

# 将构建输出复制到 Nginx 的静态文件目录
COPY --from=0 /app/dist /usr/share/nginx/html


