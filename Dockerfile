FROM centos:7
ARG MEILISEARCH_VERSION

# Install Rust
RUN yum group install -y "Development Tools"
RUN curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Download and extract Meilisearch source
RUN curl -L "https://github.com/meilisearch/meilisearch/archive/refs/tags/v${MEILISEARCH_VERSION}.tar.gz" > meilisearch.tar.gz
RUN tar zxf meilisearch.tar.gz

# Build
WORKDIR "meilisearch-${MEILISEARCH_VERSION}"
RUN ~/.cargo/bin/cargo build --release
