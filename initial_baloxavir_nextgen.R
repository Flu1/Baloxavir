initial_baloxavir_nextgen=function()
#This is the initial bit
#Download the 
#You will need a list of file names with R1 and R2 next to each other in the list. This code assumes that you are in a working directory where you can do this.
#You will need to download FLASH- https://ccb.jhu.edu/software/FLASH/- and replace INSERT YOUR PATH TO FLASH HERE with the path to FLASH.
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("QuasR")
library(QuasR)
filez=list.files(pattern="fastq")
for (fn in seq(1,length(filez),2))
  {
    file_name=strsplit(filez[fn],"_")[[1]][1]
    preprocessReads(filez[fn],paste(file_name,"_R1.fastq.gz",sep=""),filez[fn+1],paste(file_name,"_R2.fastq.gz",sep=""),minLength = 140,nBases=0)
    syscom=paste("INSERT YOUR PATH TO FLASH HERE",file_name,"_R1.fastq.gz ",file_name,"_R2.fastq.gz ","-m 30 -M 190 -o ",file_name,sep="")
    system(syscom) #Downloaded flash to pair sequences
    preprocessReads(paste(file_name,".extendedFrags.fastq",sep=""),paste(file_name,".fastq",sep=""),minLength=220,nBases=0)
  }
  
#You will now need to map the reads. We mapped the reads using Geneious and the map to Reference function.  The reference sequence is PA Baloxavir Ref.
#The alignment was then exported as .fasta file.

