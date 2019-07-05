# This script summarises FastQC results as a heatmap.
#
# It performs the following tasks:
#   - Search for looks for fastqc zip folders in the present working directory;
#   - Reads in the summary.txt files contained within those zipped folders;
#   - Compiles a table where the rows are FastQC tests, the columns are the 
#     names of fastq files, and the cells detail whether the file received a 
#     pass, warn, or fail for that test;
#   - Visualises that table as a heatmap which it outputs to the present working
#     directory.
#
# To run this script, you will need the following packages installed:
#   - tidyverse;
#   - RColorBrewer;
#   - pheatmap.
#
require(tidyverse)
require(pheatmap)
require(RColorBrewer)
fastqcs <- list.files(pattern = "_fastqc.zip")
fastqcs <- gsub(pattern = ".zip", replacement = "", x = fastqcs)
fastqcs
summaries <- lapply(X = fastqcs, function(X){
  this.fastqc <- X
  this.zip <- paste0(this.fastqc, ".zip")
  read.table(file = unz(this.zip, file.path(this.fastqc,"summary.txt")), header = FALSE, sep = "\t", col.names = c("Status", "Test", "File"), stringsAsFactors = FALSE)
})
names(summaries) <- fastqcs
summary.table <- array(data = NA, dim = c(nrow(summaries[[1]]),length(fastqcs)))
colnames(summary.table) <- fastqcs
rownames(summary.table) <- summaries[[1]]$Test
for(i in 1:ncol(summary.table)){
  this.summary <- factor(x = summaries[[i]]$Status, levels = c("PASS","WARN","FAIL"))
  summary.table[,i] <- as.numeric(this.summary)
}
legend.col <- rev(brewer.pal(n = 3, name = "PuOr"))
png.name <- "FastQC_summary.png"
png(filename = png.name)
pheatmap(mat = summary.table, cluster_rows = FALSE, cluster_cols = FALSE, color = legend.col, legend_breaks = c(1,3), legend_labels = c("Pass","Fail"), border_color = "black")
dev.off()