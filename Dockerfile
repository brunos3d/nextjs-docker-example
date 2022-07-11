# Install deps and build the source code only when needed
FROM node:16-alpine AS builder
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# Production image, copy all the files and run next
FROM node:16-alpine AS runner
WORKDIR /app

ENV NODE_ENV production

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

COPY package.json package-lock.json ./
RUN npm ci --only=production

COPY --from=builder --chown=nextjs:nodejs /app/public /app/.next ./

USER nextjs
EXPOSE 3000

CMD ["npm", "start"]