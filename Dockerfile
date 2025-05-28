FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIM_VERSION=0.10.4

# Install Neovim and dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    ripgrep \
    fd-find \
    python3 \
    python3-pip \
    nodejs \
    npm \
    && apt-get clean

# Create symlink for fd
RUN ln -s $(which fdfind) /usr/local/bin/fd

# Download and install Neovim from official release
RUN curl -LO https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.tar.gz && \
    tar xzf nvim-linux-x86_64.tar.gz && \
    mv nvim-linux-x86_64 /opt/nvim && \
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
    rm nvim-linux-x86_64.tar.gz

RUN useradd -ms /bin/bash tester
# USER tester
WORKDIR /home/tester

RUN mkdir -p /etc/xdg/nvim
# COPY --chown=tester init.lua /etc/xdg/nvim/
# COPY --chown=tester lua/ /etc/xdg/nvim/
# COPY --chown=tester after/ /etc/xdg/nvim/
COPY init.lua /etc/xdg/nvim/
COPY lua/ /etc/xdg/nvim/lua
COPY after/ /etc/xdg/nvim/after

# Optional: preload plugins by running headless nvim
# RUN nvim --headless "+Lazy! sync" +qa || true

# Start in Neovim
ENTRYPOINT ["nvim"]
