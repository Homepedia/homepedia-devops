#!/bin/sh
npm ci
npm install -g npm@10.8.1
npm run start -- -p ${APP_PORT}