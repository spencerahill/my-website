THISDIR="${PWD}"
CVPATH="${HOME}/Dropbox/cv"

# TODO: Fix this.  Resulting PDF is blank.
gen-cv:
	cd $(CVPATH)
	emacs \
	-u "$(id -un)" \
	    --batch \
	    --eval '(load user-init-file)' \
	    cv.org \
	    -f org-latex-export-to-pdf \
	    --kill
	cd $(THISDIR)
	cp cv.pdf cv/cv.pdf
	mv cv.{bbl,tex,pdf} $(CVPATH)

# TODO: Verify that this works.
gen-html:
	emacs \
	    -u "$(id -un)" \
	    --batch \
	    --eval '(load user-init-file)' \
	    org/index.org \
	    -f org-publish-current-project \
	    -kill

push:
	# Relies on the 'erato' and 'aeolus' profiles in my .ssh/config.
	# Must be connected to the AOS VPN for this to work.
	scp -r pub/* erato:/data/people/shill

all: gen-cv gen-html push

clean:
	rm pub/*

.PHONY: gen-cv gen-html push all clean
