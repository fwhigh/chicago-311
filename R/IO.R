### library of i/o functions

read.graffiti <- function() {
  ### get the raw graffiti data prior to about 4/24/2013

  ### needed packages
  require(data.table)

  ### do it
  file="311_Service_Requests_-_Graffiti_Removal.csv"
  file=paste(raw.datadir,file,sep="/")
  rdatafile=paste(file,'.rda',sep='')

  if (!file.exists(rdatafile)) {
    graffiti=data.table(read.csv(file,sep=',',stringsAsFactors=T))
    save(graffiti,file=rdatafile)
  } else {
    load(rdatafile)
  }

  # last row is bad
  graffiti=graffiti[-c(length(graffiti$Creation.Date)),]

  # cast date factors as dates
  graffiti$Creation.Date = as.Date(as.character(graffiti$Creation.Date),"%m/%d/%Y")  
  graffiti$Completion.Date = as.Date(as.character(graffiti$Completion.Date),"%m/%d/%Y")  

  # get rid of dates prior to 2011
  graffiti=graffiti[graffiti$Creation.Date > as.Date("2011-01-01")]

  return(graffiti)
}

