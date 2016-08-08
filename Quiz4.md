Question 1
==========

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using `download.file()` from here:

<http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv>

and load the data into R. The code book, describing the variable names is here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf>

Apply `strsplit()` to split all the names of the data frame on the characters "wgtp".

What is the value of the 123 element of the resulting list?

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
#################################################
#### Check the names of the last 6 variables ####
#################################################
tail(names(houseDATA))
```

    ## [1] "wgtp75" "wgtp76" "wgtp77" "wgtp78" "wgtp79" "wgtp80"

``` r
#########################################
#### Split the names based on "wgtp" ####
#########################################
splitNAMES<-strsplit(names(houseDATA), "\\wgtp")
##################################################
#### Get a glimpse of the change we performed ####
##################################################
tail(splitNAMES)
```

    ## [[1]]
    ## [1] ""   "75"
    ## 
    ## [[2]]
    ## [1] ""   "76"
    ## 
    ## [[3]]
    ## [1] ""   "77"
    ## 
    ## [[4]]
    ## [1] ""   "78"
    ## 
    ## [[5]]
    ## [1] ""   "79"
    ## 
    ## [[6]]
    ## [1] ""   "80"

``` r
################################
#### Get the 123-rd element ####
################################
splitNAMES[[123]]
```

    ## [1] ""   "15"

Question 2
==========

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

Original data sources:

<http://data.worldbank.org/data-catalog/GDP-ranking-table>

``` r
#########################################################################
#### Download the csv file and save it in the working directory      ####
#### in a file called "data" where the downloaded csv file is called ####
#### "GDP".                                                          ####
#########################################################################

if(!file.exists("./data")){dir.create("./data")}
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
destination<-paste0("./data", "/GDP.csv")
download.file(fileURL, destfile = destination)

###############################################################
#### The file was first opened with EXCEL in order to      ####
#### determine how many rows would be skipped and how many ####
#### rows would be read. Hence "skip" was set to 4 and     ####
#### "nrows" was set to 190.                               ####
###############################################################
gdpDATA<-read.csv("./data/GDP.csv", skip = 4, nrows = 190)
####################################################
#### Check the the first 6 rows of the table    ####
#### in order to get some intuition of the data ####
####################################################
head(gdpDATA)
```

    ##     X X.1 X.2            X.3          X.4 X.5 X.6 X.7 X.8 X.9
    ## 1 USA   1  NA  United States  16,244,600       NA  NA  NA  NA
    ## 2 CHN   2  NA          China   8,227,103       NA  NA  NA  NA
    ## 3 JPN   3  NA          Japan   5,959,718       NA  NA  NA  NA
    ## 4 DEU   4  NA        Germany   3,428,131       NA  NA  NA  NA
    ## 5 FRA   5  NA         France   2,612,878       NA  NA  NA  NA
    ## 6 GBR   6  NA United Kingdom   2,471,784       NA  NA  NA  NA

``` r
#########################
#### Make the change ####
#########################
gdp<-as.numeric(gsub(",", "", gdpDATA[, "X.4"]))
###################################################
#### Confirm that the change we wanted to make ####
#### has been performed.                       ####
###################################################
head(gdp)
```

    ## [1] 16244600  8227103  5959718  3428131  2612878  2471784

``` r
##########################
#### Find the Average ####
##########################
mean(gdp)
```

    ## [1] 377652.4

Question 3
==========

In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

``` r
###################################################
#### Name the 4-th column of the data set with #### 
#### "countryNames". This column includes  the ####
#### names of the countries                    ####
###################################################
names(gdpDATA)[names(gdpDATA)=="X.3"] <- "countryNames"

############################################
#### Check the new names of the columns ####
############################################
names(gdpDATA)
```

    ##  [1] "X"            "X.1"          "X.2"          "countryNames"
    ##  [5] "X.4"          "X.5"          "X.6"          "X.7"         
    ##  [9] "X.8"          "X.9"

``` r
########################################################
#### Get the indices of those countries whose names ####
#### begin with "United"                            ####
########################################################
grep("^United", gdpDATA[, "countryNames"])
```

    ## [1]  1  6 32

``` r
#########################################################
#### Count the total number of countries whose names ####
#### begin with "United                              ####
#########################################################
length(grep("^United", gdpDATA[, "countryNames"]))
```

    ## [1] 3

Question 4
==========

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>

Load the educational data from this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv>

Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

Original data sources:

<http://data.worldbank.org/data-catalog/GDP-ranking-table>

<http://data.worldbank.org/data-catalog/ed-stats>

``` r
####################################################################
#### The GDP dataset has already been loaded.                   ####
#### Hence, we will only load the educational dataset.          ####
#### Download the csv file and save it in the working directory ####
#### in a file called "data" where the downloaded csv file is   ####
#### called "education"                                         ####
####################################################################
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
destination<-paste0("./data", "/education.csv")
download.file(fileURL, destfile = destination)
eduDATA<-read.csv("./data/education.csv")

