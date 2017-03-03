library(dplyr)
library(readr)

import_data <- function(dir_path) {
    .data <- lapply(list.files(normalizePath(<fill in >), full.names = TRUE), <fill in >) %>% 
        <fill in >()
    return(.data)
}

clean_data <- function(.data, cyl) {
    if (<fill in >) stop("Input data must be a dataframe!")
    if (<fill in >) stop("cyl must be 4, 6 or 8.")
    
    if (cyl == 4) {
        .data <- .data %>% 
            filter(<fill in >)
        return(.data)
    } else if (cyl == 6) {
        .data <- .data %>% 
            filter(<fill in >)
        return(.data)
    } else if (cyl == 8) {
        .data <- .data %>% 
            filter(<fill in >) %>% 
            filter(between(<fill in >, 
                           quantile(<fill in >, probs = 0.01),
                           quantile(<fill in >, probs = 0.99)))
        return(.data)
    } 
}

get_fitted <- function(.data, formula = NULL) {
    if (<fill in >) stop("Input data must be a dataframe!")
    if (<fill in >) stop("formula cannot be null.")
    
    mod <- lm(formula = <fill in >, data = .data)
    return(mod$<fill in >)
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
