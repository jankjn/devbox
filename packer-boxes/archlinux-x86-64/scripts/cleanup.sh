# clean up
unset HISTFILE
[ -f /root/.bash_history ] && rm /root/.bash_history
find /var/log -type f | while read f; do echo -ne '' > $f; done;
yes | pacman -Scc
