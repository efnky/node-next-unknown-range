FROM node:22-alpine AS deps
ENV COREPACK_INTEGRITY_KEYS=0
WORKDIR /app
COPY package.json ./
RUN npm install

FROM node:22-alpine AS builder
ENV COREPACK_INTEGRITY_KEYS=0
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:22-alpine AS runner
ENV NODE_ENV=production
WORKDIR /app
RUN addgroup -g 1001 -S nodejs && adduser -S nextjs -u 1001
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
EXPOSE 3000
USER nextjs
CMD ["node_modules/.bin/next", "start"]