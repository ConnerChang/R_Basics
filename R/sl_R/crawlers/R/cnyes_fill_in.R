#' ---
#' title: "鉅亨網"
#' author: ""
#' date: "`r Sys.Date()`"
#' output: 
#'   html_document: 
#'     toc: yes
#' ---

#+ include=FALSE
# set root dir when rendering
knitr::opts_chunk$set(eval = FALSE)

#' [鉅亨網](http://www.cnyes.com/twstock/ps_historyprice/2330.htm)
#' 
#' ## Load Packages
suppressPackageStartupMessages({
    library(magrittr)
    library(httr)
    library(rvest)
    library(XML)
})


#' ## Get and parse Data
url <- "http://www.cnyes.com/twstock/ps_historyprice/2330.htm"

# make a GET request
res <- GET(url = url)

doc_str <- res %>% 
    content(as = "text", encoding = "UTF-8")

# parse data
dat <- doc_str %>% 
    read_html(encoding = "UTF-8") %>%
    as.character() %>%
    XML::readHTMLTable(encoding = "UTF-8") %>% 
    .[[2]] 
    
colnames(dat) <- c("日期", "開盤", "最高", "最低", "收盤",
                "漲跌", "漲%", "成交量", "成交金額", "本益比") # set column names


#' ## Clean data
str(dat) # see the structure of dat
head(dat, 10)

# convert data type from character to double
# as.double(dat[, 2:ncol(dat)]) 
dat[, 2:ncol(dat)] <- <fillin>(dat[, 2:ncol(dat)], 
                             function(x){
                                 x <- <fillin>(",|%", "", x) # replace , and % with ""
                                 as.double(x)
                             })
# convert data type from character to date
dat$`日期` <- <fillin>(dat$`日期`)
str(dat)

#' ## Construct a Function
#' A function needs arguments, what are the arguments you think this crawler needs?
get_stock_price <- function(<fillin>) {
    Sys.sleep(1) # sleep one second
    url <- sprintf("http://www.cnyes.com/twstock/ps_historyprice/%s.htm", <fillin>)
    
    res <- GET(url = url)
    doc_str <- res %>% 
        content(as = "text", encoding = "UTF-8")
        
    if (.Platform$OS.type == "unix") { 
        # get and parse data
        dat <- doc_str %>% 
            read_html() %>% 
            html_table(header = TRUE, fill = TRUE) %>% 
            .[[2]] # extract the second component of the html table
    } else if (.Platform$OS.type == "windows") { # html_table() doesn't work on Windows
        # get and parse data
        dat <- doc_str %>% 
        read_html(encoding = "UTF-8") %>%
        as.character() %>%
        XML::readHTMLTable(encoding = "UTF-8") %>% 
        .[[2]] 
        
        colnames(dat) <- c("日期", "開盤", "最高", "最低", "收盤",
                           "漲跌", "漲%", "成交量", "成交金額", "本益比")
    }
        
    # convert data type from character to double
    dat[, 2:ncol(dat)] <- sapply(dat[, 2:ncol(dat)], 
                                function(x){
                                    x <- gsub(",|%", "", x)
                                    as.double(x)
                                })
    # convert data type from character to date
    dat$`日期` %<>% as.Date()
        
    return(dat)
}
dat <- get_stock_price(<fillin> = 2330)
dat <- get_stock_price(<fillin> = 3000) # what happened?
dat <- get_stock_price(<fillin> = 0) # what happened?

#' ## Add error handlers
get_stock_price <- function(stock_id) {
    Sys.sleep(1)
    url <- sprintf("http://www.cnyes.com/twstock/ps_historyprice/%s.htm", stock_id)
    tryCatch({
        # make a GET request
        res <- GET(url = url)
        # return an empty data frame if status_code >= 400
        if (res$status_code >= 400) {
          message(sprintf("Stock %s has error because of status code %i", stock_id, res$status_code))
          return(data.frame())
        }
        doc_str <- res %>% 
            content(as = "text", encoding = "UTF-8")
    
        if (.Platform$OS.type == "unix") { 
            # get and parse data
            dat <- doc_str %>% 
                read_html() %>% 
                html_table(fill = TRUE) %>% 
                .[[2]] # extract the second component of the html table
        } else if (.Platform$OS.type == "windows") { # html_table() doesn't work on Windows
            # get and parse data
            dat <- doc_str %>% 
                read_html(encoding = "UTF-8") %>%
                as.character() %>%
                XML::readHTMLTable(encoding = "UTF-8") %>% 
                .[[2]]
            
            # return an empty data frame if no data was retrieved
            if (is.null(dat)) {
                message(sprintf("Stock %s has no data.", stock_id))
                return(data.frame())
            }
            
            colnames(dat) <- c("日期", "開盤", "最高", "最低", "收盤",
                               "漲跌", "漲%", "成交量", "成交金額", "本益比")
        }
        # return a empty data frame if no data was retrieved
        if (nrow(dat) == 0) {
            message(sprintf("Stock %s has no data.", stock_id))
            return(data.frame())
        }
        
        # convert data type from character to double
        dat[, 2:ncol(dat)] <- sapply(dat[, 2:ncol(dat)], 
                                     function(x){
                                         x <- gsub(",|%", "", x)
                                         as.double(x)
                                     })
        # convert data type from character to date
        dat$`日期` %<>% as.Date()
        
        return(dat)
    }, error = function(cond) {
        # return an empty data frame if the error "subscript out of bounds" happens
        if (cond$call == ".[[2]]") { 
            message(sprintf("Stock %s has no data.", stock_id))
            return(data.frame())
        }
    })
}

#' ## A crawler function should ......
#' 1. Get and parse Data,
#' 2. Clean data,
#' 3. Set Function arguments (usually in the URL if one makes a GET request),
#' 4. Handle errors.
