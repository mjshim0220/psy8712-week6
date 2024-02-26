#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(tidyverse)
library(stringr)


#Data Import
citations<-stri_read_lines("../data/citations.txt", encoding="Windows-1252")
citations_txt<-citations[!stri_isempty(citations)]
length(citations)-length(citations_txt)
mean(nchar(citations_txt))

#Data Cleaning

citations_tbl<-tibble(line=1:length(citations_txt),cite=citations_txt) %>% 
  mutate(cite=str_replace_all(cite,"\"", ""))

         