readBeds <- function(bedFiles) {
 
  require(GenomicRanges)
  
  gr <- lapply(X = bedFiles, FUN = function(X){
    
    bed <- read.delim(file = X, head = FALSE, sep = "\t", stringsAsFactors = TRUE)
    colnames(bed)[1:3] <- c("chr","start","end")
    as(object = bed, Class = "GRanges")
  
  })

}