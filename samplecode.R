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

pd_load_csv()

path <- "data/sample2.csv" 


dat <- pd_load_csv(path) %>%
  pd_head(5)


a %>% pd_head()

pd_head(iris)

iris %>% pd_head


N <- 10000
data.frame(x = 1:N,
           y = rnorm(N),
           y2 = rnorm(N),
           z = rnorm(N)) %>% 
  write.csv("data/sample2.csv", row.names = F)

path <- "data/sample2.csv"

system.time({pd_load_csv(path)})

system.time({read.csv(path)})

system.time({read_csv(path)})


library(data.table)
system.time({fread(path, data.table = F)})


f_pd <- function(path) pd_load_csv(path)
f_base <- function(path) read.csv(path)
f_readr <- function(path) readr::read_csv(path)
f_fread <- function(path) data.table::fread(path)

library(microbenchmark)
mbm <- microbenchmark(
  pd_in_R = f_pd(path), 
  read.csv = f_base(path), 
  read_csv = f_readr(path), 
  fread = f_fread(path))

autoplot(mbm)

mbm %>% data.frame() %>% mutate(time = time/10^9) %>% 
  ggplot(aes(expr, log10(time)))+
  geom_violin()+
  coord_flip()+
  theme(axis.title.y = element_blank(),
        text = element_text(size = 21))

ggsave("fig/benchmark_readcsv.png", width = 6, height =4)


py$result %>%  data.frame(expr = "pd_in_py", time = .) %>%
  rbind(data.frame(mbm) %>%
          mutate(time = time/10^9)) %>%
  ggplot(aes(expr, time))+
  geom_violin()+
  coord_flip()+
  theme(axis.title.y = element_blank(),
        text = element_text(size = 21))


ggsave("fig/benchmark_pd.png", width = 6, height =4)

path %>% 
  pd_load_csv() -> a

os <- import("os")


pd <- import("pandas")

pd$read_csv(path)

