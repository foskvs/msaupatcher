
install: msaupatcher.sh
	cp msaupatcher.sh msaupatcher
	chmod +x msaupatcher
	mkdir -p /usr/local/bin/
	cp msaupatcher /usr/local/bin/msaupatcher

uninstall:
	rm -f /usr/local/bin/msaupatcher

clean:
	rm -f msaupatcher

