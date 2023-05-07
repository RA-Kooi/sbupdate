INSTALL ?= install
SHELLCHECK ?= shellcheck

.PHONY: all check install

all:

check:
	$(SHELLCHECK) sbupdate

install:
	$(INSTALL) -D -m 0755 -t "$(DESTDIR)/usr/bin" sbupdate
	$(INSTALL) -D -m 0644 -t "$(DESTDIR)/etc" sbupdate.conf
	$(INSTALL) -o root -g root -m 0700 -d "$(DESTDIR)/etc/efi-keys"
	$(INSTALL) -o root -g root -m 0755 -d "$(DESTDIR)/etc/sbupdate"
	$(INSTALL) -D -m 0644 -t "$(DESTDIR)/usr/share/libalpm/hooks" \
      $(addprefix hooks/,95-sbupdate.hook 50-sbupdate-remove.hook 50-efi-sign.hook)
	$(INSTALL) -D -m 0644 -t \
      "$(DESTDIR)$(or $(DOCDIR),/usr/share/doc/sbupdate)" README.md
