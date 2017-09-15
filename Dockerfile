FROM finalduty/archlinux:monthly

ARG user=jankjn

RUN echo 'Server = https://mirrors.sjtug.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
RUN sed -i 's/#Color/Color/' /etc/pacman.conf
RUN echo -e '[archlinuxcn]\n\
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch\n'\
>> /etc/pacman.conf
RUN pacman -Sy  --noconfirm --needed archlinux-keyring archlinuxcn-keyring
RUN pacman -Syu --noconfirm --needed sudo systemd base-devel man-db git hub neovim zsh tmux stow pacaur

RUN useradd -G wheel -m $user && echo "$user	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER $user
WORKDIR /home/$user
RUN git clone git://github.com/jankjn/dotfiles ~/.dotfiles && (cd ~/.dotfiles && for D in */; do stow $D; done)
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# RUN nvim +PlugInstall +qa
RUN git clone --recursive git://github.com/jankjn/prezto.git "$HOME/.zprezto"
RUN sed -i 's/nano/nvim/' "$HOME/.zprezto/runcoms/zprofile"
RUN zsh -c '\
  setopt EXTENDED_GLOB;\
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do\
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}";\
  done'

RUN curl -L 'https://git.io/n-install' | N_PREFIX=~/.n SHELL=/bin/zsh bash -s -- -y
RUN EDITOR=nvim pacaur -Syu --noconfirm --noedit chruby ruby-install
RUN yes | ruby-install -c -j4 -M https://cache.ruby-china.org/pub/ruby/ ruby && rm -df ~/src && chruby >> ~/.ruby-version

RUN sudo pacman -Scc --noconfirm


ENTRYPOINT ["/bin/zsh"]
