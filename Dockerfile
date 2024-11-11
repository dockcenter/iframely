FROM node:lts-alpine

WORKDIR /app

RUN corepack enable

ADD https://github.com/itteco/iframely.git#v2.4.3 /app

RUN pnpm install --prod --frozen-lockfile

EXPOSE 8061

CMD ["/app/server.js"]
