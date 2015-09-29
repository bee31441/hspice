setwd("C:/Users/timer/Documents/GitHub/hspice/pwmADC/code")
input <- read.table("../OTA/output.txt", header = T, sep = "")
xval <- as.numeric(input[,1])
L <- length(input[,1])
m <- matrix(nrow = L, ncol = 1)

for (i in 1:L){
    m[i,1] = (as.numeric(input[i + 1, 2]) - as.numeric(input[i, 2]))/(as.numeric(input[i + 1, 1]) - as.numeric(input[i, 1]))
}
# Fig2 <- plot(xval, (as.numeric(input[,3])/100000))
Fig <- plot( xval, m[,1], type = "b", xlab = "vdiff", ylab = "Iout_derivative")
