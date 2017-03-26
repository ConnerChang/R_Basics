#' ---
#' title: "台灣彩券"
#' author: ""
#' date: "`r Sys.Date()`"
#' output: 
#'   html_document: 
#'     toc: yes
#' ---

#+ include=FALSE
knitr::opts_chunk$set(eval = FALSE)

#' ## Load Packages
library(httr)
library(rvest)
library(magrittr)

#' ## 台灣彩券 (GET) {.tabset}
#' ### Fill In
url <- "http://www.taiwanlottery.com.tw/lotto/Lotto649/history.aspx"

res <- GET(url = url)

doc <- content(res, as = "text", encoding = "UTF-8") %>% 
    read_html() %>% 
    html_nodes(xpath = <Fill In>) %>% 
    html_text() # get text from xml nodeset

doc_cleaned <- doc %>% gsub(<Fill In>, "", .)

dat <- matrix(doc_cleaned, ncol = <Fill In>, byrow = TRUE) %>% 
    .[, -c(13:19)] %>% 
    set_colnames(c('期別', '開獎日', '兌獎截止', '銷售金額', '獎金總額', 
                   '獎號_1', '獎號_2', '獎號_3', '獎號_4', '獎號_5', '獎號_6',
                   '特別號' ,'頭獎_中獎注數', '貳獎_中獎注數', '參獎_中獎注數',
                   '肆獎_中獎注數', '伍獎_中獎注數', '陸獎_中獎注數', 
                   '柒獎_中獎注數', '普獎_中獎注數', '頭獎_單注獎金', 
                   '貳獎_單注獎金', '參獎_單注獎金', '肆獎_單注獎金', 
                   '伍獎_單注獎金', '陸獎_單注獎金', '柒獎_單注獎金', 
                   '普獎_單注獎金', '頭獎_累積至次期獎', '貳獎_累積至次期獎金',
                   '參獎_累積至次期獎金', '肆獎_累積至次期獎金', '伍獎_累積至次期獎金')) %>% 
    as.data.frame(stringAsFactors = FALSE)

#' ### Answer
url <- "http://www.taiwanlottery.com.tw/lotto/Lotto649/history.aspx"

res <- GET(url = url)

doc <- content(res, as = "text", encoding = "UTF-8") %>% 
    read_html() %>% 
    html_nodes(xpath = "//td/span") %>% 
    html_text() # get text from xml nodeset

doc_cleaned <- doc %>% gsub(",|\r\n|\\s", "", .)

dat <- matrix(doc_cleaned, ncol = 40, byrow = TRUE) %>% 
    .[, -c(13:19)] %>% 
    set_colnames(c('期別', '開獎日', '兌獎截止', '銷售金額', '獎金總額', 
                   '獎號_1', '獎號_2', '獎號_3', '獎號_4', '獎號_5', '獎號_6',
                   '特別號' ,'頭獎_中獎注數', '貳獎_中獎注數', '參獎_中獎注數',
                   '肆獎_中獎注數', '伍獎_中獎注數', '陸獎_中獎注數', 
                   '柒獎_中獎注數', '普獎_中獎注數', '頭獎_單注獎金', 
                   '貳獎_單注獎金', '參獎_單注獎金', '肆獎_單注獎金', 
                   '伍獎_單注獎金', '陸獎_單注獎金', '柒獎_單注獎金', 
                   '普獎_單注獎金', '頭獎_累積至次期獎', '貳獎_累積至次期獎金',
                   '參獎_累積至次期獎金', '肆獎_累積至次期獎金', '伍獎_累積至次期獎金')) %>% 
    as.data.frame(stringAsFactors = FALSE)


