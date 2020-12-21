clean:
	rm public_html/*.html

# Must be connected to LDEO VPN for these ftp commands to work.

# This just logs me in.  Then the commands are:
# rm /home/shill/public_html/*.html
# rm /home/shill/public_html/css/*
# rm /home/shill/public_html/cv/*
# rm /home/shill/public_html/images/*
# rm /home/shill/public_html/papers/*
cleanremote:
	ncftp -u shill ftp.ldeo.columbia.edu

push:
	ncftpput -u shill -R ftp.ldeo.columbia.edu /home/shill/ public_html

.phony: clean push cleanremote
