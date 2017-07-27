Machine learning and job matching
========================================================
author: Neil Rankin
date: August 2017
autosize: true


Outline
========================================================

- What is machine learning (ML)?

- Can we apply this in a South African labour market environment?

- Building a prototype ML algorithm



What is machine learning (ML)?
=======================================================


Applying this in a South African labour market environment
=======================================================


Building a prototype ML algorithm (for employment)
=======================================================

Steps: 
 
 1. Split the dataset between training and testing
 2. Train a model on the training data
    + OLS
    + Logit
 3. Evaluate it on the test data
 
See the do file, R script
 

ML algorithm, step 1
=======================================================

Split the data into a training and testing dataset
 
1. Set the random number seed
2. Generate a random number
3. Split into training and testing

ML algorithm, step 1 (STATA)
=======================================================

`set seed 12345 
`ssc install randomtag 
`randomtag 

ML algorithm, step 1 (R)
=======================================================


```r
summary(cars)
```

```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```



Example slides
========================================================


For more details on authoring R presentations please visit <https://support.rstudio.com/hc/en-us/articles/200486468>.

- Bullet 1
- Bullet 2
- Bullet 3

Slide With Code
========================================================


```r
summary(cars)
```

```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

Slide With Plot
========================================================

![plot of chunk unnamed-chunk-3](machine_learning_and_matching-figure/unnamed-chunk-3-1.png)
