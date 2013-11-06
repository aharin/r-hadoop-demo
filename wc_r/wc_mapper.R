#! /usr/bin/env Rscript

library(HadoopStreaming)

#transform input to a uniform and processable stream of data, consisting of key/value pairs 
emit <- function(chunk.of.text){
  
  words <- strsplit(chunk.of.text, " ")
  
  sapply(words, function(word){
      write(paste(word, "1"), file=stdout())
  })
}

(function() {
  input <- file("stdin", open="r") 

  #read input in reasonable cunks and apply emit to each chunk
  hsLineReader(input, chunkSize=3, FUN=emit)
  
})()

