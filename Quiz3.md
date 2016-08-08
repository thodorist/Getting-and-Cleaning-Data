Question 1
==========

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using `download.file()` from here:

<http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv>

and load the data into R. The code book, describing the variable names is here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf>

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the `which()` function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical)

What are the first 3 values that result?

``` r
#########################################################################
#### Download the csv file and save it in the working directory      ####
#### in a file called "data" where the downloaded csv file is called ####
#### "housingdata".                                                  ####
#########################################################################
if(!file.exists("./data")){dir.create("./data")}
fileURL<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
destination<-paste0("./data", "/housingdata.csv")
download.file(fileURL, destfile = destination)
houseDATA<-read.csv("./data/housingdata.csv")

#######################################################################
#### Based on the provided CODEBOOK, "ACR" is the column           ####
#### which refers to the lot size. In addition, the numerical      ####
#### value "3" corresponds to households with 10 acres or greater. ####
#### The sales of agricultural products is described by            ####
#### the variable "AGS". In addition, the numerical value "6"      ####
#### corresponds to sales of more than $10,000.                    ####
#######################################################################
agricultureLogical<-houseDATA$ACR==3 & houseDATA$AGS==6

####################################
#### Display the first 3 values ####
####################################
head(which(agricultureLogical), n=3)
```

    ## [1] 125 238 262

Question 2
==========

Using the `jpeg` package read in the following picture of your instructor into R

<https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg>

Use the parameter `native=TRUE`. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

For part of the code below see <http://stackoverflow.com/questions/17918330/how-to-directly-read-an-image-file-from-a-url-address-in-r>

``` r
library(jpeg)
myurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
t <- tempfile()
download.file(myurl,t,mode="wb")

#######################################
#### Use the parameter native=TRUE ####
#######################################
img <- readJPEG(t, native = TRUE)
file.remove(t) 
```

    ## [1] TRUE

``` r
#######################################################
#### 30th and 80th quantiles of the resulting data ####
#######################################################
quantile(img, probs = c(0.3, 0.8))
```

    ##       30%       80% 
    ## -15259150 -10575416

Question 3
==========

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>

Load the educational data from this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv>

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

Original data sources:

<http://data.worldbank.org/data-catalog/GDP-ranking-table>

<http://data.worldbank.org/data-catalog/ed-stats>

``` r
#######################################################################
#### Download the csv files and save them in the working directory ####
#### in a file called "data" where the downloaded csv files are    ####
#### called "education" and "GDP".                                 ####
#######################################################################
fileURL1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
fileURL2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
destination1<-paste0("./data", "/education.csv")
destination2<-paste0("./data", "/GDP.csv")
download.file(fileURL1, destfile = destination1)
download.file(fileURL2, destfile = destination2)
eduDATA<-read.csv(destination1)
gdpDATA<-read.csv(destination2, skip = 4, nrows = 190 )

###############################################################
#### The input all = FALSE(default) in the merge() command ####
#### is important since otherwise it would include         ####
#### countries that do not appear in both datasets         ####
###############################################################
mergedData<-merge(gdpDATA, eduDATA, by.x = "X", by.y ="CountryCode", all = FALSE)
nrow(mergedData)
```

    ## [1] 189

``` r
#############################################################
#### Sort the data frame in descending order by GDP rank ####
#### (so United States is last).                         ####
#############################################################
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.2.5

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
head(mergedData%>%
  select(X, X.1, X.3, X.4)%>%
  arrange(desc(X.1)), n= 13)
```

    ##      X X.1                            X.3   X.4
    ## 1  TUV 190                         Tuvalu   40 
    ## 2  KIR 189                       Kiribati  175 
    ## 3  MHL 188               Marshall Islands  182 
    ## 4  PLW 187                          Palau  228 
    ## 5  STP 186          São Tomé and Principe  263 
    ## 6  FSM 185          Micronesia, Fed. Sts.  326 
    ## 7  TON 184                          Tonga  472 
    ## 8  DMA 183                       Dominica  480 
    ## 9  COM 182                        Comoros  596 
    ## 10 WSM 181                          Samoa  684 
    ## 11 VCT 180 St. Vincent and the Grenadines  713 
    ## 12 GRD 178                        Grenada  767 
    ## 13 KNA 178            St. Kitts and Nevis  767

Hence, the 13-nth country is St. Kitts and Nevis.

Question 4
==========

What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

``` r
##################################################################
#### We will group the dataset based on "Income.Group" column ####
##################################################################
groupedDATA<-group_by(mergedData, Income.Group)

########################################
#### Get the average for each group ####
########################################
summarize(groupedDATA, mean(X.1))
```

    ## # A tibble: 5 x 2
    ##           Income.Group mean(X.1)
    ##                 <fctr>     <dbl>
    ## 1 High income: nonOECD  91.91304
    ## 2    High income: OECD  32.96667
    ## 3           Low income 133.72973
    ## 4  Lower middle income 107.70370
    ## 5  Upper middle income  92.13333

Question 5
==========

Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

``` r
######################################################################
#### There was a problem b.c the class of mergedData$CountryCode  ####
#### is a factor and the function cut can only receive as input   ####
#### numeric values.                                              ####
#### Hence we used the notation mergedData[, 2]                   ####
######################################################################

mergedData$rankinGroups<-cut(mergedData[, 2], 
                              breaks = quantile(mergedData[, 2], 
                                                probs = seq(0, 1, by = 0.2)))
##########################################
#### Make a table versus Income.Group ####
##########################################
table(mergedData$rankinGroups, mergedData$Income.Group, useNA = "ifany")
```

    ##              
    ##                  High income: nonOECD High income: OECD Low income
    ##   (1,38.6]     0                    4                17          0
    ##   (38.6,76.2]  0                    5                10          1
    ##   (76.2,114]   0                    8                 1          9
    ##   (114,152]    0                    4                 1         16
    ##   (152,190]    0                    2                 0         11
    ##   <NA>         0                    0                 1          0
    ##              
    ##               Lower middle income Upper middle income
    ##   (1,38.6]                      5                  11
    ##   (38.6,76.2]                  13                   9
    ##   (76.2,114]                   11                   8
    ##   (114,152]                     9                   8
    ##   (152,190]                    16                   9
    ##   <NA>                          0                   0

Thus, 5 countries were among the 38 nations with highest GDP.
