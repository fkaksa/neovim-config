FROM ubuntu:22.04 AS base

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
  git \
  curl \
  ca-certificates \
  gnupg \
  wget \
  unzip \
  ripgrep \
  fd-find \
  openjdk-17-jdk-headless \
  lynx \
  cargo \
  ruby \
  gem \
  composer \
  php \
  golang \
  build-essential \
  libreadline-dev \
  libncurses5-dev \
  libssl-dev \
  lua5.1 \
  lua5.1-dev \
  libreadline-dev \
  python3 \
  python3-pip \
  python3-venv \
  python-is-python3 \
  locales && \
  locale-gen en_US.UTF-8 && \
  update-locale LANG=en_US.UTF-8curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
  apt-get install -y nodejs && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV GO_VERSION=1.23.11
RUN curl -LO https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
  rm go${GO_VERSION}.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

ENV TREE_SITTER_VERSION=0.25.8
RUN curl -LO https://github.com/tree-sitter/tree-sitter/releases/download/v${TREE_SITTER_VERSION}/tree-sitter-linux-x64.gz && \
  gunzip tree-sitter-linux-x64.gz && \
  chmod +x tree-sitter-linux-x64 && \
  mv tree-sitter-linux-x64 /usr/local/bin/tree-sitter

ENV LUAROCKS_VERSION=3.11.0
RUN curl -L https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz | tar xz && \
  cd luarocks-${LUAROCKS_VERSION} && \
  ./configure --with-lua-include=/usr/include/lua5.1 && \
  make && make install && \
  cd .. && rm -rf luarocks-${LUAROCKS_VERSION}

# Install nvm, Node.js (v22), and npm as the user
# TODO
# Install nvm, Node.js (v22), and npm as the user
# Create a script file sourced by both interactive and non-interactive bash shells
ENV BASH_ENV=/root/.bash_env
RUN touch "${BASH_ENV}"
RUN echo '. "${BASH_ENV}"' >> ~/.bashrc

# Download and install nvm, npm and Node.js (v22)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE="${BASH_ENV}" bash && \
  echo 'nvm install 22 && nvm use 22 && nvm alias default 22' >> /root/.bashrc && \
  bash -lc "nvm install 22 && nvm use 22 && nvm alias default 22" && \
  # Install global npm packages using nvm's node
  bash -lc "npm install -g tree-sitter-cli" && \
  curl https://sh.rustup.rs -sSf | sh -s -- -y

# Create symlink for fd
RUN ln -s $(which fdfind) /usr/local/bin/fd

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

FROM base AS nvim

ENV NVIM_VERSION=0.11.3
RUN curl -LO https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.tar.gz && \
  tar xzf nvim-linux-x86_64.tar.gz && \
  mv nvim-linux-x86_64 /opt/nvim && \
  ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
  rm nvim-linux-x86_64.tar.gz

# create alias for nvim and vim
RUN ln -s /usr/local/bin/nvim /usr/local/bin/vim

FROM nvim AS final

WORKDIR /root/.config/nvim

COPY init.lua .
COPY lua/ lua
COPY after/ after
COPY start.sh start.sh
COPY tests/ tests
RUN chmod +x start.sh

# Start in Neovim
ENTRYPOINT ["./start.sh"]
