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
Rdir=file.path(rootdir,"R")
raw.datadir=file.path(datadir,"raw")
clean.datadir=file.path(datadir,"clean")
plotdir=file.path(datadir,"plots",Sys.info()["user"])
dir.create(plotdir,showWarnings = FALSE)

### source the needed libraries
source(file.path(Rdir,"IO.R"))
source(file.path(Rdir,"Plots.R"))
source(file.path(Rdir,"CacheData.R"))

### done
print("Chicago 311 package loaded")
