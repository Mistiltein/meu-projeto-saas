# Imagem base robusta para TypeScript/Node.js
FROM mcr.microsoft.com/devcontainers/typescript-node:24-bookworm

# [Opcional] Instalar pacotes adicionais do SO se necessário (ex: postgres-client)
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql-client \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Configurar variáveis de ambiente para o PNPM
ENV PNPM_HOME="/home/node/.pnpm-global"
ENV PATH="$PNPM_HOME:$PATH"

# 1. Cria o diretório do cache global do pnpm
# 2. Garante que o usuário 'node' seja o dono (evita Permission Denied)
# 3. Habilita o Corepack para gerenciar o pnpm automaticamente
RUN mkdir -p /home/node/.pnpm-global \
    && chown -R node:node /home/node/.pnpm-global \
    && corepack enable \
    && corepack prepare pnpm@latest --activate

# Define o usuário padrão como 'node' para segurança e compatibilidade
USER node

# Garante que o diretório de trabalho tenha as permissões corretas
WORKDIR /workspaces/meu-projeto-saas