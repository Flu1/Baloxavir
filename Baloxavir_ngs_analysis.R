Baloxavir_ngs_analysis=function(filenames)
{
  #This code was written to analyse samples for Baloxavir treatment of ferrets infected with influenza A(H1N1)pdm09 virus reduces onward transmission.
  #Please see the readme for more information.
  #Please enter a list of file names for analysis.
  #Output is the amino acid at position 38.
  
  #########
  if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
  
  BiocManager::install("ShortRead")
  library(ShortRead)

  #Start here
  print(paste("There are",length(filenames),"files",sep=" "))
  result_things=array(dim=c(3,4,length(filenames)))
  for(file_number in 1:length(filenames))
  { 
    print(paste("Reading in",strsplit(filenames[file_number],split="[.]")[[1]][1],"- File number",file_number,sep=" "))
    dataf=readDNAStringSet(filenames[file_number])
    
    #Remove Sequences with N
    oldlength=(length(dataf))
    dataf=dataf[c(1,which(vcountPattern("N",dataf)==0)),]
    #print(paste("Removed",oldlength-length(dataf),"sequences wih Ns",sep=" "))
    datam=as.matrix(dataf)
    
    #Find the gaps in the reference
    gap_counter=cumsum(datam[1,]=="-")
    
    key_locations=c(113,240,245) #Where the sites of interest are
    s=key_locations*0-1
    for(a in 1:length(key_locations))
    {
      s[a]=which(datam[1,]!="-")[key_locations[a]] #A better way for finding the start and finish of the amplicon.
    }
   # print("Found these key locations")
   # print(s)
    if(-1%in%s)
    {
      print("Not found one of the key locations.  Will crash soon.  Sorry")
    }
    
    #Find which bases are at the key spots.
    key_results=array(0,dim=c(length(dataf),2))
    for(a in 2:length(dataf))
    {
      key_results[a,1]=datam[a,s[1]] #I or T
      key_results[a,2]=paste(datam[a,s[2]:s[3]],collapse="") #I or T
    }
    barcodes=c("GCGTTA", "TAGAGC", "AGCCAT", "CAATCG")
    rnames <- c("38 I", "38 T", "Total")
    cnames <- c("GCGTTA - 1", "TAGAGC - 2", "AGCCAT - 3", "CAATCG - 4")
    results=matrix(nrow=3,ncol=4,dimnames=list(rnames, cnames))
    for(a in 1:length(barcodes))
    {
      temp=which(key_results[,2]==barcodes[a])
      if(length(temp)>0)
      {
        results[3,a]=length(temp)
        results[1,a]=length(which(key_results[temp,1]=="T"))
        results[2,a]=length(which(key_results[temp,1]=="C"))
      }
    }
    print(results)
    result_things[,,file_number]=results
  }
return(result_things)
}