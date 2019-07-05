bamToCov <- function(bamFiles, normalise = FALSE) {
  cov.name <- sapply(bamFiles, function(x) gsub(".bed",".cov", tail(strsplit(x,"/")[[1]], n = 1)))
  cat("Reading ",bamFiles,"at",as.character(Sys.time()),"\n",sep=" ")
  tmp <- readGAlignments(bamFiles, param=ScanBamParam(what="qname"))
  cat("Coverting",bamFiles,"to GRanges and Coverage object at",as.character(Sys.time()),"\n",sep=" ")
  tmp.ranges <- as(tmp, "GRanges")
  tmp.cov <- coverage(tmp.ranges)
  if(normalise) {
    cat("Normalising",bamFiles,"to sequencing depth at",as.character(Sys.time()),"\n",sep=" ")
    nReads <- length(tmp.ranges)
    normFactor <- 10^6/nReads
    normCoverage <- tmp.cov*normFactor
    normCoverage
  } else {
    tmp.cov
  }
}
