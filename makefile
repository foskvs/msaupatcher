
install: msaupatcher.sh
	cp msaupatcher.sh msaupatcher
	chmod +x msaupatcher
	cp msaupatcher /usr/local/bin/msaupatcher

uninstall:
	rm -f /usr/local/bin/msaupatcher

clean:
	rm -f msaupatcher

