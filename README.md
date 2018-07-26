# CIDA_OMICs
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
### Google Cloud Computing  (GCP)
1. Find [my handbook](https://github.com/Guannan-Shen/Tutorial/tree/R/Google_Cloud)
2. SFTP via FileZilla to get files from the sever, similar with `mv` file to somewhere, to the local hard drive `D:/01_CIDA/Training/my1stproj/`.
3. Files (**For differential expression analysis**):  
  * `countSummary.txt`in `~/my1stproj/bucket/rawReads/` for summary table
  * `trimmedSummary.txt` in `~/my1stproj/bucket/trimmedReads/` for summary table 
  * `*fastqc.html` in `~/my1stproj/bucket/trimmedReads/` for quick raw data quality evaluation
  * `*.rsem.out` in `~/my1stproj/bucket/quantitation/rsem_hg38/` to make `alignmentSummary.txt` using the [alignmentSum.sh](https://github.com/Guannan-Shen/Tutorial/blob/R/Linux_Bash/alignmentSum.sh)
  * `alignmentSummary.txt` in `~/my1stproj/bucket/quantitation/rsem_hg38/` for summary table 
  * `*.genes.results` in `~/my1stproj/bucket/quantitation/rsem_hg38/` for expected count matrix, you also need `sampleList` to get the **sampleID vector** (such as N29, N47, T245DG), get the output saved as `cnts.RData` by Rstudio. 
  * `Ensembl.humanGenes.GRCh38.p7.txt` in **Ensembl**
