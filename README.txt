-- sludge, ruby server for reloading files in console

- description
  Accepts data from UNIX server on /tmp/.sludge.sock, waits for a connection,
  loads the filename sent, prints exception in case everything went wrong.

- usage
  Build and/or install gem, call Kernel::sludge(or just sludge) and send
  data to the socket.

  For usage with vim I recommend putting this in your vimrc:
    map <silent> \s :!echo -n "%" \| socat - UNIX-CONNECT:/tmp/.sludge.sock &<CR><CR>

- inspiration
  I was tired of copying path and `load "<Command-v"''-ing the models or
  whatever I was testing or using. I instantly remembered SLIME and emacs'
  C-c C-c, which reloaded whatever shenanigans I had in my silly mind. :]

- license
  Take it, it's yours. (None.)
