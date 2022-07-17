# syntax=docker/dockerfile:1
FROM node:12-alpine AS getting-started
RUN apk add --no-cache python2 g++ make
WORKDIR /app
COPY . .
RUN yarn install --production

FROM getting-started
WORKDIR /app
CMD ["node", "src/index.js"]
EXPOSE 3000