################################################
#### Check the names of the columns in both ####
#### datasets                               ####
################################################
head(names(gdpDATA)); head(names(eduDATA))
```

    ## [1] "X"            "X.1"          "X.2"          "countryNames"
    ## [5] "X.4"          "X.5"

    ## [1] "CountryCode"      "Long.Name"        "Income.Group"    
    ## [4] "Region"           "Lending.category" "Other.groups"

``` r
###############################################################
#### The input all = FALSE(default) in the merge() command ####
#### is important since otherwise it would include         ####
#### countries that do not appear in both datasets         ####
###############################################################
matchedData<-merge(gdpDATA, eduDATA, by.x = "X", by.y ="CountryCode", all = FALSE)

####################################################################
#### The following command will try to match expressions        ####
#### which contain "Fiscal" followed by any pattern of strings  ####
#### and ending with "June". The resulting vector will show the ####
#### indices of those expressions, i.e the position in which    ####
#### these expressions are found in the "Special.Notes" column  ####
####################################################################
grep("Fiscal(.*)June", matchedData$Special.Notes)
```

    ##  [1]   9  16  29  51  65  89  96 133 140 152 159 175 189

``` r
###############################################
#### Count the total number of repetitions ####
###############################################
length(grep("Fiscal(.*)June", matchedData$Special.Notes))
```

    ## [1] 13

Question 5
==========

You can use the quantmod (<http://www.quantmod.com/>) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.

> library(quantmod)

> amzn = getSymbols("AMZN",auto.assign=FALSE)

> sampleTimes = index(amzn)

How many values were collected in 2012? How many values were collected on Mondays in 2012?

``` r
library(quantmod)
```

    ## Warning: package 'quantmod' was built under R version 3.2.5

    ## Loading required package: xts

    ## Warning: package 'xts' was built under R version 3.2.5

    ## Loading required package: zoo

    ## Warning: package 'zoo' was built under R version 3.2.5

    ## 
    ## Attaching package: 'zoo'

    ## The following objects are masked from 'package:base':
    ## 
    ##     as.Date, as.Date.numeric

    ## Loading required package: TTR

    ## Warning: package 'TTR' was built under R version 3.2.5

    ## Version 0.4-0 included new data defaults. See ?getSymbols.

``` r
amzn = getSymbols("AMZN", auto.assign=FALSE)
```

    ##     As of 0.4-0, 'getSymbols' uses env=parent.frame() and
    ##  auto.assign=TRUE by default.
    ## 
    ##  This  behavior  will be  phased out in 0.5-0  when the call  will
    ##  default to use auto.assign=FALSE. getOption("getSymbols.env") and 
    ##  getOptions("getSymbols.auto.assign") are now checked for alternate defaults
    ## 
    ##  This message is shown once per session and may be disabled by setting 
    ##  options("getSymbols.warning4.0"=FALSE). See ?getSymbols for more details.

    ## Warning in download.file(paste(yahoo.URL, "s=", Symbols.name, "&a=",
    ## from.m, : downloaded length 168510 != reported length 200

``` r
sampleTimes = index(amzn)

####################################################
#### Get the class of the variable "sampleTimes ####
####################################################
class(sampleTimes)
```

    ## [1] "Date"

``` r
###############################################
#### Extract the YEAR part of the variable ####
###############################################
years<-format(sampleTimes, "%Y")

####################################################################
#### The logical operator inside the parenthesis will           ####
#### give us a vector of TRUES AND FALSES.                      ####
#### Summing this vector will give us the number of values      ####
#### that were collected in 2012(Since TRUE is represented by 1 ####
#### and FALSE by 0 respectively)                               ####
####################################################################
sum(years=="2012")
```

    ## [1] 250

``` r
##############################################
#### Extract the DAY part of those values ####
#### that were collected in 2012          ####
##############################################
Mondays2012<-format(sampleTimes[years=="2012"], "%A")

##########################################################
#### Summing, finally, gives us the number of Mondays ####
##########################################################
sum(Mondays2012=="Monday")
```

    ## [1] 47
