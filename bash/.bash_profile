[ -f "$HOME/.profile" ] && . "$HOME/.profile"

case "$-" in
*i*) [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc" ;;
esac
