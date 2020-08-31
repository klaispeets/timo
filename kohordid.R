rm(list=ls())
setwd("~/work/OTHERS/timo/kohordid")
library(mixdist)
load("timo_kohordid_2014_2019.RData")  


setwd("~/work/OTHERS/timo/kohordid/figures")  # Kaust kuhu joonised panna
results = NULL  # see saab olema tulemuste tabel
      
for(i in 1:length(date)){
idx = which(!is.na(data[i,]))
if(length(idx)>7){
set = data.frame(length[idx], as.numeric(data[i, idx]))
names(set) = c("length", "freq")
fit = try(mix(set, mixparam(c(9,15),c(0.9,1.5))), silent = T)
if(class(fit)[1] != "try-error"){
pdf(file = paste0(as.character(date[i]),".pdf"), width = 6, height = 6, onefile = F)
plot(fit, main = as.character(date[i]))
dev.off()
mu = data.frame(fit$parameters)
mu$date = as.Date(date[i])
results = rbind(results, mu)
}
}}

#Which dates did not succeed to fit?
date[-which(date %in% results$date)]
