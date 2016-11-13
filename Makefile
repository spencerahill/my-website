CVPATH="$HOME/Dropbox/cv"

cv:
	emacs $(CVPATH) --batch \
	--eval="(org-latex-export-to-pdf)" --kill

html: cv
	emacs org/index.org --batch \
	--eval="(org-publish-project \"website\")" --kill

org:
	cp org/*.org pub/org

push: org
	scp -r pub/* shill@boreas.atmos.ucla.edu:/Users/shill/website
	ssh shill@boreas.atmos.ucla.edu
	scp -r pub/* shill@erato.atmos.ucla.edu:/data/people/shill
	exit

all: cv html org push

clean:
	rm pub/org/*
	rm pub/*.html

.PHONY: cv html org push
