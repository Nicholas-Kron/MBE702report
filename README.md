# MBE702report

This R package automates the construction of html reports for MBE702 survey data from the .csv files generated from the google questionnaire. Meant to be used by MBE student representatives only.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

To use this package, you will need a Bioconductor packages first. You can install it by using the following commands:

```
#ComplexHeatmap
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ComplexHeatmap")

```

### Installing

You will have to install this package from Github to use it.  
Start by installing the devtools package if you do not already have it

```
install.packages("devtools")
```

The load the devtools package and install the MBE702 report package from the Github repository

```
library(devtools)
install_github("Nicholas-Kron/MBE702report")
```

and finally load the MBE702 report package to use

```
library(MBE702report)
```

### Usage

To generate a report simply call the function below with the path to the MBE702 survey .csv file.
```
MBE702report::build_report(~/Desktop/MBE702/2019/Fall/test.csv
```

### Author
* Nicholas Kron