#' ## 台灣彩券 (POST) {.tabset}
#' ### Fill In
get_lottery <- function(<Fill In>, <Fill In>) {
    url <- "http://www.taiwanlottery.com.tw/lotto/Lotto649/history.aspx"
    # get view state and event validation
    res_g <- GET(url = url)
    view_state <- content(res_g) %>% 
        html_nodes("<Fill In>") %>% 
        html_attr("<Fill In>")
    event_validation <- content(res_g) %>% 
        html_nodes("<Fill In>") %>% 
        html_attr("<Fill In>")
    
    form <- list(
        '__EVENTTARGET' = '',
        '__EVENTARGUMENT' =  '',
        '__LASTFOCUS' = '',
        '__VIEWSTATE' =  <Fill In>,
        '__VIEWSTATEGENERATOR' = 'C3E8EA98',
        '__EVENTVALIDATION' =  <Fill In>,
        'Lotto649Control_history$DropDownList1' = '2',
        'Lotto649Control_history$chk' = 'radYM',
        'Lotto649Control_history$dropYear' =  <Fill In>,
        'Lotto649Control_history$dropMonth' =  <Fill In>,
        'Lotto649Control_history$btnSubmit' = '查詢')
    
    res_p <- POST(url = url, 
                  body = form,
                  encode = "form")
    
    doc <- content(res_p, as = "text", encoding = "UTF-8") %>% 
        read_html() %>% 
        html_nodes(xpath = "//td/span") %>% 
        html_text() %>% 
        gsub(",|\r\n|\\s", "", .)
    
    dat <- matrix(doc, ncol = 40, byrow = TRUE) %>% 
        .[, -c(13:19)] %>% ## don't need the order of winning numbers
        as_tibble() %>% 
        set_colnames(c('期別', '開獎日', '兌獎截止', '銷售金額', '獎金總額', 
                       '獎號_1', '獎號_2', '獎號_3', '獎號_4', '獎號_5', '獎號_6',
                       '特別號' ,'頭獎_中獎注數', '貳獎_中獎注數', '參獎_中獎注數',
                       '肆獎_中獎注數', '伍獎_中獎注數', '陸獎_中獎注數', 
                       '柒獎_中獎注數', '普獎_中獎注數', '頭獎_單注獎金', 
                       '貳獎_單注獎金', '參獎_單注獎金', '肆獎_單注獎金', 
                       '伍獎_單注獎金', '陸獎_單注獎金', '柒獎_單注獎金', 
                       '普獎_單注獎金', '頭獎_累積至次期獎', '貳獎_累積至次期獎金',
                       '參獎_累積至次期獎金', '肆獎_累積至次期獎金', '伍獎_累積至次期獎金')) %>% 
        as.data.frame(stringAsFactors = FALSE)
    return(dat)
}
#' ### Answer
get_lottery <- function(year, month) {
    url <- "http://www.taiwanlottery.com.tw/lotto/Lotto649/history.aspx"
    # get view state and event validation
    res_g <- GET(url = url)
    view_state <- content(res_g) %>% 
        html_nodes("#__VIEWSTATE") %>% 
        html_attr("value")
    event_validation <- content(res_g) %>% 
        html_nodes("#__EVENTVALIDATION") %>% 
        html_attr("value")
    
    form <- list(
        '__EVENTTARGET' = '',
        '__EVENTARGUMENT' =  '',
        '__LASTFOCUS' = '',
        '__VIEWSTATE' =  view_state,
        '__VIEWSTATEGENERATOR' = 'C3E8EA98',
        '__EVENTVALIDATION' =  event_validation,
        'Lotto649Control_history$DropDownList1' = '2',
        'Lotto649Control_history$chk' = 'radYM',
        'Lotto649Control_history$dropYear' =  year,
        'Lotto649Control_history$dropMonth' =  month,
        'Lotto649Control_history$btnSubmit' = '查詢')
    
    res_p <- POST(url = url, 
                  body = form,
                  encode = "form")
    
    doc <- content(res_p, as = "text", encoding = "UTF-8") %>% 
        `Encoding<-`("UTF-8") %>% 
        read_html() %>% 
        html_nodes(xpath = "//td/span") %>% 
        html_text() %>% 
        gsub(",|\r\n|\\s", "", .)
    
    dat <- matrix(doc, ncol = 40, byrow = TRUE) %>% 
        .[, -c(13:19)] %>% ## don't need the order of winning numbers
        set_colnames(c('期別', '開獎日', '兌獎截止', '銷售金額', '獎金總額', 
                       '獎號_1', '獎號_2', '獎號_3', '獎號_4', '獎號_5', '獎號_6',
                       '特別號' ,'頭獎_中獎注數', '貳獎_中獎注數', '參獎_中獎注數',
                       '肆獎_中獎注數', '伍獎_中獎注數', '陸獎_中獎注數', 
                       '柒獎_中獎注數', '普獎_中獎注數', '頭獎_單注獎金', 
                       '貳獎_單注獎金', '參獎_單注獎金', '肆獎_單注獎金', 
                       '伍獎_單注獎金', '陸獎_單注獎金', '柒獎_單注獎金', 
                       '普獎_單注獎金', '頭獎_累積至次期獎', '貳獎_累積至次期獎金',
                       '參獎_累積至次期獎金', '肆獎_累積至次期獎金', '伍獎_累積至次期獎金')) %>% 
        as.data.frame(stringAsFactors = FALSE)
    return(dat)
}

#' ## Notes
#' 1. If the data is not table-like, extract it by DOM selector.
#' 2. Use a GET request to get the value of viewstate.
#' 3. Set the value in the body, and get data by a POST request