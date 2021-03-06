#!/usr/bin/env rscript

#Author= "Quentin Rougemont"
#purpose = "Miniscript to reshape a genotypic matrix into all pairwise genotypic file use to prepare abc file 
#how to run = "./prepare.abc.R genotypic.matrix 
#last uptade = "15.09.2016"
#Output = abc.input file for bash

argv <- commandArgs(TRUE) #Ped file

if (argv[1]=="-h" || length(argv)==0){
        cat("\nprepare.abc.R \"genotypic.matrix\" \n" )
}else{

input <- argv[1]
folder <- paste(argv[2])

input_1 <- as.matrix( read.table(input) )
marker <- input_1[1, ]
input_1 <-  input_1[-1, ]

input_1[,1] <- substr( x=input_1[,1], start=1, stop=4)
result <- lapply( split( input_1, input_1[,1]), matrix, ncol=ncol(input_1) )


#Then write the target table:
#exemple:
len_items = length(results)

for(i in seq(len_items-1))
{
     for(j in seq(i+1 , len_items1))
     {
     write.table(cbind(all,t(rbind(result[[i]],result[[j]]))),paste(folder,names(result[i]),names(result[j]),".ABC.tmp",sep=""), quote=F, row.names=F, col.names=F,sep="\t")
     }
}
# /!\ Warning this will creates a very large amount of input file!!
#Alternatively just creates a small amount of data manually:
#eg:
#write.table(cbind(all,t(rbind(result$Loir,result$Narr))),"LoirNarr.ABC.tmp", quote=F, row.names=F, col.names=F,sep="\t")
}
