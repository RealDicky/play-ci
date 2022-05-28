FROM node:14-alpine as builder

ARG OSS_KEY
ARG OSS_SECRET
ARG ENDPOINT

ENV PUBLIC_URL https://play-ci.oss-cn-hangzhou.aliyuncs.com

WORKDIR play-ci

RUN wget http://gosspublic.alicdn.com/ossutil/1.7.7/ossutil64 -O /usr/local/bin/ossutil \
  && chmod 755 /usr/local/bin/ossutil \
  && ossutil config -i $OSS_KEY_ -k $OSS_SECRET -e $ENDPOINT

# 单独分离 package.json，是为了安装依赖可最大限度利用缓存
ADD package.json yarn.lock /play-ci/
RUN yarn

ADD . /play-ci
RUN npm run build && npm run oss:cli

# 选择更小体积的基础镜像
FROM nginx:alpine
COPY --from=builder /play-ci/dist /usr/share/nginx/html
