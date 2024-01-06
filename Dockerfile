FROM centos:7
ARG MEILISEARCH_VERSION

# Install newer version of gcc etc.
RUN yum install -y centos-release-scl
RUN yum -y install devtoolset-7-gcc

# Install Rust
RUN yum group install -y "Development Tools"
RUN curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Download and extract Meilisearch source
RUN curl -L "https://github.com/meilisearch/meilisearch/archive/refs/tags/v${MEILISEARCH_VERSION}.tar.gz" > meilisearch.tar.gz
RUN tar zxf meilisearch.tar.gz

# Build
WORKDIR "meilisearch-${MEILISEARCH_VERSION}"
RUN scl enable devtoolset-7 "~/.cargo/bin/cargo build --release"
