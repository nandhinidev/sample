# Functions to calculate the isotope distribution for each element

cdist <- function(carbon,ci)
{
  if (carbon >= ci)
  {
    return(dmultinom(c(carbon-ci,ci),carbon,c(0.9893,0.0107)))
  }
  else {return(0)}
}

hdist <- function(hydrogen,hi)
{
  if (hydrogen >= hi)
  {
    return(dmultinom(c(hydrogen-hi,hi),hydrogen,c(0.9998,0.00012)))
  }
  else {return(0)}
}

ndist <- function(nitrogen,ni)
{
  if (nitrogen >= ni)
  {
    return(dmultinom(c(nitrogen-ni,ni),nitrogen,c(0.99632,0.00368)))
  }
  else {return(0)}
}

# Function to build the isotopic envelope
envelope <- function(niso) {
# Calculate all theoretical possibilities
  chcomb <- data.table::CJ(seq(0,niso),seq(0,niso))
# Build isotopic envelope one element at a time
  chcomb[,sum:=Reduce(`+`,.SD)]
  chcombf <- chcomb[sum<(niso+1),1:2]
  chncomb <- chcombf[,seq(0,niso),by=chcombf]
  chncomb[,sum:=Reduce(`+`,.SD)]
  chncombf <- chncomb[sum<(niso+1),1:4]
  colnames(chncombf) <- c("ciso","hiso","ntiso","sum")
  return(chncombf)
}

# Predict abundances
pred.int <- function(grid.data,niso){
abund <- vector("numeric",niso+1)
  for (i in seq(1:(niso+1)))
  {
    # if((i-1)==0){
    #   cat("Calculating Monoisotopic Peak...\n")}
    # else{
    #   cat(paste((i-1),"isotope...\n",sep=" "))
    # }
    mat <- grid.data[sum==(i-1)]
    mat[,cprob:=mapply(cdist,ci=ciso,carbon=carbon)]
    mat[,hprob:=mapply(hdist,hi=hiso,hydrogen=hydrogen)]
    mat[,nprob:=mapply(ndist,ni=ntiso,nitrogen=nitrogen)]
    prob <- mat[,(cprob*hprob*nprob)]
    abund[i] <- sum(prob)
  }
  return(abund)
}