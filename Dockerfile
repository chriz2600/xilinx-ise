FROM ubuntu:14.04

# Packages
# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get -qq install -y --no-install-recommends \
        expect \
        libfontconfig1 \
        libfreetype6 \
        libglib2.0-0 \
        libsm6 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        locales \
        sudo \
        wget && \
    rm -rf /var/lib/apt/lists/*

# Set LOCALE to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

# Add user
RUN useradd -ms /bin/bash user \
    && bash -o pipefail -c "printf user:user | chpasswd" \
    && printf "user ALL= NOPASSWD: ALL\\n" >> /etc/sudoers

# Adding scripts
COPY files /

# Install ISE
WORKDIR /root
RUN wget -q -P /root/install \
        "http://127.0.0.1:8765/Xilinx_ISE_DS_14.7_1015_1-1.tar" \
        "http://127.0.0.1:8765/Xilinx_ISE_DS_14.7_1015_1-2.zip.xz" \
        "http://127.0.0.1:8765/Xilinx_ISE_DS_14.7_1015_1-3.zip.xz" \
        "http://127.0.0.1:8765/Xilinx_ISE_DS_14.7_1015_1-4.zip.xz" && \
    tar -xvf install/Xilinx_ISE_DS_14.7_1015_1-1.tar -C install && \
    TERM=xterm /root/setup && \
    rm -rf setup install

# Run as normal user
WORKDIR /home/user
USER user
