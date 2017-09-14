FROM finalduty/archlinux:monthly

ARG user=jankjn

RUN echo 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
RUN pacman -Sy  --noconfirm archlinux-keyring
RUN pacman -Syu --noconfirm sudo systemd man-db

RUN useradd -G wheel -m $user && echo "$user	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER $user
WORKDIR /home/$user
RUN curl 'https://raw.githubusercontent.com/jankjn/devbox/master/provision.sh' | sh

ENTRYPOINT ["/bin/zsh"]
