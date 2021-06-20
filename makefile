

install: msftupdtpatcher.sh
	cp msftupdtpatcher.sh /usr/local/bin/msftupdtpatcher
	chmod +x /usr/local/bin/msftupdtpatcher

clean:
	rm -f /usr/local/bin/msftupdtpatcher
	
