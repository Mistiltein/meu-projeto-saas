# syntax=docker/dockerfile:1
ARG NODE_VERSION=24.13.0-slim
FROM node:${NODE_VERSION} AS base

# ==================== DEPENDÊNCIAS ====================
FROM base AS deps
WORKDIR /app
COPY package.json pnpm-lock.yaml* ./
RUN npm i -g pnpm && pnpm i --frozen-lockfile

# ==================== BUILD ====================
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm i -g pnpm && pnpm build

# ==================== RUNNER (produção) ====================
FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production
# ENV NEXT_TELEMETRY_DISABLED=1   # descomente se quiser

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copia os arquivos públicos
COPY --from=builder /app/public ./public

# Cria o diretório .next ANTES de copiar o conteúdo estático
RUN mkdir -p .next && chown nextjs:nodejs .next

# Copia o standalone (já inclui server.js, node_modules minimal, etc)
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./

# Copia os arquivos estáticos do .next (importante para imagens otimizadas, etc)
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]