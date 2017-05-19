# the first way 
l <- lapply(3320:3321, get_stock_price)
l <- setNames(l, 3320:3321)
result <- dplyr::bind_rows(l, .id = "stock")

# another way
l2 <- sapply(as.character(3320:3340), 
            get_stock_price, 
            simplify = FALSE, 
            USE.NAMES = TRUE)
result2 <- dplyr::bind_rows(l2, .id = "stock")

identical(result, result2)
