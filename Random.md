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
##  [1] 0.01484964 0.62136735 0.88018837 0.63737466 0.38433774 0.88634772
##  [7] 0.04701456 0.87467506 0.03246001 0.40081648
```

```r
unif_R %>% mean()
```

```
## [1] 0.5006737
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

### in Random


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
