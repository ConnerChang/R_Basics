#' ---
#' title: "Build Functions with the mtcars Dataset"
#' author: ""
#' date: "`r Sys.Date()`"
#' output: 
#'   html_document: 
#'     toc: yes
#' ---

#+ include=FALSE
knitr::opts_chunk$set(eval = FALSE)

#' # Build Functions {.tabset}
#' ## Fill In 
library(dplyr)
library(readr)

import_data <- function(dir_path) {
    .data <- lapply(list.files(normalizePath(<fill in>), full.names = TRUE), <fill in >) %>% 
        <fill in>()
    return(.data)
}

clean_data <- function(.data, cyl) {
    if (<fill in>) stop("Input data must be a dataframe!")
    if (<fill in>) stop("cyl must be 4, 6 or 8.")
    
    if (cyl == 4) {
        .data <- .data %>% 
            filter(<fill in>)
        return(.data)
    } else if (cyl == 6) {
        .data <- .data %>% 
            filter(<fill in>)
        return(.data)
    } else if (cyl == 8) {
        .data <- .data %>% 
            filter(<fill in>) %>% 
            filter(between(<fill in >, 
                           quantile(<fill in>, probs = 0.01),
                           quantile(<fill in>, probs = 0.99)))
        return(.data)
    } 
}

get_fitted <- function(.data, formula = NULL) {
    if (<fill in>) stop("Input data must be a dataframe!")
    if (<fill in>) stop("formula cannot be null.")
    
    mod <- lm(formula = <fill in>, data = .data)
    return(mod$<fill in>)
}
# ----------------------------------------------------------
import_data(dir_path = "data/mtcars") %>% 
    clean_data(cyl = 4) %>% 
    get_fitted(formula = mpg ~ wt)

import_data(dir_path = "data/mtcars") %>% 
    clean_data(cyl = 6) %>% 
    get_fitted(formula = mpg ~ wt)

import_data(dir_path = "data/mtcars") %>% 
    clean_data(cyl = 8) %>% 
    get_fitted(formula = mpg ~ wt)

#' ## Answers
library(dplyr)
library(readr)

import_data <- function(dir_path) {
    .data <- lapply(list.files(normalizePath(dir_path), full.names = TRUE), read_csv) %>% 
        bind_rows()
    return(.data)
}

clean_data <- function(.data, cyl) {
    if (!is.data.frame(.data)) stop("Input data must be a dataframe!")
    if (!cyl %in% c(4, 6, 8)) stop("cyl must be 4, 6 or 8.")
    
    if (cyl == 4) {
        .data <- .data %>% 
            filter(cyl == 4 & vs == 1)
        return(.data)
    } else if (cyl == 6) {
        .data <- .data %>% 
            filter(cyl == 6)
        return(.data)
    } else if (cyl == 8) {
        .data <- .data %>% 
            filter(cyl == 8) %>% 
            filter(between(qsec, 
                           quantile(qsec, probs = 0.01),
                           quantile(qsec, probs = 0.99)))
        return(.data)
    } 
}

get_fitted <- function(.data, formula = NULL) {
    if (!is.data.frame(.data)) stop("Input data must be a dataframe!")
    if (is.null(formula)) stop("formula cannot be null.")
    
    mod <- lm(formula = formula, data = .data)
    return(mod$fitted.values)
}
# ----------------------------------------------------------
import_data(dir_path = "data/mtcars") %>% 
    clean_data(cyl = 4) %>% 
    get_fitted(formula = mpg ~ wt)

import_data(dir_path = "data/mtcars") %>% 
    clean_data(cyl = 6) %>% 
    get_fitted(formula = mpg ~ wt)

import_data(dir_path = "data/mtcars") %>% 
    clean_data(cyl = 8) %>% 
    get_fitted(formula = mpg ~ wt)
