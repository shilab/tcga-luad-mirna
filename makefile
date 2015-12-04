all: Data setup

setup:
	mkdir -p results

Data: data/Clinical data/RNASeq data/miRNASeq

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
