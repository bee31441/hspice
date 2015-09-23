setwd("~/GitHub/hspice/pwmADC/code")
input <- read.table("newcreation.txt", sep = "=", as.is = 4)
yval = log10(as.numeric(input[, 4]))
png("linearity_log")
plot <- plot( input[, 2],yval, type = "b")
dev.off
x11()
png("linearity")
plot <- plot( input[, 2],input[, 4], type = "b")
dev.off