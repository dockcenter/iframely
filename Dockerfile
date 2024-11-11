FROM node:lts-alpine AS dep

ARG REF

ENV PNPM_HOME="/pnpm"

ENV PATH="$PNPM_HOME:$PATH"

WORKDIR /app

RUN corepack enable

ADD https://github.com/itteco/iframely.git#$REF /app

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

RUN rm -rf .github ansible-docker-iframely docker docs

FROM gcr.io/distroless/nodejs22-debian12:nonroot

WORKDIR /app

COPY --from=dep /app /app

EXPOSE 8061

CMD ["/app/server.js"]
