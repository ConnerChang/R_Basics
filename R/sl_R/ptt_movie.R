library(magrittr)
library(httr)
library(rvest)

url <- "https://www.ptt.cc/bbs/movie/index.html"
res <- GET(url)

res %>% 
    content(as = "text", encoding = "UTF-8") %>% 
    read_html() %>% 
    html_nodes(css = ".title a") %>% 
    html_text()
