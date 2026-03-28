# Imagem base oficial da Microsoft (recomendada para Dev Containers)
FROM mcr.microsoft.com/devcontainers/typescript-node:24-bookworm

# ==================== PACOTES DO SISTEMA ====================
# Instala ferramentas úteis para desenvolvimento Next.js + bancos
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        postgresql-client \
        # git (geralmente já vem, mas garante)
        git \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# ==================== CONFIGURAÇÃO DO PNPM ====================
# Variáveis de ambiente recomendadas para pnpm em Dev Container
ENV PNPM_HOME="/home/node/.local/share/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0

# Cria diretórios necessários e ajusta permissões ANTES de ativar o corepack
RUN mkdir -p /home/node/.local/share/pnpm/store \
    && chown -R node:node /home/node/.local \
    && chmod -R 755 /home/node/.local

# Ativa corepack e prepara a versão mais recente do pnpm como usuário node
USER node

RUN corepack enable \
    && corepack prepare pnpm@latest --activate

# Volta para root apenas para as configurações finais (se necessário)
USER root

# ==================== WORKDIR E PERMISSÕES ====================
WORKDIR /workspaces/meu-projeto-saas

# Garante que o workspace pertença ao usuário node
RUN chown -R node:node /workspaces

# Volta para o usuário node (segurança)
USER node

# Comando que roda toda vez que o container é criado/rebuildado
# (melhor deixar o install aqui do que no devcontainer.json)
CMD ["bash"]