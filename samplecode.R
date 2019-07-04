library(tidyverse)
library(reticulate)


use_python(python = "/usr/local/bin/python3",
           required = TRUE)

Sys.which(names = "python")


py_config()

conda_list()

conda_create("r-reticulate")


use_python(python = "/Users/km/anaconda/envs/r-reticulate/bin/python3",
           required = TRUE)


use_condaenv("r-reticulate")

conda_install("r-reticulate", "spyder")

conda_install("r-reticulate", "pandas")
conda_install("r-reticulate", "scipy")
conda_install("r-reticulate", "numpy")

use_condaenv("r-reticulate")
np <- import("numpy")
pd <- import("pandas")


N <- 15
data.frame(x = 1:N,
           y = rnorm(N)) %>% 
  write.csv("data/sample1.csv", row.names = F)

source_python("python/sample.py")

# pd <- import("pandas")

path <- "data/sample1.csv" 

path %>% 
  pd_read_csv() %>% 
  pd_head()


