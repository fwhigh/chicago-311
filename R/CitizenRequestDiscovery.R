### first discovery session
### must run init.R

source(file.path(Rdir,"Plots.R"))

require(ggplot2)


print("columns:")
print(names(GRAFFITI))

print("number of rows:")
print(length(GRAFFITI$Creation.Date))

total = sum(GRAFFITI$Status != "Completed - Dup" &
  GRAFFITI$Status != "Open - Dup")

print("non-duplicate tickets")
print(total)

print("number of tickets completed before they were created")
count=sum(na.omit(GRAFFITI$Creation.Date > GRAFFITI$Completion.Date &
  (GRAFFITI$Status != "Completed - Dup" &
   GRAFFITI$Status != "Open - Dup")))
print(count)
print(count/total)

print("number of tickets completed at the same time they were created")
count=sum(na.omit(GRAFFITI$Creation.Date == GRAFFITI$Completion.Date &
  (GRAFFITI$Status != "Completed - Dup" &
   GRAFFITI$Status != "Open - Dup")))
print(count)
print(count/total)

print("number of tickets completed at least 1 day after they were created")
count=sum(na.omit(GRAFFITI$Creation.Date < GRAFFITI$Completion.Date &
  (GRAFFITI$Status != "Completed - Dup" &
   GRAFFITI$Status != "Open - Dup")))
print(count)
print(count/total)


print("number of open tickets")
count=sum(na.omit(GRAFFITI$Status == "Open"))
print(count)
print(count/total)

# Plot the distribution of ticket completion
graffiti = GRAFFITI
graffiti$Completion.Duration = as.numeric(graffiti$Completion.Date - graffiti$Creation.Date)
graffiti$Completion.Duration[graffiti$Status == "Completed - Dup"] = NA
graffiti$Completion.Duration[graffiti$Status == "Open - Dup"] = NA

p1 <- ggplot(graffiti,
            aes(x=Completion.Duration)) 
p1 = p1 + geom_histogram()
p1 = p1 + scale_x_continuous(name="Completion Time (days)")
p2 = p1 + scale_y_log10()
extra = "all"
outfile=file.path(plotdir,paste("graffiti_completion_time_histogram_",extra,".png",sep=""))
png(outfile,width=1100,height=900)
multiplot(p1, p2, cols=2)
dev.off()
#show_plot(p1,dopng=TRUE,file="graffiti_completion_time_histogram",width=1100,height=900,extra=extra)
