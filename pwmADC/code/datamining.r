setwd("~/GitHub/hspice/pwmADC/code")
input <- read.table("newcreation.txt", sep = "=")
plot <- plot( 1:length(input[,2]),input[, 2], type = "b")
