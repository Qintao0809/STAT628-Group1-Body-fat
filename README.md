# STAT628-Group1-Body-fat

### Authors

* Fangfei Lin
* Lu Chen
* Qintao Ying
* Yansong Mao

### Introduction

The goal of this project is to come up with a simple, robust, accurate and precise  “rule-of-thumb” method to estimate percentage of body fat using clinically available measurements. Our “rule-of-thumb” is based on a real data set of 252 men with measurements of their percentage of body fat and various body circumference measurements. We did data cleaning, variable selection, model diagnostic, and finally we computed our rule of thumb:

`
BODYFAT (%) = 0.89 * ABDOMEN (cm) - 0.12 * WEIGHT (lbs) - 41.55
`

### Contents of this Repository

**Files:**
* `STA 628 Project.ipynb` is our R code and analysis of this project
* `app.R` is a web application of body fat calculator
* `slides.pdf` is our presentation slides

**Folders:**
* `Code/` contains all the code files we used for this project
* `Data/` contains the raw dataset and the "clean" dataset.
* `Image/` contains plots we used for this project
