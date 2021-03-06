source("markov.R")

# Run the Delivery Man game n times.
runNtimes = function(n,fname="test.dat") {
  sum=0
  runs=list()
  for (i in 1:n) {
    #moves=runWheresCroc(markovMoves,T,0)
    moves=runWheresCroc(randomWC,T,0)
    runs[[i]]=moves
    sum=sum+moves
  }
  print("DONE!")
  print(paste("Average no. moves = ",sum/n))
  lapply("vals",write,fname,append=TRUE,ncolumns=1000)
  lapply(runs,write,fname,append=TRUE,ncolumns=1000)
}

# Plot a histogram from data written to a file in runNtimes.
plotHist = function(fname) {
  data=read.csv(file=fname,sep=",",head=TRUE)
  hist(data$vals)
  hist(data$vals,main="Distribution of runs",xlab="Number of moves")
}

# Plot a boxgraph from data written to a file in runNtimes.
plotBox = function(fname1,fname2=NULL,xlab=NULL) {
  data1=read.csv(file=fname1, sep=",",head=TRUE)
  if(is.null(fname2)) {
    boxplot(data1$vals,main='Distribution of runs',ylab='Number of moves')
    if(!is.null(names)) {
      boxplot(data1$vals,names=xlab,main='Distribution of runs',ylab='Number of moves')
    }
    else {
      boxplot(data1$vals,main='Distribution of runs',ylab='Number of turns')
    }
  }
  else {
    if(!is.null(names)) {
      data2=read.csv(file=fname2,sep=",",head=TRUE)
      boxplot(data1$vals,data2$vals,names=xlab,main='Distribution of runs',ylab='Number of turns')
    }
    else {
      data2=read.csv(file=fname2,sep=",",head=TRUE)
      boxplot(data1$vals,data2$vals,main='Distribution of runs',ylab='Number of turns')
    }
  }
}

appendData = function(fname1,fname2,data,val) {
  lapply(data,write,fname1,append=TRUE,ncolumns=1000)
  lapply(val,write,fname2,append=TRUE,ncolumns=1000)
}

accuracy = function(fname1,fname2) {
  trans=transitionMatrix()
  
  src1=read.csv(file=fname1,sep=",",head=TRUE)
  src2=read.csv(file=fname2,sep=",",head=TRUE)
  data=src1$vals
  vals=src2$vals
  acc=0
  for(i in 1:length(data)) {
    path=getPath(trans,data[[i]],vals[[i]],1,NULL,list())
    dist=path[[1]]
    if(dist==0) { dist=1 }
    acc = acc+(1/dist)
    #if(data[[i]]==vals[[i]]) {
      #acc=acc+1
    #}
  }
  return(acc/length(data))
}

# Calculate the standard deviation from data written to a file in runNtimes.
stdDeviation = function(fname) {
  data=read.csv(file=fname,sep=",",head=TRUE)
  print(sd(data$vals))
}

# Calculate the average from data written to a file in runNtimes.
average = function(fname) {
  data=read.csv(file=fname,sep=",",head=TRUE)
  print(mean(data$vals))
}