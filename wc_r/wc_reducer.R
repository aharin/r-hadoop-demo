#! /usr/bin/env Rscript

library(HadoopStreaming)

process <- function(map.entry){
  #aggregate the values per word
  word <- map.entry$key[1]
  count <- sum(map.entry$value)

  write(paste(word, count, sep="\t"), file=stdout())
}

(function() {
  input <- file("stdin", open="r")

  #create column names to make is easier to work with the data set
  cols = list(key="", value=0)

  #read from the input
  hsTableReader(file=input, cols, sep=" ", ignoreKey=FALSE, FUN=process)
})()

