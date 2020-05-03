
PREFIX = /usr/local

dlv: dlv.sh
	cat dlv.sh > $@
	echo 'exit 0' >> $@
	echo "#EOF" >> $@
	chmod +x $@

test: dlv.sh
	shellcheck -s sh dlv.sh

clean:
	rm -f dlv

install: dlv
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dlv $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dlv

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dlv

.PHONY: test clean install uninstall
