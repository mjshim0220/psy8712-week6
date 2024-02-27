#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(tidyverse)
library(stringr)


#Data Import
citations<-stri_read_lines("../data/citations.txt", encoding="Windows-1252") #encoding=ISO-8859-1
citations_txt<-citations[!stri_isempty(citations)]
length(citations)-length(citations_txt)
mean(nchar(citations_txt))

#Data Cleaning
sample(citations_txt,20)

citations_tbl<-tibble(line=1:length(citations_txt),cite=citations_txt) %>% 
  mutate(cite=str_replace_all(cite, pattern="\"", "")) %>% 
  mutate(year=str_extract_all(cite, pattern="(?<=\\()[12][0-9]{3}(?=\\))")) %>% 
  #mutate(page_start=str_extract(cite, "")) # I was not able to complete line 20
  mutate(perf_ref=str_detect(cite, regex("performance",ignore_case=TRUE))) %>% 
  mutate(title=str_match(cite, pattern= "\\(\\d{4}\\)\\.\\s(.*?)\\.")[,2]) %>% 
  mutate(first_author=str_match(cite, pattern="^([^,]+),")[,2])
  
sum(!is.na(citations_tbl$first_author))
         
