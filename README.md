# CIDA_OMICs, RNAseq for DE analysis (differential expression analysis)
## Description
Generally, the RNAseq data analysis (differential expression analysis) via google cloud computing and R.  
For a simple standard pipeline, using standard RNAseq data for a differential expression analysis (DE analysis). 
## Background
### The RNAseq data
 .fastq.gz (compressed) files like you would get from an illumina sequencing machine  
**FASTQ format** [wiki](https://en.wikipedia.org/wiki/FASTQ_format)  
A FASTQ file normally uses four lines per sequence.
1. 1st line begins with a '@' character and is followed by a sequence identifier and an optional description (like a FASTA title line).
2. 2nd line is the raw sequence letters.
3. 3rd line begins with a '+' character and is optionally followed by the same sequence identifier (and any description) again.
4. 4th line encodes the quality values for the sequence in Line 2, and must contain the same number of symbols as letters in the sequence.
### Statistics and Algo
1. [Poisson GLM](https://github.com/Guannan-Shen/CIDA_OMICs/blob/master/Poisson%20GLM.md)
### Programs
gzip cutadapt fastqc samtools bowtie2 hisat2 rsem (this comes with a few programs) R Python

### Packages 
#### cutadapt
Cutadapt finds and removes adapter sequences, primers, poly-A tails and other types of unwanted sequence from your high-throughput sequencing reads.
  
    pip install --user --upgrade cutadapt
or 
    
    conda install -c bioconda cutadapt
#### DESeq2 and RUVSeq for differential expression analysis (DE analysis)
Install from [biocLite](https://github.com/Guannan-Shen/CIDA_OMICs/blob/master/RNAseq_DEanalysis.Rmd)
### Google Cloud Computing  (GCP)
1. Find [my handbook](https://github.com/Guannan-Shen/Tutorial/tree/R/Google_Cloud)
2. SFTP via FileZilla to get files from the sever, similar with `mv` file to somewhere, to the local hard drive `D:/01_CIDA/Training/my1stproj/`.
3. Command Line to copy files from the Google Cloud
  * from a terminal on your local machine cd into the directory where you hace the gc_rsa ssh key `cd ~/.ssh`
  * `chmod 400 gc_rsa`
  * `scp -i gc_rsa sheng@104.198.109.11:~/my1stproj/bucket/quantitation/rsem_hg38/*.genes.results  D:/01_CIDA/Training/my1stproj/genes_results/` [scp command reference](https://www.garron.me/en/articles/scp.html)
4. Files (**For differential expression analysis**):  
  * `countSummary.txt`in `~/my1stproj/bucket/rawReads/` for summary table
  * `trimmedSummary.txt` in `~/my1stproj/bucket/trimmedReads/` for summary table 
  * `*fastqc.html` in `~/my1stproj/bucket/trimmedReads/` for quick raw data quality evaluation
  * `*.rsem.out` in `~/my1stproj/bucket/quantitation/rsem_hg38/` to make `alignmentSummary.txt` using the [alignmentSum.sh](https://github.com/Guannan-Shen/Tutorial/blob/R/Linux_Bash/alignmentSum.sh) (run the bash code under the folder which you want to put the alignmentSummary.txt in)
  * `alignmentSummary.txt` in `~/my1stproj/bucket/quantitation/rsem_hg38/` for summary table
  * `*.genes.results` in `~/my1stproj/bucket/quantitation/rsem_hg38/` for expected count matrix, you also need `sampleList` to get the **sampleID vector** (such as N29, N47, T245DG), get the output saved as `cnts.RData` by Rstudio. 
  * `Ensembl.humanGenes.GRCh38.p12.txt` downloaded from **[Ensembl Biomart](http://uswest.ensembl.org/biomart/martview/e2d9a3812e652144df2bde5ec222c02b)**
    * Select "Ensembl Genes 93".
    * Select "Human Genes".
    * Select attributes (it depends on the context), might include: gene stable ID, transcript stable ID, gene description, chromosome/scaffold name, Gene start, Gene end, strand, Transcript start, Transcript end, Gene name, Transcript name, Gene type and Transcript name. 
    * Select "results" tab and download TSV using "go" tab.
## DE analysis
1. Normalization by R in [Rmarkdown](https://github.com/Guannan-Shen/CIDA_OMICs/blob/master/testproj_NDGSG.Rmd)
2. [DESeq2 tutorials](https://github.com/Guannan-Shen/CIDA_OMICs/blob/master/DESeq2_tutorial.Rmd)  
You need, in R:
    
        source("https://bioconductor.org/biocLite.R")  
        biocLite("airway")
