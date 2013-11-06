#! /usr/bin/env Rscript

library(HadoopStreaming)
library(methods)
library(devtools)

#use devtools to load the package in cwd without installing 
load_all("wc.demo_1.0/wc.demo", quiet = TRUE)

(function() {
  input <- file("stdin", open="r") 

  #read input in reasonable chunks and apply emit to each chunk
  hsLineReader(input, chunkSize=3, FUN=emit.values)
  
})()

