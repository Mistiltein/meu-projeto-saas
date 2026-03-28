# Base oficial da Microsoft
FROM mcr.microsoft.com/devcontainers/typescript-node:24-bookworm

# ==================== PACOTES DO SISTEMA ====================
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        postgresql-client \
        git \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# ==================== INSTALAÇÃO DO PNPM ====================
# Instalamos o pnpm globalmente via npm (mais estável em Dev Containers)
RUN npm install -g pnpm@latest

# Configurações de ambiente
ENV PNPM_HOME="/home/node/.local/share/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0

# Cria o diretório do store e ajusta permissões
RUN mkdir -p /home/node/.local/share/pnpm/store \
    && chown -R node:node /home/node/.local

# Define o usuário node como padrão
USER node

# WORKDIR
WORKDIR /workspaces/meu-projeto-saas

# Garante permissões no workspace
USER root
RUN chown -R node:node /workspaces
USER node

CMD ["bash"]