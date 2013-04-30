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

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}



graffiti.time.histograms <- function(dopng=T,
                                     extra=NULL) {
  require(ggplot2)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  extra = "all"
  show_plot(p,dopng=dopng,file="graffiti_creation_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Type.of.Service.Request)
  extra = "Type.of.Service.Request"
  show_plot(p,dopng=dopng,file="graffiti_creation_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Status)
  extra = "Status"
  show_plot(p,dopng=dopng,file="graffiti_creation_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ What.Type.of.Surface.is.the.Graffiti.on.)
  extra = "What.Type.of.Surface.is.the.Graffiti.on"
  show_plot(p,dopng=dopng,file="graffiti_creation_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Where.is.the.Graffiti.located.)
  extra = "Where.is.the.Graffiti.located"
  show_plot(p,dopng=dopng,file="graffiti_creation_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ ZIP.Code)
  extra = "ZIP.Code"
  show_plot(p,dopng=dopng,file="graffiti_creation_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Ward)
  extra = "Ward"
  show_plot(p,dopng=dopng,file="graffiti_creation_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Police.District)
  extra = "Police.District"
  show_plot(p,dopng=dopng,file="graffiti_creation_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Creation.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Community.Area)
  extra = "Community.Area"
  show_plot(p,dopng=dopng,file="graffiti_creation_date_histogram",width=1100,height=900,extra=extra)


  p <- ggplot(GRAFFITI,
              aes(x=Completion.Date)) 
  p = p + geom_histogram()
  extra = "all"
  show_plot(p,dopng=dopng,file="graffiti_completion_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Completion.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Type.of.Service.Request)
  extra = "Type.of.Service.Request"
  show_plot(p,dopng=dopng,file="graffiti_completion_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Completion.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Status)
  extra = "Status"
  show_plot(p,dopng=dopng,file="graffiti_completion_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Completion.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ What.Type.of.Surface.is.the.Graffiti.on.)
  extra = "What.Type.of.Surface.is.the.Graffiti.on"
  show_plot(p,dopng=dopng,file="graffiti_completion_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Completion.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Where.is.the.Graffiti.located.)
  extra = "Where.is.the.Graffiti.located"
  show_plot(p,dopng=dopng,file="graffiti_completion_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Completion.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ ZIP.Code)
  extra = "ZIP.Code"
  show_plot(p,dopng=dopng,file="graffiti_completion_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Completion.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Ward)
  extra = "Ward"
  show_plot(p,dopng=dopng,file="graffiti_completion_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Completion.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Police.District)
  extra = "Police.District"
  show_plot(p,dopng=dopng,file="graffiti_completion_date_histogram",width=1100,height=900,extra=extra)

  p <- ggplot(GRAFFITI,
              aes(x=Completion.Date)) 
  p = p + geom_histogram()
  p = p + facet_wrap(~ Community.Area)
  extra = "Community.Area"
  show_plot(p,dopng=dopng,file="graffiti_completion_date_histogram",width=1100,height=900,extra=extra)

}

graffiti.response.time.histograms <- function(dopng=T,
                                              extra=NULL) {

  GRAFFITI$Response.Time = GRAFFITI$Completion.Date - GRAFFITI$Creation.Date
  
  p <- ggplot(GRAFFITI,
              aes(x=Response.Time)) 
  p = p + geom_histogram()

  extra='all'
  show_plot(p,dopng=dopng,file="graffiti_response_time_histogram",width=1100,height=900,extra=extra)

}
