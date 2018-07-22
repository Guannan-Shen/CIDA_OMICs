# this is a list of commands useful in RNAseq pipeline
# the following is shebang
#!/bin/sh
more [file_name]  # to view file
more ~/.bashrc    ## the startup file 
less [file_name]  # to view large multi lines file 

## text editor 

nano 

nano ~/.bashrc   # edit the startup file

# using ctrl + z to quit the more 

gunzip [file_name] # unzip one file, it takes time for large .fastq.gz file

gzip [file_name]  # compress the file, compress the .fastq

gunzip -c [filename] | head           ## to quick review the head of compressed file 

## cp copy file from one dir to another dir

## set path to python 3.5

## view all computing power usage
htop

## for the test proj, trim
python trimBatch.py -c --cutadapt-q 20 --cutadapt-m 20 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -U -o /home/datasets/RNAseq/rawtest -i .fastq.gz /home/datasets/RNAseq/rawtest
## to execute python3 script
python3 trimBatch.py -c --cutadapt-q 20 --cutadapt-m 20 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -U -o /home/sheng/my1stproj/bucket/rawtest -i .fastq.gz /home/sheng/my1stproj/bucket/rawtest

## run the trim command in data file, saving trimmed.fastq.gz in trimmedReads
python3 /home/sheng/my1stproj/bucket/code/trimBatch.py -c --cutadapt-q 20 --cutadapt-m 20 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -U -o /home/sheng/my1stproj/bucket/trimmedReads -i .fastq.gz /home/sheng/my1stproj/bucket/rawtest

## in the trimmedReads directory
## cd into working directory
## .html reports with QC plot
cd trimmedReads

## run command
fastqc -t 3 *.fastq.gz

# run the summariseFastQC.py
python3 /home/sheng/my1stproj/bucket/code/summarizeFastQC.py 

## Redo
echo --------------------------------------------------------------------------------------------
echo redo everything 'for' the whole dataset
echo 'commands only for' remmote server, with proper system, software installed and data 'file mounted'
echo --------------------------------------------------------------------------------------------

## quick check data
## one file at a time
gunzip -c [filename] | head #the -c option write on standard output, keep original files unchanged

## get counts summary trim summary with .py and cutadapt
## check python3 --version
python3 --version

## data is in rawReads
python3 /home/sheng/my1stproj/bucket/code/trimBatch.py -c --cutadapt-q 20 --cutadapt-m 20 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -U -o /home/sheng/my1stproj/bucket/trimmedReads -i .fastq.gz /home/sheng/my1stproj/bucket/rawReads

## or using ~ instead of home
## download cutadapt 1.16 version with pip
python3 ~/my1stproj/bucket/code/trimBatch.py -c --cutadapt-q 20 --cutadapt-m 20 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -U -o ~/my1stproj/bucket/trimmedReads -i .fastq.gz ~/my1stproj/bucket/rawReads

##
echo ---------------------------------------------------
echo meanwhile, connect the server 'in' another terminal with 'cd' and 'ssh'
echo using 'htop' to monitor the server usage
echo '14' files take up to around '50 min'
echo ---------------------------------------------------

## after this get the FastQC plot to check the quality of the data 
## fastqc is required to be downloaded
cd ~/my1stproj/bucket/trimmedReads
fastqc -t 20 *.fastq.gz                    # -t option for thread, for this 100gb ram, 32cpu server 20 is fine 

#Make fastqc summary excel spread sheet. This will output a .csv called all_mod_scores.csv. 
#It is coded as 1 = PASS, 0 = WARNING and -1 = FAIL. You will need to add the column titles.
python3 ~/my1stproj/bucket/code/summarizeFastQC.py

## Prepare index files 
cd ~/my1stproj/bucket/index
mkdir hum_index
cd hum_index

## decompress genome file, the official human genome sequence
## UCSC Genome Browser (http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/)
## hg38.fa.gz
gunzip hg38.fa.gz  # this will delete the input file, -k is keep 


