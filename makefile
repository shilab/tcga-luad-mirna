all: Data setup

setup:
	mkdir -p results
	mkdir -p code

Code: code/rename.py

code/rename.py:
	wget -P ./code -nd --no-check-certificate https://raw.githubusercontent.com/shilab/tcga_tools/8ad6911e137597ecdfec2d40b75b5b7546d4a4cb/rename.py

code/ExpressionMatrix.py:
	wget -P ./code -nd --no-check-certificate https://raw.githubusercontent.com/shilab/tcga_tools/8ad6911e137597ecdfec2d40b75b5b7546d4a4cb/ExpressionMatrix.py

code/miRMatrix.py:
	wget -P ./code -nd --no-check-certificate https://raw.githubusercontent.com/shilab/tcga_tools/8ad6911e137597ecdfec2d40b75b5b7546d4a4cb/miRMatrix.py

Data: data/Clinical data/RNASeq/rename data/miRNASeq data/RNAMatrix data/miRNAMatrix

data/RNAMatrix: data/RNASeq/rename code/ExpressionMatrix.py
	python code/ExpressionMatrix.py 'data/RNASeq/rename/*' > data/RNAMatrix

data/miRNAMatrix: data/miRNASeq code/miRMatrix.py
	python code/miRMatrix.py 'data/miRNASeq/miRNAHiSeq/*mirna.quantification.txt' > data/miRNAMatrix

data/Clinical:
	mkdir -p data/Clinical
	wget https://tcga-data.nci.nih.gov/tcgafiles/ftp_auth/distro_ftpusers/anonymous/tumor/luad/bcr/nationwidechildrens.org/bio/clin/nationwidechildrens.org_LUAD.bio.Level_2.0.28.0.tar.gz
	tar -xzvf nationwidechildrens.org_LUAD.bio.Level_2.0.28.0.tar.gz
	rm nationwidechildrens.org_LUAD.bio.Level_2.0.28.0.tar.gz
	mv nationwidechildrens.org_LUAD.bio.Level_2.0.28.0/* data/Clinical/
	rm -r nationwidechildrens.org_LUAD.bio.Level_2.0.28.0

data/RNASeq:
	mkdir -p data/RNASeq
	wget -P ./data https://tcga-data.nci.nih.gov/tcgafiles/ftp_auth/distro_ftpusers/anonymous/tumor/luad/cgcc/unc.edu/illuminahiseq_rnaseqv2/rnaseqv2/unc.edu_LUAD.IlluminaHiSeq_RNASeqV2.Level_3.1.14.0.tar.gz
	tar -xzvf data/unc.edu_LUAD.IlluminaHiSeq_RNASeqV2.Level_3.1.14.0.tar.gz -C data/RNASeq
	mv data/RNASeq/unc.edu_LUAD.IlluminaHiSeq_RNASeqV2.Level_3.1.14.0/* data/RNASeq/
	rm -r data/RNASeq/unc.edu_LUAD.IlluminaHiSeq_RNASeqV2.Level_3.1.14.0
	rm data/unc.edu_LUAD.IlluminaHiSeq_RNASeqV2.Level_3.1.14.0.tar.gz
	rm data/RNASeq/*.rsem.genes.results
	rm data/RNASeq/*.rsem.isoforms.results
	rm data/RNASeq/*.rsem.isoforms.normalized_results
	rm data/RNASeq/*.bt.exon_quantification.txt
	rm data/RNASeq/*.junction_quantification.txt

data/RNASeq/rename: data/RNASeq code/rename.py
	mkdir -p data/RNASeq/rename
	python code/rename.py data/Clinical/nationwidechildrens.org_biospecimen_aliquot_luad.txt $$PWD/data/RNASeq/ $$PWD/data/RNASeq/rename/

data/miRNASeq:
	mkdir -p data/miRNASeq
	wget -P ./data https://tcga-data.nci.nih.gov/tcgafiles/ftp_auth/distro_ftpusers/anonymous/tumor/luad/cgcc/bcgsc.ca/illuminaga_mirnaseq/mirnaseq/bcgsc.ca_LUAD.IlluminaGA_miRNASeq.Level_3.1.4.0.tar.gz
	wget -P ./data https://tcga-data.nci.nih.gov/tcgafiles/ftp_auth/distro_ftpusers/anonymous/tumor/luad/cgcc/bcgsc.ca/illuminahiseq_mirnaseq/mirnaseq/bcgsc.ca_LUAD.IlluminaHiSeq_miRNASeq.Level_3.1.12.0.tar.gz
	tar -xzvf data/bcgsc.ca_LUAD.IlluminaHiSeq_miRNASeq.Level_3.1.12.0.tar.gz -C data/miRNASeq
	rm data/bcgsc.ca_LUAD.IlluminaHiSeq_miRNASeq.Level_3.1.12.0.tar.gz
	tar -xzvf data/bcgsc.ca_LUAD.IlluminaGA_miRNASeq.Level_3.1.4.0.tar.gz -C data/miRNASeq
	rm data/bcgsc.ca_LUAD.IlluminaGA_miRNASeq.Level_3.1.4.0.tar.gz
	mkdir -p data/miRNASeq/miRNAGa
	mkdir -p data/miRNASeq/miRNAHiSeq
	mv data/miRNASeq/bcgsc.ca_LUAD.IlluminaGA_miRNASeq.Level_3.1.4.0/* data/miRNASeq/miRNAGa
	mv data/miRNASeq/bcgsc.ca_LUAD.IlluminaHiSeq_miRNASeq.Level_3.1.12.0/* data/miRNASeq/miRNAHiSeq/
	rm -r data/miRNASeq/bcgsc.ca_LUAD.IlluminaGA_miRNASeq.Level_3.1.4.0
	rm -r data/miRNASeq/bcgsc.ca_LUAD.IlluminaHiSeq_miRNASeq.Level_3.1.12.0
