### get the environment variables
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

### set global variables
# force read from source files? set to FALSE for speed
FORCEREAD = FALSE

### get the directories
Rdir=paste(rootdir,"R",sep="/")
raw.datadir=paste(datadir,"raw",sep="/")
clean.datadir=paste(datadir,"clean",sep="/")

### source the needed libraries
source(paste(Rdir,"IO.R",sep="/"))
source(paste(Rdir,"CacheData.R",sep="/"))

### done
print("Chicago 311 package loaded")
