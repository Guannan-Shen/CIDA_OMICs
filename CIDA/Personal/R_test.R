library(knitr)
library(kableExtra)
library(pander)
setwd("D:/01_CIDA/Training/my1stproj")
## count summary txt
projectFolder <- paste(getwd(), "/", sep = '')
rawCounts = read.table(file=paste(projectFolder,"countSummary.txt",sep=""),sep=" ",header=FALSE,fill=TRUE)

rawCounts$readFrag = as.numeric(rawCounts$V3)
rawCounts$file = sapply(strsplit(rawCounts$V1,split="/",fixed=TRUE),function(a) a[length(a)])
rawCounts$sample = sapply(strsplit(rawCounts$file,split="_",fixed=TRUE),function(a) paste(a[1], "_", a[2], sep = ""))
rawCounts$sample = sapply(strsplit(rawCounts$file,split=".",fixed=TRUE),function(a) a[1])
rawCounts

## aggregate by sample and get the sum of rawCounts 
readFragments = aggregate(rawCounts$readFrag,by=list(sample=rawCounts$sample),sum)

#forCSV <- forPrint
#forCSV$`Number of Read Fragments` <- readFragments$x
#write.csv(forCSV, file = "/Volumes/smiharry/CBC/P1218Fontenot/data/rawReadCounts-P1218Fontenot.csv", row.names = FALSE, quote = FALSE)
#readFragments$numPairedReads = prettyNum(readFragments$x/2,big.mark=",",scientific=FALSE)
readFragments$numReadFragments = prettyNum(readFragments$x,big.mark=",",scientific=FALSE)
readFragments=readFragments[,colnames(readFragments)!="x"]

forPrint = readFragments[,c("sample","numReadFragments")]
colnames(forPrint) = c("sample","Number of Read Fragments")
forPrint


### test the aggregate function 
values <- data.frame(value = c("a", "a", "a", "a", "a", 
                               "b", "b", "b", 
                               "c", "c", "c", "c"))
nr.of.appearances <- aggregate(x = values, 
                               by = list(unique.values = values$value), 
                               FUN = length)
nr.of.appearances

## using trimmed summary txt 
trimmed = read.table(file=paste(projectFolder,"trimmedSummary.txt",sep=""),sep="",header=FALSE)
trimmed
