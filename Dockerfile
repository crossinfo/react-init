FROM node as builder
COPY ./* /src
WORKDIR /src
# RUN yarn config set registry https://registry.npm.taobao.org
ARG FRONTEND_ENV=$FRONTEND_ENV
RUN yarn install
RUN yarn build:$FRONTEND_ENV
FROM nginx
COPY --from=builder /src/build /www
ADD nginx/nginx.conf /etc/nginx/
# RUN chmod -R 777 /var/www/html/static
CMD ["nginx", "-g", "daemon off;"]
