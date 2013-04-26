envrootname='CHICAGO311ROOT'
envdataname='CHICAGO311DATA'
rootdir=Sys.getenv(envrootname)
datadir=Sys.getenv(envdataname)
if (rootdir == "" & !file.exists(rootdir)) {
  stop("You must set a root directory in an .Renviron file")  
}
if (rootdir == "" & !file.exists(datadir)) {
  stop("You must set a data directory in an .Renviron file")  
}
