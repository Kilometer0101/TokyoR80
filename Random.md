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
##  [1] 0.6252961 0.7893059 0.8414737 0.6412125 0.4606747 0.7140931 0.3831216
##  [8] 0.6229473 0.3758558 0.8833103
```

```r
unif_R %>% mean()
```

```
## [1] 0.4990474
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

unif_rd[:10]
```

```
## array([0.32375335, 0.62002949, 0.00848   , 0.98285779, 0.82215851,
##        0.99901979, 0.2633503 , 0.19948865, 0.05473797, 0.19380238])
```

```python
np.mean(unif_rd)
```

```
## 0.5000350862281858
```


### in R


```r
seed <- 71
N <- 20

rd <- import("random")
rd$seed(seed)
map_dbl(1:N, ~rd$random())
```

```
##  [1] 0.323753346 0.620029485 0.008479999 0.982857787 0.822158506
##  [6] 0.999019788 0.263350301 0.199488651 0.054737975 0.193802375
## [11] 0.024185723 0.691738028 0.365669697 0.815561641 0.760672026
## [16] 0.349324336 0.166799702 0.347674613 0.030295174 0.648325872
```


### in python random


```python
import random
N = int(r.N)
seed = int(r.seed)

random.seed(seed)
np.array([random.random() for i in range(N)])
```

```
## array([0.32375335, 0.62002949, 0.00848   , 0.98285779, 0.82215851,
##        0.99901979, 0.2633503 , 0.19948865, 0.05473797, 0.19380238,
##        0.02418572, 0.69173803, 0.3656697 , 0.81556164, 0.76067203,
##        0.34932434, 0.1667997 , 0.34767461, 0.03029517, 0.64832587])
```

