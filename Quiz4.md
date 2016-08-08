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
