FROM node:20-alpine3.19 AS build

COPY . /app/

WORKDIR /app

RUN npm install
RUN npm run build

FROM node:20-alpine3.19 AS next

LABEL org.opencontainers.image.source https://github.com/alexispet/cesi-cicd

WORKDIR /app

COPY --from=build /app/package.json .
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/.next ./.next

EXPOSE 3000

COPY docker/next/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT [ "docker-entrypoint" ]
CMD ["npm", "run", "start"]