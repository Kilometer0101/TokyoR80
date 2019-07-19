---
title: "Random"
author: "km"
date: "2019/7/19"
output: 
  html_document: 
    keep_md: TRUE
---




## uniform distribution

### in R


```r
seed <- 71
N <- 100000

unif_R <- runif(N)

unif_R %>% head(10)
```

```
##  [1] 0.24692638 0.62378240 0.08519384 0.33878806 0.71709901 0.18513081
##  [7] 0.33717573 0.29119696 0.23748727 0.16339159
```

```r
unif_R %>% mean()
```

```
## [1] 0.5005941
```


### in Numpy


```python
import numpy as np

seed = int(r.seed)
N = int(r.N)

np.random.seed(seed=seed)
unif_np = np.random.rand(N)

unif_np[:10]
```

```
## array([0.18557527, 0.3865993 , 0.8318962 , 0.19869745, 0.91655797,
##        0.7883107 , 0.72260428, 0.99569452, 0.84537214, 0.23372659])
```

```python
np.mean(unif_np)
```

```
## 0.5004221912035725
```

### in python random


```python
import random

random.seed(seed)

unif_rd = np.array([random.random() for i in range(N)])

unif_rd[:20]
```

```
## array([0.32375335, 0.62002949, 0.00848   , 0.98285779, 0.82215851,
##        0.99901979, 0.2633503 , 0.19948865, 0.05473797, 0.19380238,
##        0.02418572, 0.69173803, 0.3656697 , 0.81556164, 0.76067203,
##        0.34932434, 0.1667997 , 0.34767461, 0.03029517, 0.64832587])
```


### in R


```r
seed <- 71
N <- 100000

rd <- import("random")
rd$seed(seed)
unif_R <- map_dbl(1:N, ~rd$random())
```


### in python random


```python
import random
N = int(r.N)
seed = int(r.seed)

random.seed(seed)
unif_P = np.array([random.random() for i in range(N)])
```


```r
pyenv <- import_main() 
unif_P <- pyenv$unif_P

sum(unif_R - unif_P)
```

```
## [1] 0
```
