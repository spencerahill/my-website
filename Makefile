CVPATH="$HOME/Dropbox/cv"

gen-cv:
	emacs $(CVPATH) --batch \
	--eval="(org-latex-export-to-pdf)" --kill

gen-html: cv
	emacs org/index.org --batch \
	--eval="(org-publish-project \"website\")" --kill

gen:
	gen-cv gen-html

cp-html:
	cp *.html pub/

cp-cv:
	cp cv/cv.pdf pub/cv

css:
	cp css/*.css pub/css

images:
	cp images/* pub/images

org:
	cp org/*.org pub/org

papers:
	cp papers/*.pdf pub/papers

pres:
	cp pres/*.pdf pub/pres

copy: cp-html cp-cv css images org papers pres

push: org
	scp -r pub/* shill@boreas.atmos.ucla.edu:/Users/shill/website
	ssh shill@boreas.atmos.ucla.edu
	scp -r pub/* shill@erato.atmos.ucla.edu:/data/people/shill
	exit

all: gen copy push

clean:
	rm pub/*

.PHONY: gen-cv gen-html gen cp-cv cp-html css images org papers pres copy push all clean
