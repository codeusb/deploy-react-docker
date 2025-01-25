# 第一阶段：构建应用
FROM node:18 as build-stage

WORKDIR /app

COPY package*.json ./

COPY . .

RUN npm install

RUN npm run build

# 第二阶段：设置 Nginx
FROM nginx:alpine

# 从构建阶段复制构建的文件到 Nginx 服务器
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 复制 Nginx 配置文件
# COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]