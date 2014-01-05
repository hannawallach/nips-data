# DO NOT UNCOMMENT THE FOLLOWING LINES: Gal Chechik's NIPS data is
# incorrect. (See README for more details.)
#
# create MATLAB startup file
#
#startup.m:
#	echo "path('scripts', path);" > $@
#
# download Gal Chechik's NIPS data
#
#data/nips_1-17.mat:
#	mkdir -p data; \
#	wget http://ai.stanford.edu/~gal/Data/NIPS/nips_1-17.mat -O $@
#
# convert Gal's data to plain text
#
#data/docs: startup.m data/nips_1-17.mat
#	matlab -nodesktop -nosplash -r convert_docs;


# the following file does not contain text: 2002/CS09

data/docs: data/raw
	cp -aR $< $@; \
	for y in `ls $@`; do \
	  for file in `ls $@/$$y`; do \
	    cat $@/$$y/$$file \
	    | scripts/cleanup.pl \
	    > $@/$$y/tmp; \
	    mv $@/$$y/tmp $@/$$y/$$file; \
	  done; \
	done; \
	for y in `seq 2000 2003`; do \
	  for file in `ls $@/$$y`; do \
	    cat $@/$$y/$$file \
	    | scripts/fix_gal_ligatures.pl \
	    > $@/$$y/tmp; \
	    mv $@/$$y/tmp $@/$$y/$$file; \
	  done; \
	done; \
	rm $@/2002/CS09.txt

data/nips2004_pdf.tgz:
	mkdir -p data; \
	wget http://books.nips.cc/papers/files/nips17/nips2004_pdf.tgz -O $@

data/nips2004_pdf: data/nips2004_pdf.tgz
	tar zxf $< -C data; \
	mv $@ data/tmp; \
	mkdir -p $@; \
	mv data/tmp/* $@; \
	rmdir data/tmp

# the following file does not contain text: 0598

data/docs/2004: data/nips2004_pdf
	mkdir -p $@; \
	for file in `ls $</files/*.pdf`; do \
	  new=`basename $$file | awk 'BEGIN { FS = "_" }; { print $$2 }'`; \
	  cp $$file $@/$$new; \
	done; \
	rm $@/index.pdf $@/toc.pdf; \
	for file in `ls $@/*.pdf`; do \
	  new=$${file%.pdf}.txt; \
	  pdftotext $$file $$new; \
	  cat $$new \
	  | scripts/non_utf8_strip_ligatures.pl \
	  | scripts/cleanup.pl \
	  > $@/tmp; \
	  mv $@/tmp $$new; \
	  rm $$file; \
	done; \
	rm $@/0598.txt

# get the raw NIPS data for 2005

data/nips2005_pdf.tgz:
	mkdir -p data; \
	wget http://books.nips.cc/papers/files/nips18/nips2005_pdf.tgz -O $@

data/nips2005_pdf: data/nips2005_pdf.tgz
	mkdir -p $@; \
	tar zxf $< -C $@

# note that one file gives the following error:
# Error: PDF version 1.6 -- xpdf supports version 1.5 (continuing anyway)
# I don't know which file this is

# the following files do not contain text: 0081.txt 0176.txt

data/docs/2005: data/nips2005_pdf
	mkdir -p $@; \
	for file in `ls $</files/*.pdf`; do \
	  new=`basename $$file | awk 'BEGIN { FS = "_" }; { print $$2 }'`; \
	  cp $$file $@/$$new; \
	done; \
	for file in `ls $@/*.pdf`; do \
	  new=$${file%.pdf}.txt; \
	  pdftotext $$file $$new; \
	  cat $$new \
	  | scripts/non_utf8_strip_ligatures.pl \
	  | scripts/cleanup.pl \
	  > $@/tmp; \
	  mv $@/tmp $$new; \
	  rm $$file; \
	done; \
	rm $@/0081.txt $@/0176.txt

# get the raw NIPS data for 2006

data/nips2006_pdf.tgz:
	mkdir -p data; \
	wget http://books.nips.cc/papers/files/nips19/nips2006_pdf.tgz -O $@

data/nips2006_pdf: data/nips2006_pdf.tgz
	mkdir -p $@; \
	tar zxf $< -C $@

# the following file does not contain text: 0688.txt

data/docs/2006: data/nips2006_pdf
	mkdir -p $@; \
	for file in `ls $</files/*.pdf`; do \
	  new=`basename $$file | awk 'BEGIN { FS = "_" }; { print $$2 }'`; \
	  cp $$file $@/$$new; \
	done; \
	for file in `ls $@/*.pdf`; do \
	  new=$${file%.pdf}.txt; \
	  pdftotext $$file $$new; \
	  cat $$new \
	  | scripts/non_utf8_strip_ligatures.pl \
	  | scripts/cleanup.pl \
	  > $@/tmp; \
	  mv $@/tmp $$new; \
	  rm $$file; \
	done; \
	rm $@/0688.txt

# construct stop word list

data/stopwordlist.txt: data/docs data/docs/2004 data/docs/2005 data/docs/2006
	cp data/default_stopwordlist.txt $@; \
	for y in `ls $<`; do \
	  for file in `ls $</$$y`; do \
	    scripts/generate_killwords.py data/docs/$$y/$$file $@; \
	    sort $@ | uniq > tmp; \
	    mv tmp $@; \
	  done; \
	done
