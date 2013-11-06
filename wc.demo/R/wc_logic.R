#transform input to a uniform and processable stream of data, consisting of key/value pairs 
emit.values <- function(chunk.of.text){
  
  words <- strsplit(chunk.of.text, " ")
  
  sapply(words, function(word){
    write(paste(word, "1"), file=stdout())
  })
}


aggregate.values <- function(map.entry){
  #aggregate the values per word
  word <- map.entry$key[1]
  count <- sum(map.entry$value)
  
  write(paste(word, count, sep="\t"), file=stdout())
}