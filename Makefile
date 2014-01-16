V=20140108

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 blackarch{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/blackarch{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=blackarch-keyring-$(V)/ $(V) | gzip -9 > blackarch-keyring-$(V).tar.gz
	gpg --default-key 1E01F333 --detach-sign --use-agent blackarch-keyring-$(V).tar.gz

upload:
	scp blackarch-keyring-$(V).tar.gz blackarch-keyring-$(V).tar.gz.sig blackarch.org:/nginx/var/www/keyring/

.PHONY: install uninstall dist upload
