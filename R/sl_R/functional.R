# 2. 
formulas <- list(
    mpg ~ disp,
    mpg ~ disp + wt
)
lapply(formulas, 
       function(x) lm(formula = x, data = mtcars))
# 3.
sapply(1:9,
       function(x) x * 1:9)
# 4. 
tapply(iris$Sepal.Length, iris$Species, range)
