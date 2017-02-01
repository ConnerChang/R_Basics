# 1.
# create a list of dataframes
list_of_dfs <- list(data.frame(a = 1:3, b = 2:4), data.frame(a = 4:6, b = 5:7))

# create a dataframe with a column consists of dataframes
df_of_dfs <- data.frame(type = c("M", "F"), 
                    data = list(data.frame(a = 1:3, b = 2:4), data.frame(a = 4:6, b = 5:7)))

# create a tibble with a column consists of tibbles
tbl_of_tbls <- tibble(type = c("M", "F"), 
                    data = list(tibble(a = 1:3, b = 2:4), tibble(a = 4:6, b = 5:7)))

# compare "tbl_of_tbls" with the following tibble
unnested_tbl <- tibble(type = c(rep("M", 3), rep("F", 3)), a = 1:6, b = 2:7)

# 3.
(x <- list(a = 1:3, b = c("a", "b", "c")))
typeof(unlist(x))

# 4.
colnames(iris) <- paste("x", 1:5, sep = "_")
iris <- iris[, -4]
iris_f  <- iris[iris$x_1 > median(iris$x_1) & iris$x_2 > 2, ]
table(iris_f$x_5)
