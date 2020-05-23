FROM node:12.16.3-alpine AS builder

WORKDIR /usr/src
RUN npm install -g @angular/cli
COPY package.json package-lock.json ./
RUN npm i --no-optional

COPY angular.json .
COPY tsconfig.json .
COPY tsconfig.app.json .
COPY src src
RUN ng build --aot=true

FROM nginx:1.17.10-alpine
COPY --from=builder /usr/src/dist/my-app /usr/share/nginx/html
