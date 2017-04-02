#' ---
#' title: "全家便利商店"
#' author: ""
#' date: "`r Sys.Date()`"
#' output: 
#'   html_document: 
#'     toc: yes
#' ---

#+ include=FALSE
# set root dir when rendering
knitr::opts_chunk$set(eval = FALSE)


#' [全家便利商店](http://www.family.com.tw/marketing/inquiry.aspx)
#' 
#' ## Load Packages
suppressPackageStartupMessages({
library(magrittr)
library(httr)
library(jsonlite)
})

#' ## 全家便利商店 {.tabset}
#' ### Fill In 
url <- "<Fill In>"
# make a GET request
res <- <Fill In>(url = url,
           add_headers(
               Referer = "<Fill In>"
           ),
           <Fill In> = list(
               searchType = "ShopList",
               type = "",
               city = "台北市",
               area = "大安區",
               road = "",
               fun = "showStoreList",
               key = "6F30E8BF706D653965BDE302661D1241F8BE9EBC"
           ))
# get and parse data
doc_str <- content(res, as = "text") %>% 
    `Encoding<-`("UTF-8")

# clean data by regex
dat <- doc_str %>%
    sub("^[^\\[]*", "", .) %>%
    sub("[^\\]]*$", "", .) %>% 
    <Fill In>
    
#' ### Answer
url <- "http://api.map.com.tw/net/familyShop.aspx"
# make a GET request
res <- GET(url = url,
           add_headers(
               Referer = "http://www.family.com.tw/marketing/inquiry.aspx"
           ), # remember to add Referer and the comma!
           # query allows you to append the list components to url
           query = list(
               searchType = "ShopList",
               type = "",
               city = "台北市",
               area = "大安區",
               road = "",
               fun = "showStoreList",
               key = "6F30E8BF706D653965BDE302661D1241F8BE9EBC"
           ))
# get and parse data
doc_str <- content(res, as = "text") %>% 
    `Encoding<-`("UTF-8")

# clean data by regex
dat <- doc_str %>%
    sub("^[^\\[]*", "", .) %>%
    sub("[^\\]]*$", "", .) %>% 
    fromJSON() # convert json to data frame

#' ## 全家便利商店 (Crawler Function) 
get_family_stores <- function(city, area){
    url <- "http://api.map.com.tw/net/familyShop.aspx"
    # make a GET request
    res <- GET(url = url,
               add_headers(
                   Referer = "http://www.family.com.tw/marketing/inquiry.aspx"
               ), # remember to add Referer
               # query allows you to append the list components to url
               query = list(
                   searchType = "ShopList",
                   type = "",
                   city = city,
                   area = area,
                   road = "",
                   fun = "showStoreList",
                   key = "6F30E8BF706D653965BDE302661D1241F8BE9EBC"
               ))
    # get and parse data
    doc_str <- content(res, as = "text") %>% 
        `Encoding<-`("UTF-8")
    
    # return NULL if no data was retrieved
    if (doc_str == "showStoreList([])") {
        message(sprintf("No data in area %s in city %s", area, city))
        return(data.frame())
    }
    
    # clean data by regex
    dat <- doc_str %>%
        sub("^[^\\[]*", "", .) %>%
        sub("[^\\]]*$", "", .) %>% 
        fromJSON() 
    
    return(dat)
}
