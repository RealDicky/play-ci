FROM node:14-alpine as builder

WORKDIR play-ci

# 单独分离 package.json，是为了安装依赖可最大限度利用缓存
ADD package.json yarn.lock /play-ci/
RUN yarn

ADD . /play-ci
RUN npm run build

# 选择更小体积的基础镜像
FROM nginx:alpine
COPY --from=builder /dist /usr/share/nginx/html
