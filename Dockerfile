########################################
# Intermediate builder image (used only for build, discarded in final stage)
########################################
FROM ghcr.io/sledilnik/website-base AS builder
ADD . /app
RUN yarn
RUN NODE_ENV=production CADDY_BUILD=1 yarn build

########################################
# Actual webserver image
########################################
FROM caddy:2.2.1-alpine

WORKDIR /app
COPY --from=builder /app/dist /app
COPY Caddyfile /etc/caddy/Caddyfile