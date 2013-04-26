### plot function library

show_plot<-function(p="Nothing to Plot",dopng=F,file="TemporaryPlot",extra=NULL,
                    sep="_",verb=0,width=800,height=700,dir=plotdir) {
  
  #a useful utility function for plotting or just printing to window
  #p<-qplot(c(0,1))
  #show_plot(p,dopng=T)
  if (!dopng) {
    print(p)
    #and nothing else
  } else {
    #uses global plotdir  
    wmessage=paste("Warning, no file provided. Printing to :",file)
    if (file == "TemporaryPlot") print(wmessage)
    
    ex=""
    if (! is.null(extra)) {
      #extra stuff to join in with underscores
      ex=paste(sep,paste(extra,collapse=sep),sep="")
    } 
    print(length(ex))
    outfile=file.path(dir,paste(file,ex,".png",sep=""))
    if (verb > 0) print(paste("Writing to file:",outfile))
    png(outfile,width=width,height=height)  
    print(p)
    dev.off()
  }
}


graffiti.time.histograms <- function(dopng=T,
                               extra=NULL) {
  require(ggplot2)

  warn.state=getOption('warn')
  options(warn=-1)
    
  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  extra = "all"
  show_plot(p,dopng=dopng,file="graffiti_time_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Type.of.Service.Request)
  extra = "Type.of.Service.Request"
  show_plot(p,dopng=dopng,file="graffiti_time_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Status)
  extra = "Status"
  show_plot(p,dopng=dopng,file="graffiti_time_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ What.Type.of.Surface.is.the.Graffiti.on.)
  extra = "What.Type.of.Surface.is.the.Graffiti.on"
  show_plot(p,dopng=dopng,file="graffiti_time_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Where.is.the.Graffiti.located.)
  extra = "Where.is.the.Graffiti.located"
  show_plot(p,dopng=dopng,file="graffiti_time_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ ZIP.Code)
  extra = "ZIP.Code"
  show_plot(p,dopng=dopng,file="graffiti_time_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Ward)
  extra = "Ward"
  show_plot(p,dopng=dopng,file="graffiti_time_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Police.District)
  extra = "Police.District"
  show_plot(p,dopng=dopng,file="graffiti_time_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Community.Area)
  extra = "Community.Area"
  show_plot(p,dopng=dopng,file="graffiti_time_histogram",width=1100,height=900,extra=extra)

  options(warn=warn.state)

}
