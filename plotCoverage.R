plotCoverage <- function(cov,regions,precision=1000,normalize.widths=TRUE,standard.deviation=FALSE){
  
  trackVal <- rep(0, length = precision)
  if(!normalize.widths) 
    refMid <- ceiling(precision/2)
  theseSpaces <- intersect(as.character(unique(regions@seqnames)),names(cov))
  cat(paste("region set has",length(theseSpaces),"spaces \n"))
  
  chrCov <- lapply(X = theseSpaces, FUN = function(X) {
    cat(paste("\t calculating average coverage for",sum(regions@seqnames==X),"regions on space",X,"\n"))
    Views(cov[[X]],ranges(regions[regions@seqnames==X]))
  })
  
  meanCovByChr <- lapply(X = chrCov, FUN = function(X) {
    thisCov <- X
    numeric.cov <- lapply(X = thisCov, FUN = function(X) {
      num <- as.numeric(X)
      if(length(num)<precision){
        num <- rep(x = as.numeric(X), each = ceiling(precision/length(as.numeric(X))))
      }
      smooth.num <- ksmooth(x = 1:precision, y = num)$y
    })
    numeric.cov <- matrix(unlist(numeric.cov), ncol=precision,byrow = TRUE)
    mean.cov <- colMeans(numeric.cov, na.rm = TRUE)
    mean.cov[is.na(mean.cov)] <- 0
    trackVal + mean.cov
  })
  meanCovAllChr <- matrix(unlist(meanCovByChr), ncol=precision,byrow = TRUE)
  if(standard.deviation){
    meanCovAllChr <- apply(X = meanCovByChr, MARGIN = 2, FUN = function(X) mean(x = X, na.rm = TRUE))
    sdCovAllChr <- apply(X = meanCovByChr, MARGIN = 2, FUN = function(X) mean(x = X, na.rm = TRUE))
    rbind(mean=meanCovAllChr,sd=sdCovAllChr)
  } else {
    meanCovAllChr <- apply(X = meanCovByChr, MARGIN = 2, FUN = function(X) mean(x = X, na.rm = TRUE))
    meanCovAllChr
  }
}