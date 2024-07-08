FROM node:20.14.0-alpine
WORKDIR /homepedia_app
COPY package.json package-lock.json* ./
ENTRYPOINT ["sh", "app-entrypoint.sh"]