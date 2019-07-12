library(tidyverse)
library(reticulate)


pyenv <- "/Users/km/python/test2/.venv/bin/python3.7"

use_python(python = pyenv, required = TRUE)

use_python(python = ".venv/bin/python3.7",
           required = TRUE)


Sys.which(names = "python")

py_config()


# create a new environment 
virtualenv_create("r-reticulate")


use_virtualenv("r-reticulate")


py_config()



virtualenv_create("r-reticulate")

virtualenv_list()



conda_list()


conda_create("r-reticulate")

# R reboot: command + shift + 0

conda_list()

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

set.seed(71)
N <- 15
data.frame(x = 1:N,
           y = rnorm(N),
           z = sample(letters[1:3], N, replace = TRUE)) %>% 
  write.csv("data/sample1.csv", row.names = F)

source_python("python/sample.py")


path <- "data/sample1.csv" 

path %>% 
  pd_load_csv() -> a

os <- import("os")


pd <- import("pandas")

pd$read_csv(path)

