# DevOpsHelper 前端镜像：构建 + Nginx 托管
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json .npmrc ./
RUN npm install --no-audit --no-fund
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
