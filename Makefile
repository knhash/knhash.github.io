# Build the resume PDFs and assemble the deployable site in build/site.
#   make resume   build 4 PDFs into build/pdf
#   make site     resume + static files + redirect stubs -> build/site
#   make clean
VARIANTS := recsys platform hpc
PDFDIR   := build/pdf
SITE     := build/site

.PHONY: all resume site clean
all: site

resume:
	mkdir -p $(PDFDIR)
	cd resume && latexmk -C && latexmk -pdf -interaction=nonstopmode -outdir=../$(PDFDIR) ShashankResume.tex
	cd resume && for V in $(VARIANTS); do \
	  for pass in 1 2; do \
	    pdflatex -interaction=nonstopmode -output-directory=../$(PDFDIR) -jobname=ShashankResume-$$V "\\def\\VARIANT{$$V}\\input{ShashankResume.tex}" >/dev/null || exit 1; \
	  done; \
	done

site: resume
	rm -rf $(SITE) && mkdir -p $(SITE)/files
	cp -R files media logos keybase.txt robots.txt $(SITE)/
	cp -R static/. $(SITE)/
	for f in ShashankResume ShashankResume-recsys ShashankResume-platform ShashankResume-hpc; do \
	  cp $(PDFDIR)/$$f.pdf $(SITE)/files/$$f.pdf; done
	cp $(PDFDIR)/ShashankResume.pdf $(SITE)/resume.pdf
	for V in $(VARIANTS); do cp $(PDFDIR)/ShashankResume-$$V.pdf $(SITE)/resume-$$V.pdf; done
	python3 scripts/gen-redirects.py $(SITE)

clean:
	rm -rf build
	cd resume && latexmk -C 2>/dev/null || true
