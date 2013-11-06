#! /usr/bin/env Rscript

library(HadoopStreaming)
library(methods)
library(devtools)

#use devtools to load the package in cwd without installing 
load_all("wc.demo_1.0/wc.demo", quiet = TRUE)

(function() {
  input <- file("stdin", open="r")

  #create column names to make is easier to work with the data set
  cols = list(key="", value=0)

  #read from the input
  hsTableReader(file=input, cols, sep=" ", ignoreKey=FALSE, FUN=aggregate.values)
})()

