FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIM_VERSION=0.10.4

# Install Neovim and dependencies
RUN apt-get update && apt-get install -y \
  git \
  curl \
  ca-certificates \
  gnupg \
  wget \
  unzip \
  ripgrep \
  fd-find \
  openjdk-17-jre-headless \
  golang \
  python3 \
  python3-pip &&\
  curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
  apt-get install -y nodejs && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Create symlink for fd
RUN ln -s $(which fdfind) /usr/local/bin/fd

# Download and install Neovim from official release
RUN curl -LO https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.tar.gz && \
  tar xzf nvim-linux-x86_64.tar.gz && \
  mv nvim-linux-x86_64 /opt/nvim && \
  ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
  rm nvim-linux-x86_64.tar.gz

# create alias for nvim and vim
RUN ln -s /usr/local/bin/nvim /usr/local/bin/vim

RUN mkdir -p /root/.config/nvim
COPY init.lua /root/.config/nvim/
COPY lua/ /root/.config/nvim/lua
COPY after/ /root/.config/nvim/after

# Start in Neovim
ENTRYPOINT ["nvim"]
