library(tidyverse)
library(rvest)

get_data <- function() {
  url <- "https://crossweb.pl/wydarzenia//"
  
  crossweb_page<- read_html(url)
  
  daty <- crossweb_page %>%
    html_nodes(".first.clearfix .num.fl") %>%
    html_text()
  
  dzien <- crossweb_page %>%
    html_nodes(".first.clearfix .name.fl") %>%
    html_text()
  
  nazwy <- crossweb_page %>%
    html_nodes(".colTab.title") %>%
    html_text(trim = TRUE) %>%
    gsub("  .*","", .) %>%
    str_replace_all('"',"")
  
  miasto <- crossweb_page %>%
    html_nodes(".colTab.city") %>%
    html_text(trim = T)
  
  typ <- crossweb_page %>%
    html_nodes(".colTab.type") %>%
    html_text(trim = T)
  
  koszt <- crossweb_page %>%
    html_nodes(".colTab.cost") %>%
    html_text(trim = T)
  
  cw_df <- data.frame(date = format(as.Date(daty, format = "%d.%m"),"%m/%d"), day = as.factor(dzien), event_name = nazwy, town = as.factor(miasto), type = as.factor(typ), cost = as.factor(koszt), stringsAsFactors = F)
  
  cw_df
}