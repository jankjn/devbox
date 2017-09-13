FROM finalduty/archlinux:monthly

ARG user=jankjn

RUN echo 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Syu --noconfirm sudo systemd neovim zsh git postgresql

RUN useradd -G wheel -m $user && echo "$user	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER $user
RUN curl 'https://raw.githubusercontent.com/jankjn/scripts/master/arch_provision.sh' | sh

WORKDIR /home/$user
ENTRYPOINT ["/bin/zsh"]
