V=20140108

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 archlinux{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/archlinux{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=archlinux-keyring-$(V)/ $(V) | gzip -9 > archlinux-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent archlinux-keyring-$(V).tar.gz

upload:
	scp archlinux-keyring-$(V).tar.gz archlinux-keyring-$(V).tar.gz.sig nymeria.archlinux.org:/srv/ftp/other/archlinux-keyring/

.PHONY: install uninstall dist upload
