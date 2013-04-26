### first discovery session
### must run init.R

source(file.path(Rdir,"Plots.R"))


print("columns:")
print(names(GRAFFITI))

print("number of rows:")
print(length(GRAFFITI$Creation.Date))

graffiti.time.histograms()

#graffiti.time.series.plot()
