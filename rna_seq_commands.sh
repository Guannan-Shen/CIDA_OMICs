# this is a list of commands useful in RNAseq pipeline
# the following is shebang
#!/bin/sh
more [file_name]  # to view file
more ~/.bashrc    ## the startup file 

## text editor 

nano 

nano ~/.bashrc   # edit the startup file

# using ctrl + z to quit the more 

gunzip [file_name] # unzip one file, it takes time for large .fastq.gz file

gzip [file_name]  # compress the file, compress the .fastq

gunzip -c [filename] | head           ## to quick review the head of compressed file 

## cp copy file from one dir to another dir

## set path to python 3.5

## view all current running process
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