## insert blank line
sed '/>/{x;p;x}' ~/my1stproj/bucket/index/hum_index/hg38.fa > hg38.tmp.fa

#remove contig sequences
sed -i '/KI/,/^$/d' ~/my1stproj/bucket/index/hum_index/hg38.tmp.fa
sed -i '/GL/,/^$/d' ~/my1stproj/bucket/index/hum_index/hg38.tmp.fa
sed -i '/alt/,/^$/d' ~/my1stproj/bucket/index/hum_index/hg38.tmp.fa
sed '/^$/d' ~/my1stproj/bucket/index/hum_index/hg38.tmp.fa > ~/my1stproj/bucket/index/hum_index/hg38.cleaned.fa

## check to make sure this worked
awk '/^>chr/' hg38.cleaned.fa #should only get chr1-22, chrM, chrX, and chrY

#chromosome sizes
# try to get the hg38.chrom.sizes.txt from the website
awk '!/GL|KI|alt/' ~/my1stproj/bucket/index/hum_index/hg38.chrom.sizes.txt > ~/my1stproj/bucket/index/hum_index/hg38.cleaned.chrom.sizes

## the genome are prefared, hg38.cleaned.fa

## Load the transcriptome 
gunzip Homo_sapiens.GRCh38.93.gtf.gz
## prepare the clean .gtf/ transcriptome
## remove random contigs from gtf file - downloaded from Ensembl 
awk '$1 !~"GL"' ~/my1stproj/bucket/index/hum_index/Homo_sapiens.GRCh38.93.gtf | awk '$1 !~"KI"' - | awk '$1 !~"#"' - > ~/my1stproj/bucket/index/hum_index/Homo-sapiens.GRCh38.93.cleaned.gtf

## add 'chr' to chromosome names (to match UCSC genome sequence)
sed -i 's/^/chr/' ~/my1stproj/bucket/index/hum_index/Homo-sapiens.GRCh38.93.cleaned.gtf 

## make mitochondrial chromosome name match UCSC genome sequence
sed -ri 's/chrMT/chrM/g' ~/my1stproj/bucket/index/hum_index/Homo-sapiens.GRCh38.93.cleaned.gtf 

## check to make sure this worked. The chromosome names should matcht those from above
cut -c 1-5  Homo-sapiens.GRCh38.93.cleaned.gtf  | sort | uniq

## Prepare the reference genome and transcriptome
## prepare reference
## mkdir under index
mkdir ~/my1stproj/bucket/index/RSEM
rsem-prepare-reference --bowtie2 --gtf ~/my1stproj/bucket/index/hum_index/Homo-sapiens.GRCh38.93.cleaned.gtf ~/my1stproj/bucket/index/hum_index/hg38.cleaned.fa ~/my1stproj/bucket/index/RSEM/hg38.ensembl 

## it takes about 50 mins in our case, for about 14 raw dataset
## transfer files to local after this 

## Step 4b.
## RSEM. In this step the the call rsem-calculate-expression 
## will map reads to the reference tramscriptome, and quantify reads all in the same program.
## Using counts for downstream analysis
## using the folder quantitation
## the most time consuming step
mkdir ~/my1stproj/bucket/quantitation/rsem_hg38
cd ~/my1stproj/bucket/quantitation/rsem_hg38

##run rsem-calculate-expression
python3 ~/my1stproj/bucket/code/runRSEM_batch.py --rsem-time --rsem-seedLen 20 --rsem-seed 2110 --rsem-bowtie2 --rsem-noBam --rsem-fwProb 1.0 --unpaired -d _R -o ~/my1stproj/bucket/quantitation/rsem_hg38 -i trimmed.fastq.gz ~/my1stproj/bucket/trimmedReads ~/my1stproj/bucket/index/RSEM hg38.ensembl 16















