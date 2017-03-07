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
