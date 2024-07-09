FROM node:20.14.0-alpine AS builder
WORKDIR /homepedia_app
COPY package*.json ./
RUN npm ci && npm install -g npm@10.8.1
COPY . .
RUN npm run build

FROM builder
COPY --from=builder /homepedia_app ./
COPY app-entrypoint.sh ./
RUN chmod +x ./app-entrypoint.sh
ENTRYPOINT ["sh", "app-entrypoint.sh"]