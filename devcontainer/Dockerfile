# Uses the image that you already have
FROM testnvim

# All-might root is powerful
USER root

# This only works if the image is Alpine-based
RUN apk update && apk add --no-cache \
    neovim \
    git \
    curl \
    wget \
    build-base \
    ripgrep \
    npm \
    sudo \
    bash \
    openrc \
    shadow

# We're not all-might root =(
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# This makes some magic to the permissions works
RUN \
    groupadd --gid $USER_GID $USERNAME || groupmod -n $USERNAME $(getent group $USER_GID | cut -d: -f1) \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME --shell /bin/bash || usermod -aG $USERNAME $(getent passwd $USER_UID | cut -d: -f1) \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME \
    && mkdir -p /home/$USERNAME/.cache/nvim

USER $USERNAME

# Our beloved home s2
WORKDIR /home/$USERNAME
