#' ---
#' title: "台灣證券交易所_個股日本益比、殖利率及股價淨值比"
#' author: ""
#' date: "`r Sys.Date()`"
#' output: 
#'   html_document: 
#'     toc: yes
#' ---

#+ include=FALSE
knitr::opts_chunk$set(eval = FALSE)

#' [台灣證券交易所](http://www.twse.com.tw/ch/trading/exchange/BWIBBU/BWIBBU_d.php)
#' 
#' ## Load Packages
suppressPackageStartupMessages({
    library(httr)
    library(rvest)
    library(magrittr)
    library(XML)
    library(stringr)
})

#' ## Get and parse Data

url <- "http://www.twse.com.tw/ch/trading/exchange/BWIBBU/BWIBBU_d.php"

# set form data
form <- list(input_date = <fill_in>,
             select2 = <fill_in>,
             order = <fill_in>,
             login_btn = <fill_in>)

res_p <- POST(url = url,
              body = <fill_in>,
              encode = "form") 

dat <- res_p %>% 
    content(as = "text", encoding = 'big-5') %>%
    read_html(encoding = "UTF-8") %>%
    as.character() %>% 
    XML::readHTMLTable(header = TRUE, encoding = "UTF-8") %>% 
    .[[8]] %>% 
    `colnames<-`(c('id','company','PER','DY','PBR'))

#' ## Clean data
str(dat)

# convert data type from character to double
dat[, 3:ncol(dat)] <- sapply(dat[, 3:ncol(dat)], 
                             function(x){
                                 x <- gsub("-", "0", x)
                                 as.double(x)
                             })

#' ## Construct a crawler function with error handler {.tabset}
#' ### Fill In
get_twse <- function(<fill_in>, <fill_in>, <fill_in>) {
    url <- "http://www.twse.com.tw/ch/trading/exchange/BWIBBU/BWIBBU_d.php"
    
    # month and day are must of two digits, e.g., "2" -> "02"
    month <- stringr::str_pad(<fill_in>, 2, pad = "0")
    day <- stringr::str_pad(<fill_in>, 2, pad = "0")
   
    tryCatch({
    # set form data
        form <- list(input_date = paste(year, month, day, sep = "/"),
                     select2 = "ALL",
                     order = "STKNO",
                     login_btn = "%ACd%B8%DF")
        # make a POST request
        res_p <- POST(url = url,
                      body = form,
                      encode = "form")
        # get and parse data
        if (.Platform$OS.type == "unix") {
            dat <- res_p %>% 
                content(encoding = 'big-5') %>%
                html_table(fill = TRUE) %>% 
                .[[8]] %>% 
                .[-1, ] %>% # remove first row 
                `colnames<-`(c('id','company','PER','DY','PBR'))
        } else if (.Platform$OS.type == "windows") {# html_table() doesn't work on Windows
            dat <- res_p %>% 
                content(as = "text", encoding = 'big-5') %>%
                read_html(encoding = "UTF-8") %>%
                as.character() %>% 
                XML::readHTMLTable(header = TRUE, encoding = "UTF-8") %>% 
                .[[8]] %>% 
                `colnames<-`(c('id','company','PER','DY','PBR'))
        }
        # convert data type from character to double
        dat[, 3:ncol(dat)] <- sapply(dat[, 3:ncol(dat)], 
                                     function(x){
                                         x <- gsub("-", "0", x)
                                         as.double(x)
                                     })
        return(dat)
    }, error = function(cond) {
        #  return NULL if the error "subscript out of bounds" happens
        if (cond$call == ".[[8]]") { 
            message(sprintf("No data on %s/%s/%s", year, month, day))
            return(data.frame())
        }
    })
}
#' ### Answer
get_twse <- function(year, month, day) {
    url <- "http://www.twse.com.tw/ch/trading/exchange/BWIBBU/BWIBBU_d.php"
    
    # month and day are must of two digits, e.g., "2" -> "02"
    month <- stringr::str_pad(month, 2, pad = "0")
    day <- stringr::str_pad(day, 2, pad = "0")
    
    tryCatch({
        # set form data
        form <- list(input_date = paste(year, month, day, sep = "/"),
                     select2 = "ALL",
                     order = "STKNO",
                     login_btn = "%ACd%B8%DF")
        # make a POST request
        res_p <- POST(url = url,
                      body = form,
                      encode = "form")
        # get and parse data
        if (.Platform$OS.type == "unix") {
            dat <- res_p %>% 
                content(encoding = 'big-5') %>%
                html_table(fill = TRUE) %>% 
                .[[8]] %>% 
                .[-1, ] %>% # remove first row 
                `colnames<-`(c('id','company','PER','DY','PBR'))
        } else if (.Platform$OS.type == "windows") {# html_table() doesn't work on Windows
            dat <- res_p %>% 
                content(as = "text", encoding = 'big-5') %>%
                read_html(encoding = "UTF-8") %>%
                as.character() %>% 
                XML::readHTMLTable(header = TRUE, encoding = "UTF-8") %>% 
                .[[8]] %>% 
                `colnames<-`(c('id','company','PER','DY','PBR'))
        }
        # convert data type from character to double
        dat[, 3:ncol(dat)] <- sapply(dat[, 3:ncol(dat)], 
                                     function(x){
                                         x <- gsub("-", "0", x)
                                         as.double(x)
                                     })
        return(dat)
    }, error = function(cond) {
        #  return an empty data frame if the error "subscript out of bounds" happens
        if (cond$call == ".[[8]]") { 
            message(sprintf("No data on %s/%s/%s", year, month, day))
            return(data.frame())
        }
    })
}
#' ## Notes
#' 1. One can use a list to create a body,
#' 2. The function arguments are usually the data in the body if one makes a POST request.