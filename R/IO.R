### i/o functions

read.graffiti <- function() {
  ### get the raw graffiti data prior to about 4/24/2013

  ### needed packages
  require(data.table)

  ### do it
  file="311_Service_Requests_-_Graffiti_Removal.csv"
  file=paste(raw.datadir,file,sep="/")
  graffiti=data.table(read.csv(file,sep=',',stringsAsFactors=T))
  return(graffiti)
}
