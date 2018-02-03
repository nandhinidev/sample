source("functions.R")
#Read User Input
{comp <- read.table("input.txt",sep="\t",header=FALSE)
comp <- data.frame(comp)
colnames(comp) <- c("carbon","hydrogen","nitrogen","niso")
carbon=as.integer(comp$carbon)
if(carbon <= 0){
  stop('Number of carbon atoms must be greater than zero')
} 
hydrogen=as.integer(comp$hydrogen)
if(hydrogen <= 0){
  stop('Number of hydrogen atoms must be greater than zero')
} 
nitrogen=as.integer(comp$nitrogen)
niso=comp$niso

# Isotopic envelope
isogrid = envelope(niso)
abund = pred.int(isogrid,niso)
RA <- abund/max(abund)*100
final <- cbind(seq(0,niso),abund,RA)
colnames(final) <- c("#Isotope","Intensity","RA")
write.table(final,file="output.txt",sep="\t",quote=FALSE,col.names=TRUE,row.names=FALSE)}


