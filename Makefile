
PREFIX = /usr/local

dlv: dlv.sh
	cat dlv.sh > $@
	echo 'exit 0' >> $@
	echo "#EOF" >> $@
	chmod +x $@

mlb: mlb.sh filter.awk vul.tsv kjv.tsv
	cat mlb.sh > $@
	echo 'exit 0' >> $@
	echo "#EOF" >> $@
	tar cz filter.awk vul.tsv kjv.tsv >> $@
	chmod +x $@

test: dlv.sh mlb.sh
	shellcheck -s sh dlv.sh
	shellcheck -s sh mlb.sh

clean:
	rm -f dlv mlb

install: dlv mlb
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dlv $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dlv
	cp -f mlb $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/mlb

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dlv
	rm -f $(DESTDIR)$(PREFIX)/bin/mlb

.PHONY: test clean install uninstall
