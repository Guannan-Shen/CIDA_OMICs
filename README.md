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

### Programs
gzip cutadapt fastqc samtools bowtie2 hisat2 rsem (this comes with a few programs) R Python
