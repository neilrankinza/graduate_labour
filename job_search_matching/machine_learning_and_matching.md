Machine learning and job matching
========================================================
author: Neil Rankin
date: August 2017
autosize: true


Goal
========================================================

- Can we build a 'machine learning' algorithm to identify young people who are likely to become employed in South Africa?


Outline
========================================================

- What is machine learning (ML)?

- Can we apply this in a South African labour market environment?

- Building a prototype ML algorithm



What is machine learning (ML)?
=======================================================

'Machine learning is the subfield of computer science that, according to Arthur Samuel, gives "computers the ability to learn without being explicitly programmed"... Evolved from the study of pattern recognition and computational learning theory in artificial intelligence, machine learning explores the study and construction of algorithms that can learn from and make predictions on data – such algorithms overcome following strictly static program instructions by making data-driven predictions or decisions, through building a model from sample inputs. Machine learning is employed in a range of computing tasks where designing and programming explicit algorithms with good performance is difficult or infeasible; example applications include email filtering, detection of network intruders or malicious insiders working towards a data breach, optical character recognition (OCR), learning to rank, and computer vision.'

[Wikipedia](https://en.wikipedia.org/wiki/Machine_learning)

Applying this in a South African labour market environment
=======================================================

(**Harambee Youth Employment Accelerator**)[http://harambee.co.za/harambee/] is an organisation which brings together young people, who are marginalised in the labour market, and employers looking for entry-level recruits.

Their reputation depends on finding good, but overlooked, candidates. They need a mechanism to find these candidates? Can we help?


The Harambee process
=======================================================

1. 'Source' people either through actively recruiting or through sign-ups trhough a mobile site
2. Invite people to further assessments and support:

    + 'Work-seeker support' which includes interview preparation, help with job search etc
    + 'Learning Potential' or CFT. A non-verbal reasoning test.
    + Numeracy test (a number of different variants, not all candidates get this)
    + Communications test (not all candidates get this)
3. 'Bridge' with job-specific skills
4. Facilitate placement (for those going through the whole process), or self-placement (who find a job after work-seeker support)

Can we find characteristics which can help to pick candidates to go through this process?

Building a prototype ML algorithm (for employment)
=======================================================

Steps: 
 
 1. Split the dataset between training and testing
 2. Train a model on the training data
    + OLS
    + Logit (?)
    + Random forest (?)
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
