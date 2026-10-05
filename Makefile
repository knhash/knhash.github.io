# make resume   build the 4 resume PDFs into build/pdf
# make site     build three deployable folders:
#   build/files   -> files.knhash.in  (PDFs, flat)
#   build/media   -> media.knhash.in  (images)
#   build/legacy  -> knhash.github.io (old /files, /media paths + redirect stubs)
VARIANTS := recsys platform hpc
PDFDIR   := build/pdf

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
	rm -rf build/files build/media build/legacy
	mkdir -p build/files build/media build/legacy/files
	# files.knhash.in
	cp files/*.pdf build/files/
	cp $(PDFDIR)/ShashankResume*.pdf build/files/
	cp build/files/ShashankResume.pdf build/files/resume.pdf
	for V in $(VARIANTS); do cp build/files/ShashankResume-$$V.pdf build/files/resume-$$V.pdf; done
	cp static/files/_headers static/files/_redirects build/files/
	# media.knhash.in
	cp -R media/. build/media/
	cp -R logos build/media/logos
	cp static/media/_headers build/media/
	# knhash.github.io (legacy paths keep working, always latest)
	cp -R build/files/*.pdf build/legacy/files/
	cp -R media logos keybase.txt robots.txt build/legacy/
	cp build/files/resume*.pdf build/legacy/
	# oldest layout: /assets/*.pdf and /assets/resume.pdf
	mkdir -p build/legacy/assets && cp build/legacy/files/*.pdf build/legacy/assets/ && cp build/files/resume.pdf build/legacy/assets/resume.pdf
	cp static/legacy/assets/* build/legacy/assets/
	touch build/legacy/.nojekyll
	python3 scripts/gen-redirects.py build/legacy

clean:
	rm -rf build
	cd resume && latexmk -C 2>/dev/null || true
