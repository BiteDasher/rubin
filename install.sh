#!/bin/bash
__install() {
	sudo mkdir -v -p -m 755 /usr/share/rubin
	sudo install -vDm755 ./install /usr/share/rubin/install
	sudo install -vDm755 ./test /usr/share/rubin/test
	sudo install -vDm755 ./translate_bin /usr/share/rubin/translate_bin
	sudo ln -v -s /usr/share/rubin/install /usr/local/bin/rubin
	[ "$PACMAN" == 1 ] && {
	sudo install -vDm755 ./hook-install /usr/share/libalpm/scripts/rubin-install
	sudo install -vDm755 ./hook-remove /usr/share/libalpm/scripts/rubin-remove
	sudo install -vDm644 ./pacman-install-hook /usr/share/libalpm/hooks/99-rubin-install.hook
	sudo install -vDm644 ./pacman-remove-hook /usr/share/libalpm/hooks/99-rubin-remove.hook
	}
}
if [ -z "$1" ]; then
	__install
fi
case "$1" in
	install) __install ;;
	remove) sudo rm -r -v /usr/share/rubin \
			      /usr/local/bin/rubin $(
			      if [ "$PACMAN" == 1 ]; then echo '
				/usr/share/libalpm/scripts/rubin-install
				/usr/share/libalpm/scripts/rubin-remove
				/usr/share/libalpm/hooks/99-rubin-install.hook
				/usr/share/libalpm/hooks/99-rubin-remove.hook'; fi) ;;
	makepkg) 
		sudo mkdir -p -m 755 /usr/share/rubin
		sudo install -Dm755 ./install /usr/share/rubin/install
		sudo install -Dm755 ./test /usr/share/rubin/test
		sudo install -Dm755 ./translate_bin /usr/share/rubin/translate_bin
		sudo ln -s /usr/share/rubin/install /usr/bin/rubin
		sudo install -Dm755 ./hook-install /usr/share/libalpm/scripts/rubin-install
		sudo install -Dm755 ./hook-remove /usr/share/libalpm/scripts/rubin-remove
		sudo install -Dm644 ./pacman-install-hook /usr/share/libalpm/hooks/99-rubin-install.hook
		sudo install -Dm644 ./pacman-remove-hook /usr/share/libalpm/hooks/99-rubin-remove.hook ;;
esac
