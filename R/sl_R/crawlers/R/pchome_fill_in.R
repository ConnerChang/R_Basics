#' ---
#' title: "PChome"
#' author: ""
#' date: "`r Sys.Date()`"
#' output: 
#'   html_document: 
#'     toc: yes
#' ---
#' 
#+ include=FALSE
knitr::opts_chunk$set(eval = FALSE)
#' [PChome](http://ecshweb.pchome.com.tw/search/v3.3/?q=apple)
#' 
#' ## Load Packages
library(httr)
library(jsonlite)
library(magrittr)

#' ## PChome
url <- "http://ecshweb.pchome.com.tw/search/v3.3/all/results?"

res <- <fillin>(url = url,
           query = list(  
               q = "apple",
               page = 1
           ))

# get and parse data
dat <- res %>% 
    <fillin>(as = "text", encoding = "UTF-8") %>% 
    fromJSON() %>% 
    .$<fillin>
    
#' ## Notes
#' 1. 使用 query = list(var1=..., var2=...) 設定 GET quest 的 URL.
#' 2. 使用 `jsonlite::fromJSON()` 將 JSON 轉換成 Data Frame.
 