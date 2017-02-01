library(tidyr)
library(magrittr)
library(readr)
library(readxl)

# 1. 
rate <- read_csv("data/rate.csv") %>% as_tibble()
rate %>% 
    gather(key = type, value = price, 2:3)
# or
rate %>% 
    gather(key = type, value = price, -date)
# 2. 
roe <- read_excel("data/ROEFINAL.xlsx")
roe %>% 
    gather(key = year, value = roe, 3:5)
# 3. 
yoy <- read_excel("data/yoy_104.xlsx")
yoy %>% 
    gather(key = month, value = yoy, -c(1:2))
