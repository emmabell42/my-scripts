# This script compares two sets of checksums.
# If it finds the checksums identical it will return "Checksums identical."
# If it find the checksums non-identical it will return the names of the files
# which differ.

# The two sets of checksums must be in tabular format. They must have a 
# column called "sample" giving the sample name and a column called "chk"
# giving the checksum.

#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)

# Test that two arguments were given: if not, return an error
if (!length(args)==2) {
  stop("You did not supply two sets of checksums.", call.=FALSE)
} 

chk1 <- read.table(file = args[1], sep = " ", stringsAsFactors = FALSE)
chk2 <- read.table(file = args[2], sep = " ", stringsAsFactors = FALSE)

if (!"chk" %in% colnames(chk1) & "chk" %in% colnames(chk2)) {
  stop("One or both of your checksum tables do not contain a column called 'chk'.", call.=FALSE)
} 
if (!"sample" %in% colnames(chk1) & "sample" %in% colnames(chk2)) {
  stop("One or both of your checksum tables do not contain a column called 'sample'.", call.=FALSE)
} 

if(!identical(chk1$sample,chk2$sample)){
  chk1 <- chk1[order(chk1$sample),]
  chk2 <- chk2[order(chk2$sample),]
}

if (!identical(chk1$sample,chk2$sample)) {
  stop("Your checksum tables contain different sample names.", call.=FALSE)
} 

if(identical(chk1$chk,chk2$chk)){
  stop("Your checksums are identical.", call.=FALSE)
} else {
  cat("Your checksums are non-identical for the following sample(s):","\n")
  for(i in 1:nrow(chk1)){
    chk.1 <- chk1[i,]
    chk.2 <- chk2[i,]
    if(!identical(chk.1$chk,chk.2$chk)){
      cat(chk.1$sample,"\n")
    }
  }
}
