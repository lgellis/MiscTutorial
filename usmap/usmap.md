------------------------------------------------------------------------

title: “usmap” author: “Laura Ellis” date: “11/27/2019” output:
md\_document: variant: markdown\_github —

Tutorial
--------

The full tutorial and description is available at
[littlemissdata.com](https://www.littlemissdata.com/blog)

Install and Load Packages
-------------------------

Check for packages installed, install if needed and load package. I
found this code off of [Vikram Baliga’s
blog](https://www.vikram-baliga.com/blog/2015/7/19/a-hassle-free-way-to-verify-that-r-packages-are-installed-and-loaded)

``` r
#specify the packages of interest
packages = c("gtrendsR","tidyverse","usmap")

#use this function to check if each package is on the local machine
#if a package is installed, it will be loaded
#if any are not, the missing package(s) will be installed and loaded
package.check <- lapply(packages, FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
        install.packages(x, dependencies = TRUE)
        library(x, character.only = TRUE)
    }
})
```

    ## Loading required package: gtrendsR

    ## Loading required package: tidyverse

    ## ── Attaching packages ─────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.2.0     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

    ## ── Conflicts ────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

    ## Loading required package: usmap

``` r
#verify they are loaded
search()
```

    ##  [1] ".GlobalEnv"        "package:usmap"     "package:forcats"  
    ##  [4] "package:stringr"   "package:dplyr"     "package:purrr"    
    ##  [7] "package:readr"     "package:tidyr"     "package:tibble"   
    ## [10] "package:ggplot2"   "package:tidyverse" "package:gtrendsR" 
    ## [13] "package:stats"     "package:graphics"  "package:grDevices"
    ## [16] "package:utils"     "package:datasets"  "package:methods"  
    ## [19] "Autoloads"         "package:base"

``` r
#Set some variables

orange <- "#C9592E"
```

Get thanksgiving trends
-----------------------

This is an R Markdown document. Markdown is a simple formatting syntax
for authoring HTML, PDF, and MS Word documents. For more details on
using R Markdown see
<a href="http://rmarkdown.rstudio.com" class="uri">http://rmarkdown.rstudio.com</a>.

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this:

``` r
thanksgiving <- gtrends("thanksgiving",geo = "US", time = "now 1-d") # last day
head(thanksgiving)
```

    ## $interest_over_time
    ##                    date hits geo    time      keyword gprop category
    ## 1   2019-11-26 16:00:00   64  US now 1-d thanksgiving   web        0
    ## 2   2019-11-26 16:08:00   64  US now 1-d thanksgiving   web        0
    ## 3   2019-11-26 16:16:00   60  US now 1-d thanksgiving   web        0
    ## 4   2019-11-26 16:24:00   62  US now 1-d thanksgiving   web        0
    ## 5   2019-11-26 16:32:00   61  US now 1-d thanksgiving   web        0
    ## 6   2019-11-26 16:40:00   59  US now 1-d thanksgiving   web        0
    ## 7   2019-11-26 16:48:00   59  US now 1-d thanksgiving   web        0
    ## 8   2019-11-26 16:56:00   58  US now 1-d thanksgiving   web        0
    ## 9   2019-11-26 17:04:00   58  US now 1-d thanksgiving   web        0
    ## 10  2019-11-26 17:12:00   58  US now 1-d thanksgiving   web        0
    ## 11  2019-11-26 17:20:00   59  US now 1-d thanksgiving   web        0
    ## 12  2019-11-26 17:28:00   59  US now 1-d thanksgiving   web        0
    ## 13  2019-11-26 17:36:00   59  US now 1-d thanksgiving   web        0
    ## 14  2019-11-26 17:44:00   58  US now 1-d thanksgiving   web        0
    ## 15  2019-11-26 17:52:00   57  US now 1-d thanksgiving   web        0
    ## 16  2019-11-26 18:00:00   58  US now 1-d thanksgiving   web        0
    ## 17  2019-11-26 18:08:00   56  US now 1-d thanksgiving   web        0
    ## 18  2019-11-26 18:16:00   58  US now 1-d thanksgiving   web        0
    ## 19  2019-11-26 18:24:00   58  US now 1-d thanksgiving   web        0
    ## 20  2019-11-26 18:32:00   56  US now 1-d thanksgiving   web        0
    ## 21  2019-11-26 18:40:00   56  US now 1-d thanksgiving   web        0
    ## 22  2019-11-26 18:48:00   57  US now 1-d thanksgiving   web        0
    ## 23  2019-11-26 18:56:00   54  US now 1-d thanksgiving   web        0
    ## 24  2019-11-26 19:04:00   57  US now 1-d thanksgiving   web        0
    ## 25  2019-11-26 19:12:00   56  US now 1-d thanksgiving   web        0
    ## 26  2019-11-26 19:20:00   55  US now 1-d thanksgiving   web        0
    ## 27  2019-11-26 19:28:00   56  US now 1-d thanksgiving   web        0
    ## 28  2019-11-26 19:36:00   56  US now 1-d thanksgiving   web        0
    ## 29  2019-11-26 19:44:00   55  US now 1-d thanksgiving   web        0
    ## 30  2019-11-26 19:52:00   56  US now 1-d thanksgiving   web        0
    ## 31  2019-11-26 20:00:00   52  US now 1-d thanksgiving   web        0
    ## 32  2019-11-26 20:08:00   54  US now 1-d thanksgiving   web        0
    ## 33  2019-11-26 20:16:00   52  US now 1-d thanksgiving   web        0
    ## 34  2019-11-26 20:24:00   53  US now 1-d thanksgiving   web        0
    ## 35  2019-11-26 20:32:00   53  US now 1-d thanksgiving   web        0
    ## 36  2019-11-26 20:40:00   51  US now 1-d thanksgiving   web        0
    ## 37  2019-11-26 20:48:00   51  US now 1-d thanksgiving   web        0
    ## 38  2019-11-26 20:56:00   53  US now 1-d thanksgiving   web        0
    ## 39  2019-11-26 21:04:00   51  US now 1-d thanksgiving   web        0
    ## 40  2019-11-26 21:12:00   52  US now 1-d thanksgiving   web        0
    ## 41  2019-11-26 21:20:00   52  US now 1-d thanksgiving   web        0
    ## 42  2019-11-26 21:28:00   51  US now 1-d thanksgiving   web        0
    ## 43  2019-11-26 21:36:00   52  US now 1-d thanksgiving   web        0
    ## 44  2019-11-26 21:44:00   51  US now 1-d thanksgiving   web        0
    ## 45  2019-11-26 21:52:00   53  US now 1-d thanksgiving   web        0
    ## 46  2019-11-26 22:00:00   53  US now 1-d thanksgiving   web        0
    ## 47  2019-11-26 22:08:00   54  US now 1-d thanksgiving   web        0
    ## 48  2019-11-26 22:16:00   50  US now 1-d thanksgiving   web        0
    ## 49  2019-11-26 22:24:00   52  US now 1-d thanksgiving   web        0
    ## 50  2019-11-26 22:32:00   53  US now 1-d thanksgiving   web        0
    ## 51  2019-11-26 22:40:00   53  US now 1-d thanksgiving   web        0
    ## 52  2019-11-26 22:48:00   55  US now 1-d thanksgiving   web        0
    ## 53  2019-11-26 22:56:00   54  US now 1-d thanksgiving   web        0
    ## 54  2019-11-26 23:04:00   54  US now 1-d thanksgiving   web        0
    ## 55  2019-11-26 23:12:00   55  US now 1-d thanksgiving   web        0
    ## 56  2019-11-26 23:20:00   55  US now 1-d thanksgiving   web        0
    ## 57  2019-11-26 23:28:00   53  US now 1-d thanksgiving   web        0
    ## 58  2019-11-26 23:36:00   54  US now 1-d thanksgiving   web        0
    ## 59  2019-11-26 23:44:00   53  US now 1-d thanksgiving   web        0
    ## 60  2019-11-26 23:52:00   55  US now 1-d thanksgiving   web        0
    ## 61  2019-11-27 00:00:00   53  US now 1-d thanksgiving   web        0
    ## 62  2019-11-27 00:08:00   53  US now 1-d thanksgiving   web        0
    ## 63  2019-11-27 00:16:00   54  US now 1-d thanksgiving   web        0
    ## 64  2019-11-27 00:24:00   53  US now 1-d thanksgiving   web        0
    ## 65  2019-11-27 00:32:00   54  US now 1-d thanksgiving   web        0
    ## 66  2019-11-27 00:40:00   52  US now 1-d thanksgiving   web        0
    ## 67  2019-11-27 00:48:00   52  US now 1-d thanksgiving   web        0
    ## 68  2019-11-27 00:56:00   52  US now 1-d thanksgiving   web        0
    ## 69  2019-11-27 01:04:00   51  US now 1-d thanksgiving   web        0
    ## 70  2019-11-27 01:12:00   51  US now 1-d thanksgiving   web        0
    ## 71  2019-11-27 01:20:00   52  US now 1-d thanksgiving   web        0
    ## 72  2019-11-27 01:28:00   54  US now 1-d thanksgiving   web        0
    ## 73  2019-11-27 01:36:00   52  US now 1-d thanksgiving   web        0
    ## 74  2019-11-27 01:44:00   50  US now 1-d thanksgiving   web        0
    ## 75  2019-11-27 01:52:00   51  US now 1-d thanksgiving   web        0
    ## 76  2019-11-27 02:00:00   49  US now 1-d thanksgiving   web        0
    ## 77  2019-11-27 02:08:00   47  US now 1-d thanksgiving   web        0
    ## 78  2019-11-27 02:16:00   49  US now 1-d thanksgiving   web        0
    ## 79  2019-11-27 02:24:00   49  US now 1-d thanksgiving   web        0
    ## 80  2019-11-27 02:32:00   51  US now 1-d thanksgiving   web        0
    ## 81  2019-11-27 02:40:00   50  US now 1-d thanksgiving   web        0
    ## 82  2019-11-27 02:48:00   49  US now 1-d thanksgiving   web        0
    ## 83  2019-11-27 02:56:00   47  US now 1-d thanksgiving   web        0
    ## 84  2019-11-27 03:04:00   47  US now 1-d thanksgiving   web        0
    ## 85  2019-11-27 03:12:00   47  US now 1-d thanksgiving   web        0
    ## 86  2019-11-27 03:20:00   46  US now 1-d thanksgiving   web        0
    ## 87  2019-11-27 03:28:00   47  US now 1-d thanksgiving   web        0
    ## 88  2019-11-27 03:36:00   46  US now 1-d thanksgiving   web        0
    ## 89  2019-11-27 03:44:00   46  US now 1-d thanksgiving   web        0
    ## 90  2019-11-27 03:52:00   45  US now 1-d thanksgiving   web        0
    ## 91  2019-11-27 04:00:00   44  US now 1-d thanksgiving   web        0
    ## 92  2019-11-27 04:08:00   45  US now 1-d thanksgiving   web        0
    ## 93  2019-11-27 04:16:00   45  US now 1-d thanksgiving   web        0
    ## 94  2019-11-27 04:24:00   44  US now 1-d thanksgiving   web        0
    ## 95  2019-11-27 04:32:00   44  US now 1-d thanksgiving   web        0
    ## 96  2019-11-27 04:40:00   42  US now 1-d thanksgiving   web        0
    ## 97  2019-11-27 04:48:00   43  US now 1-d thanksgiving   web        0
    ## 98  2019-11-27 04:56:00   43  US now 1-d thanksgiving   web        0
    ## 99  2019-11-27 05:04:00   42  US now 1-d thanksgiving   web        0
    ## 100 2019-11-27 05:12:00   40  US now 1-d thanksgiving   web        0
    ## 101 2019-11-27 05:20:00   40  US now 1-d thanksgiving   web        0
    ## 102 2019-11-27 05:28:00   40  US now 1-d thanksgiving   web        0
    ## 103 2019-11-27 05:36:00   36  US now 1-d thanksgiving   web        0
    ## 104 2019-11-27 05:44:00   35  US now 1-d thanksgiving   web        0
    ## 105 2019-11-27 05:52:00   36  US now 1-d thanksgiving   web        0
    ## 106 2019-11-27 06:00:00   36  US now 1-d thanksgiving   web        0
    ## 107 2019-11-27 06:08:00   36  US now 1-d thanksgiving   web        0
    ## 108 2019-11-27 06:16:00   34  US now 1-d thanksgiving   web        0
    ## 109 2019-11-27 06:24:00   36  US now 1-d thanksgiving   web        0
    ## 110 2019-11-27 06:32:00   36  US now 1-d thanksgiving   web        0
    ## 111 2019-11-27 06:40:00   34  US now 1-d thanksgiving   web        0
    ## 112 2019-11-27 06:48:00   36  US now 1-d thanksgiving   web        0
    ## 113 2019-11-27 06:56:00   34  US now 1-d thanksgiving   web        0
    ## 114 2019-11-27 07:04:00   36  US now 1-d thanksgiving   web        0
    ## 115 2019-11-27 07:12:00   35  US now 1-d thanksgiving   web        0
    ## 116 2019-11-27 07:20:00   36  US now 1-d thanksgiving   web        0
    ## 117 2019-11-27 07:28:00   35  US now 1-d thanksgiving   web        0
    ## 118 2019-11-27 07:36:00   35  US now 1-d thanksgiving   web        0
    ## 119 2019-11-27 07:44:00   35  US now 1-d thanksgiving   web        0
    ## 120 2019-11-27 07:52:00   34  US now 1-d thanksgiving   web        0
    ## 121 2019-11-27 08:00:00   35  US now 1-d thanksgiving   web        0
    ## 122 2019-11-27 08:08:00   36  US now 1-d thanksgiving   web        0
    ## 123 2019-11-27 08:16:00   35  US now 1-d thanksgiving   web        0
    ## 124 2019-11-27 08:24:00   35  US now 1-d thanksgiving   web        0
    ## 125 2019-11-27 08:32:00   32  US now 1-d thanksgiving   web        0
    ## 126 2019-11-27 08:40:00   35  US now 1-d thanksgiving   web        0
    ## 127 2019-11-27 08:48:00   36  US now 1-d thanksgiving   web        0
    ## 128 2019-11-27 08:56:00   34  US now 1-d thanksgiving   web        0
    ## 129 2019-11-27 09:04:00   35  US now 1-d thanksgiving   web        0
    ## 130 2019-11-27 09:12:00   35  US now 1-d thanksgiving   web        0
    ## 131 2019-11-27 09:20:00   37  US now 1-d thanksgiving   web        0
    ## 132 2019-11-27 09:28:00   37  US now 1-d thanksgiving   web        0
    ## 133 2019-11-27 09:36:00   37  US now 1-d thanksgiving   web        0
    ## 134 2019-11-27 09:44:00   36  US now 1-d thanksgiving   web        0
    ## 135 2019-11-27 09:52:00   42  US now 1-d thanksgiving   web        0
    ## 136 2019-11-27 10:00:00   43  US now 1-d thanksgiving   web        0
    ## 137 2019-11-27 10:08:00   45  US now 1-d thanksgiving   web        0
    ## 138 2019-11-27 10:16:00   46  US now 1-d thanksgiving   web        0
    ## 139 2019-11-27 10:24:00   48  US now 1-d thanksgiving   web        0
    ## 140 2019-11-27 10:32:00   48  US now 1-d thanksgiving   web        0
    ## 141 2019-11-27 10:40:00   50  US now 1-d thanksgiving   web        0
    ## 142 2019-11-27 10:48:00   53  US now 1-d thanksgiving   web        0
    ## 143 2019-11-27 10:56:00   54  US now 1-d thanksgiving   web        0
    ## 144 2019-11-27 11:04:00   55  US now 1-d thanksgiving   web        0
    ## 145 2019-11-27 11:12:00   57  US now 1-d thanksgiving   web        0
    ## 146 2019-11-27 11:20:00   57  US now 1-d thanksgiving   web        0
    ## 147 2019-11-27 11:28:00   59  US now 1-d thanksgiving   web        0
    ## 148 2019-11-27 11:36:00   61  US now 1-d thanksgiving   web        0
    ## 149 2019-11-27 11:44:00   65  US now 1-d thanksgiving   web        0
    ## 150 2019-11-27 11:52:00   73  US now 1-d thanksgiving   web        0
    ## 151 2019-11-27 12:00:00   76  US now 1-d thanksgiving   web        0
    ## 152 2019-11-27 12:08:00   77  US now 1-d thanksgiving   web        0
    ## 153 2019-11-27 12:16:00   79  US now 1-d thanksgiving   web        0
    ## 154 2019-11-27 12:24:00   80  US now 1-d thanksgiving   web        0
    ## 155 2019-11-27 12:32:00   86  US now 1-d thanksgiving   web        0
    ## 156 2019-11-27 12:40:00   88  US now 1-d thanksgiving   web        0
    ## 157 2019-11-27 12:48:00   91  US now 1-d thanksgiving   web        0
    ## 158 2019-11-27 12:56:00   91  US now 1-d thanksgiving   web        0
    ## 159 2019-11-27 13:04:00   95  US now 1-d thanksgiving   web        0
    ## 160 2019-11-27 13:12:00   96  US now 1-d thanksgiving   web        0
    ## 161 2019-11-27 13:20:00   98  US now 1-d thanksgiving   web        0
    ## 162 2019-11-27 13:28:00   96  US now 1-d thanksgiving   web        0
    ## 163 2019-11-27 13:36:00   96  US now 1-d thanksgiving   web        0
    ## 164 2019-11-27 13:44:00   98  US now 1-d thanksgiving   web        0
    ## 165 2019-11-27 13:52:00   96  US now 1-d thanksgiving   web        0
    ## 166 2019-11-27 14:00:00   95  US now 1-d thanksgiving   web        0
    ## 167 2019-11-27 14:08:00   97  US now 1-d thanksgiving   web        0
    ## 168 2019-11-27 14:16:00   96  US now 1-d thanksgiving   web        0
    ## 169 2019-11-27 14:24:00  100  US now 1-d thanksgiving   web        0
    ## 170 2019-11-27 14:32:00   96  US now 1-d thanksgiving   web        0
    ## 171 2019-11-27 14:40:00   96  US now 1-d thanksgiving   web        0
    ## 172 2019-11-27 14:48:00   94  US now 1-d thanksgiving   web        0
    ## 173 2019-11-27 14:56:00   95  US now 1-d thanksgiving   web        0
    ## 174 2019-11-27 15:04:00   95  US now 1-d thanksgiving   web        0
    ## 175 2019-11-27 15:12:00   92  US now 1-d thanksgiving   web        0
    ## 176 2019-11-27 15:20:00   93  US now 1-d thanksgiving   web        0
    ## 177 2019-11-27 15:28:00   92  US now 1-d thanksgiving   web        0
    ## 178 2019-11-27 15:36:00   95  US now 1-d thanksgiving   web        0
    ## 179 2019-11-27 15:44:00   98  US now 1-d thanksgiving   web        0
    ## 180 2019-11-27 15:52:00   86  US now 1-d thanksgiving   web        0
    ## 
    ## $interest_by_country
    ## NULL
    ## 
    ## $interest_by_region
    ##                location hits      keyword geo gprop
    ## 1            New Jersey  100 thanksgiving  US   web
    ## 2           Connecticut   93 thanksgiving  US   web
    ## 3         Massachusetts   91 thanksgiving  US   web
    ## 4          Rhode Island   91 thanksgiving  US   web
    ## 5  District of Columbia   87 thanksgiving  US   web
    ## 6              Virginia   87 thanksgiving  US   web
    ## 7         New Hampshire   86 thanksgiving  US   web
    ## 8              Maryland   85 thanksgiving  US   web
    ## 9              New York   85 thanksgiving  US   web
    ## 10              Florida   83 thanksgiving  US   web
    ## 11         Pennsylvania   83 thanksgiving  US   web
    ## 12              Arizona   83 thanksgiving  US   web
    ## 13       South Carolina   82 thanksgiving  US   web
    ## 14                Maine   81 thanksgiving  US   web
    ## 15             Delaware   80 thanksgiving  US   web
    ## 16               Kansas   80 thanksgiving  US   web
    ## 17       North Carolina   79 thanksgiving  US   web
    ## 18               Hawaii   79 thanksgiving  US   web
    ## 19             Illinois   77 thanksgiving  US   web
    ## 20                 Ohio   76 thanksgiving  US   web
    ## 21              Indiana   76 thanksgiving  US   web
    ## 22              Montana   75 thanksgiving  US   web
    ## 23             Missouri   74 thanksgiving  US   web
    ## 24           Washington   73 thanksgiving  US   web
    ## 25             Kentucky   73 thanksgiving  US   web
    ## 26               Nevada   73 thanksgiving  US   web
    ## 27                Texas   72 thanksgiving  US   web
    ## 28                 Utah   72 thanksgiving  US   web
    ## 29             Michigan   72 thanksgiving  US   web
    ## 30                 Iowa   71 thanksgiving  US   web
    ## 31            Tennessee   71 thanksgiving  US   web
    ## 32            Wisconsin   70 thanksgiving  US   web
    ## 33           New Mexico   69 thanksgiving  US   web
    ## 34         North Dakota   68 thanksgiving  US   web
    ## 35           California   68 thanksgiving  US   web
    ## 36             Oklahoma   68 thanksgiving  US   web
    ## 37              Georgia   68 thanksgiving  US   web
    ## 38         South Dakota   66 thanksgiving  US   web
    ## 39               Oregon   66 thanksgiving  US   web
    ## 40            Minnesota   66 thanksgiving  US   web
    ## 41                Idaho   64 thanksgiving  US   web
    ## 42        West Virginia   64 thanksgiving  US   web
    ## 43             Nebraska   63 thanksgiving  US   web
    ## 44              Vermont   63 thanksgiving  US   web
    ## 45               Alaska   63 thanksgiving  US   web
    ## 46              Alabama   62 thanksgiving  US   web
    ## 47             Colorado   62 thanksgiving  US   web
    ## 48            Louisiana   61 thanksgiving  US   web
    ## 49             Arkansas   61 thanksgiving  US   web
    ## 50              Wyoming   57 thanksgiving  US   web
    ## 51          Mississippi   55 thanksgiving  US   web
    ## 
    ## $interest_by_dma
    ##                                                    location hits
    ## 1                              Providence RI-New Bedford MA  100
    ## 2                                   Hartford & New Haven CT  100
    ## 3                                   Boston MA-Manchester NH   96
    ## 4                             Washington DC (Hagerstown MD)   95
    ## 5                                               New York NY   94
    ## 6                             West Palm Beach-Ft. Pierce FL   92
    ## 7                                           Philadelphia PA   91
    ## 8                                   Miami-Ft. Lauderdale FL   91
    ## 9                                Albany-Schenectady-Troy NY   90
    ## 10                                      Ft. Myers-Naples FL   90
    ## 11                                             Baltimore MD   90
    ## 12                                       Portland-Auburn ME   89
    ## 13                       Tampa-St. Petersburg (Sarasota) FL   89
    ## 14                       Norfolk-Portsmouth-Newport News VA   88
    ## 15                                 Florence-Myrtle Beach SC   88
    ## 16                                             Charlotte NC   88
    ## 17                                              Columbus OH   87
    ## 18                                               Buffalo NY   87
    ## 19                                               Phoenix AZ   87
    ## 20                                            Pittsburgh PA   87
    ## 21                                            Cincinnati OH   86
    ## 22                                             Rochester NY   86
    ## 23       Greenville-Spartanburg SC-Asheville NC-Anderson SC   86
    ## 24                                            Charleston SC   86
    ## 25                                          Jacksonville FL   85
    ## 26                                                Austin TX   84
    ## 27                                              Glendive MT   84
    ## 28                                   Richmond-Petersburg VA   84
    ## 29                                              Honolulu HI   84
    ## 30                       Orlando-Daytona Beach-Melbourne FL   84
    ## 31                         Raleigh-Durham (Fayetteville) NC   84
    ## 32                                             Lafayette IN   83
    ## 33                                           Kansas City MO   83
    ## 34                                             Knoxville TN   82
    ## 35                                               Chicago IL   82
    ## 36                     Harrisburg-Lancaster-Lebanon-York PA   82
    ## 37                                 Wilkes Barre-Scranton PA   81
    ## 38                                          Indianapolis IN   81
    ## 39                                     Roanoke-Lynchburg VA   80
    ## 40                                 Tucson (Sierra Vista) AZ   80
    ## 41                                              Syracuse NY   80
    ## 42                                              Missoula MT   80
    ## 43                                             San Diego CA   80
    ## 44                                   Springfield-Holyoke MA   80
    ## 45                                    South Bend-Elkhart IN   80
    ## 46                                            St. Joseph MO   80
    ## 47                                             Nashville TN   79
    ## 48                                               Houston TX   79
    ## 49                                       Charlottesville VA   79
    ## 50                                    Green Bay-Appleton WI   79
    ## 51                                        Seattle-Tacoma WA   79
    ## 52                                               Madison WI   79
    ## 53                                             Milwaukee WI   79
    ## 54                              Cleveland-Akron (Canton) OH   78
    ## 55                                            Louisville KY   78
    ## 56                                            Binghamton NY   78
    ## 57                                               Detroit MI   78
    ## 58                                            Wilmington NC   77
    ## 59                                      Dallas-Ft. Worth TX   77
    ## 60                                           Los Angeles CA   77
    ## 61                                             St. Louis MO   77
    ## 62                                        Salt Lake City UT   77
    ## 63                                           Great Falls MT   76
    ## 64                                       Des Moines-Ames IA   76
    ## 65                   Grand Rapids-Kalamazoo-Battle Creek MI   76
    ## 66                                              Columbia SC   76
    ## 67                                             Lexington KY   76
    ## 68                                          Harrisonburg VA   76
    ## 69                                                Elmira NY   75
    ## 70                                           Chattanooga TN   75
    ## 71                                             Salisbury MD   75
    ## 72                                           Springfield MO   75
    ## 73                                             Las Vegas NV   75
    ## 74                                            Rapid City SD   75
    ## 75                                                Topeka KS   75
    ## 76                                               Atlanta GA   75
    ## 77                                    Wichita-Hutchinson KS   75
    ## 78                                              Portland OR   74
    ## 79                                                 Omaha NE   74
    ## 80                                Flint-Saginaw-Bay City MI   74
    ## 81                                             Billings, MT   74
    ## 82                           Sacramento-Stockton-Modesto CA   73
    ## 83                                  Albuquerque-Santa Fe NM   73
    ## 84                Mobile AL-Pensacola (Ft. Walton Beach) FL   73
    ## 85                                                Bangor ME   73
    ## 86                   Greensboro-High Point-Winston Salem NC   73
    ## 87                                                 Utica NY   73
    ## 88                                                Juneau AK   72
    ## 89                                                Toledo OH   72
    ## 90             Cedar Rapids-Waterloo-Iowa City & Dubuque IA   72
    ## 91                                         Bowling Green KY   72
    ## 92                                           San Antonio TX   72
    ## 93                             Burlington VT-Plattsburgh NY   72
    ## 94                                              Savannah GA   72
    ## 95                                         Oklahoma City OK   72
    ## 96                       Champaign & Springfield-Decatur IL   72
    ## 97                                                  Erie PA   72
    ## 98                                               Spokane WA   71
    ## 99                        San Francisco-Oakland-San Jose CA   71
    ## 100                                               Dayton OH   70
    ## 101                  Minot-Bismarck-Dickinson(Williston) ND   70
    ## 102                                               Alpena MI   70
    ## 103                                   Peoria-Bloomington IL   70
    ## 104                                            Anchorage AK   70
    ## 105                                           Zanesville OH   70
    ## 106                                                Tulsa OK   69
    ## 107                                             Rockford IL   69
    ## 108                              Columbia-Jefferson City MO   69
    ## 109                                 Minneapolis-St. Paul MN   69
    ## 110                                        Butte-Bozeman MT   69
    ## 111                                          New Orleans LA   69
    ## 112                                       Corpus Christi TX   68
    ## 113                                         Presque Isle ME   68
    ## 114                                          Panama City FL   68
    ## 115                                    Fargo-Valley City ND   68
    ## 116                                  Joplin MO-Pittsburg KS   68
    ## 117                              Colorado Springs-Pueblo CO   68
    ## 118                             Wheeling WV-Steubenville OH   67
    ## 119                                    Waco-Temple-Bryan TX   67
    ## 120                                          Gainesville FL   67
    ## 121                                          Terre Haute IN   67
    ## 122                                               Helena MT   67
    ## 123                                         Palm Springs CA   67
    ## 124                                           Twin Falls ID   67
    ## 125                       Greenville-New Bern-Washington NC   67
    ## 126                      Davenport IA-Rock Island-Moline IL   66
    ## 127                                            Watertown NY   66
    ## 128                                               Denver CO   66
    ## 129                                    Johnstown-Altoona PA   66
    ## 130                                           Evansville IN   66
    ## 131                               Traverse City-Cadillac MI   66
    ## 132                                            Marquette MI   66
    ## 133                                             Victoria TX   66
    ## 134                                           Birmingham AL   66
    ## 135                                           San Angelo TX   65
    ## 136                                            Ft. Wayne IN   65
    ## 137                                              El Paso TX   65
    ## 138                                             Amarillo TX   65
    ## 139                                        Tri-Cities TN-VA   65
    ## 140                                   Wausau-Rhinelander WI   65
    ## 141                         Quincy IL-Hannibal MO-Keokuk IA   65
    ## 142                                              Lansing MI   64
    ## 143                                   Abilene-Sweetwater TX   64
    ## 144                                                 Reno NV   64
    ## 145                           Bluefield-Beckley-Oak Hill WV   64
    ## 146                                       Fresno-Visalia CA   64
    ## 147                                Ottumwa IA-Kirksville MO   64
    ## 148             Ft. Smith-Fayetteville-Springdale-Rogers AR   63
    ## 149                            Wichita Falls TX & Lawton OK   63
    ## 150                                Sioux Falls(Mitchell) SD   63
    ## 151                                              Lubbock TX   63
    ## 152                                      Casper-Riverton WY   62
    ## 153                                           Youngstown OH   62
    ## 154                                Idaho Falls-Pocatello ID   62
    ## 155                               Little Rock-Pine Bluff AR   62
    ## 156 Paducah KY-Cape Girardeau MO-Harrisburg-Mount Vernon IL   61
    ## 157                                              Memphis TN   61
    ## 158                                                Boise ID   61
    ## 159                                       Sherman TX-Ada OK   61
    ## 160                                             Columbus GA   61
    ## 161                              Grand Junction-Montrose CO   61
    ## 162                      Yakima-Pasco-Richland-Kennewick WA   61
    ## 163                    Rochester MN-Mason City IA-Austin MN   60
    ## 164                                            Fairbanks AK   60
    ## 165                                      Biloxi-Gulfport MS   60
    ## 166                           Tallahassee FL-Thomasville GA   60
    ## 167                                              Jackson TN   59
    ## 168                                   Duluth MN-Superior WI   59
    ## 169                                          Parkersburg WV   59
    ## 170                        Huntsville-Decatur (Florence) AL   59
    ## 171                                     Monterey-Salinas CA   58
    ## 172                                              Augusta GA   58
    ## 173                                                 Lima OH   58
    ## 174                                    Yuma AZ-El Centro CA   58
    ## 175                                       Odessa-Midland TX   57
    ## 176            Santa Barbara-Santa Maria-San Luis Obispo CA   57
    ## 177                                              Mankato MN   56
    ## 178                                Charleston-Huntington WV   56
    ## 179                                                 Bend OR   56
    ## 180                                          Baton Rouge LA   56
    ## 181                 Tyler-Longview(Lufkin & Nacogdoches) TX   55
    ## 182                                         Lake Charles LA   55
    ## 183                                 La Crosse-Eau Claire WI   55
    ## 184                                                Macon GA   54
    ## 185                           Columbus-Tupelo-West Point MS   54
    ## 186                                        Chico-Redding CA   54
    ## 187                           Lincoln & Hastings-Kearney NE   53
    ## 188                                               Albany GA   53
    ## 189                                   Hattiesburg-Laurel MS   53
    ## 190                                               Eugene OR   53
    ## 191                                           Alexandria LA   52
    ## 192                                          Bakersfield CA   52
    ## 193                                             Meridian MS   52
    ## 194                                   Montgomery (Selma) AL   52
    ## 195                                           Shreveport LA   52
    ## 196                                               Dothan AL   52
    ## 197                                            Lafayette LA   51
    ## 198                                               Laredo TX   51
    ## 199                                    Clarksburg-Weston WV   51
    ## 200                Harlingen-Weslaco-Brownsville-McAllen TX   51
    ## 201                                 Beaumont-Port Arthur TX   51
    ## 202                                  Monroe LA-El Dorado AR   50
    ## 203                                            Jonesboro AR   50
    ## 204                                Medford-Klamath Falls OR   50
    ## 205                                               Eureka CA   50
    ## 206                              Cheyenne WY-Scottsbluff NE   49
    ## 207                                           Sioux City IA   47
    ## 208                                              Jackson MS   47
    ## 209                                         North Platte NE   41
    ## 210                                 Greenwood-Greenville MS   39
    ##          keyword geo gprop
    ## 1   thanksgiving  US   web
    ## 2   thanksgiving  US   web
    ## 3   thanksgiving  US   web
    ## 4   thanksgiving  US   web
    ## 5   thanksgiving  US   web
    ## 6   thanksgiving  US   web
    ## 7   thanksgiving  US   web
    ## 8   thanksgiving  US   web
    ## 9   thanksgiving  US   web
    ## 10  thanksgiving  US   web
    ## 11  thanksgiving  US   web
    ## 12  thanksgiving  US   web
    ## 13  thanksgiving  US   web
    ## 14  thanksgiving  US   web
    ## 15  thanksgiving  US   web
    ## 16  thanksgiving  US   web
    ## 17  thanksgiving  US   web
    ## 18  thanksgiving  US   web
    ## 19  thanksgiving  US   web
    ## 20  thanksgiving  US   web
    ## 21  thanksgiving  US   web
    ## 22  thanksgiving  US   web
    ## 23  thanksgiving  US   web
    ## 24  thanksgiving  US   web
    ## 25  thanksgiving  US   web
    ## 26  thanksgiving  US   web
    ## 27  thanksgiving  US   web
    ## 28  thanksgiving  US   web
    ## 29  thanksgiving  US   web
    ## 30  thanksgiving  US   web
    ## 31  thanksgiving  US   web
    ## 32  thanksgiving  US   web
    ## 33  thanksgiving  US   web
    ## 34  thanksgiving  US   web
    ## 35  thanksgiving  US   web
    ## 36  thanksgiving  US   web
    ## 37  thanksgiving  US   web
    ## 38  thanksgiving  US   web
    ## 39  thanksgiving  US   web
    ## 40  thanksgiving  US   web
    ## 41  thanksgiving  US   web
    ## 42  thanksgiving  US   web
    ## 43  thanksgiving  US   web
    ## 44  thanksgiving  US   web
    ## 45  thanksgiving  US   web
    ## 46  thanksgiving  US   web
    ## 47  thanksgiving  US   web
    ## 48  thanksgiving  US   web
    ## 49  thanksgiving  US   web
    ## 50  thanksgiving  US   web
    ## 51  thanksgiving  US   web
    ## 52  thanksgiving  US   web
    ## 53  thanksgiving  US   web
    ## 54  thanksgiving  US   web
    ## 55  thanksgiving  US   web
    ## 56  thanksgiving  US   web
    ## 57  thanksgiving  US   web
    ## 58  thanksgiving  US   web
    ## 59  thanksgiving  US   web
    ## 60  thanksgiving  US   web
    ## 61  thanksgiving  US   web
    ## 62  thanksgiving  US   web
    ## 63  thanksgiving  US   web
    ## 64  thanksgiving  US   web
    ## 65  thanksgiving  US   web
    ## 66  thanksgiving  US   web
    ## 67  thanksgiving  US   web
    ## 68  thanksgiving  US   web
    ## 69  thanksgiving  US   web
    ## 70  thanksgiving  US   web
    ## 71  thanksgiving  US   web
    ## 72  thanksgiving  US   web
    ## 73  thanksgiving  US   web
    ## 74  thanksgiving  US   web
    ## 75  thanksgiving  US   web
    ## 76  thanksgiving  US   web
    ## 77  thanksgiving  US   web
    ## 78  thanksgiving  US   web
    ## 79  thanksgiving  US   web
    ## 80  thanksgiving  US   web
    ## 81  thanksgiving  US   web
    ## 82  thanksgiving  US   web
    ## 83  thanksgiving  US   web
    ## 84  thanksgiving  US   web
    ## 85  thanksgiving  US   web
    ## 86  thanksgiving  US   web
    ## 87  thanksgiving  US   web
    ## 88  thanksgiving  US   web
    ## 89  thanksgiving  US   web
    ## 90  thanksgiving  US   web
    ## 91  thanksgiving  US   web
    ## 92  thanksgiving  US   web
    ## 93  thanksgiving  US   web
    ## 94  thanksgiving  US   web
    ## 95  thanksgiving  US   web
    ## 96  thanksgiving  US   web
    ## 97  thanksgiving  US   web
    ## 98  thanksgiving  US   web
    ## 99  thanksgiving  US   web
    ## 100 thanksgiving  US   web
    ## 101 thanksgiving  US   web
    ## 102 thanksgiving  US   web
    ## 103 thanksgiving  US   web
    ## 104 thanksgiving  US   web
    ## 105 thanksgiving  US   web
    ## 106 thanksgiving  US   web
    ## 107 thanksgiving  US   web
    ## 108 thanksgiving  US   web
    ## 109 thanksgiving  US   web
    ## 110 thanksgiving  US   web
    ## 111 thanksgiving  US   web
    ## 112 thanksgiving  US   web
    ## 113 thanksgiving  US   web
    ## 114 thanksgiving  US   web
    ## 115 thanksgiving  US   web
    ## 116 thanksgiving  US   web
    ## 117 thanksgiving  US   web
    ## 118 thanksgiving  US   web
    ## 119 thanksgiving  US   web
    ## 120 thanksgiving  US   web
    ## 121 thanksgiving  US   web
    ## 122 thanksgiving  US   web
    ## 123 thanksgiving  US   web
    ## 124 thanksgiving  US   web
    ## 125 thanksgiving  US   web
    ## 126 thanksgiving  US   web
    ## 127 thanksgiving  US   web
    ## 128 thanksgiving  US   web
    ## 129 thanksgiving  US   web
    ## 130 thanksgiving  US   web
    ## 131 thanksgiving  US   web
    ## 132 thanksgiving  US   web
    ## 133 thanksgiving  US   web
    ## 134 thanksgiving  US   web
    ## 135 thanksgiving  US   web
    ## 136 thanksgiving  US   web
    ## 137 thanksgiving  US   web
    ## 138 thanksgiving  US   web
    ## 139 thanksgiving  US   web
    ## 140 thanksgiving  US   web
    ## 141 thanksgiving  US   web
    ## 142 thanksgiving  US   web
    ## 143 thanksgiving  US   web
    ## 144 thanksgiving  US   web
    ## 145 thanksgiving  US   web
    ## 146 thanksgiving  US   web
    ## 147 thanksgiving  US   web
    ## 148 thanksgiving  US   web
    ## 149 thanksgiving  US   web
    ## 150 thanksgiving  US   web
    ## 151 thanksgiving  US   web
    ## 152 thanksgiving  US   web
    ## 153 thanksgiving  US   web
    ## 154 thanksgiving  US   web
    ## 155 thanksgiving  US   web
    ## 156 thanksgiving  US   web
    ## 157 thanksgiving  US   web
    ## 158 thanksgiving  US   web
    ## 159 thanksgiving  US   web
    ## 160 thanksgiving  US   web
    ## 161 thanksgiving  US   web
    ## 162 thanksgiving  US   web
    ## 163 thanksgiving  US   web
    ## 164 thanksgiving  US   web
    ## 165 thanksgiving  US   web
    ## 166 thanksgiving  US   web
    ## 167 thanksgiving  US   web
    ## 168 thanksgiving  US   web
    ## 169 thanksgiving  US   web
    ## 170 thanksgiving  US   web
    ## 171 thanksgiving  US   web
    ## 172 thanksgiving  US   web
    ## 173 thanksgiving  US   web
    ## 174 thanksgiving  US   web
    ## 175 thanksgiving  US   web
    ## 176 thanksgiving  US   web
    ## 177 thanksgiving  US   web
    ## 178 thanksgiving  US   web
    ## 179 thanksgiving  US   web
    ## 180 thanksgiving  US   web
    ## 181 thanksgiving  US   web
    ## 182 thanksgiving  US   web
    ## 183 thanksgiving  US   web
    ## 184 thanksgiving  US   web
    ## 185 thanksgiving  US   web
    ## 186 thanksgiving  US   web
    ## 187 thanksgiving  US   web
    ## 188 thanksgiving  US   web
    ## 189 thanksgiving  US   web
    ## 190 thanksgiving  US   web
    ## 191 thanksgiving  US   web
    ## 192 thanksgiving  US   web
    ## 193 thanksgiving  US   web
    ## 194 thanksgiving  US   web
    ## 195 thanksgiving  US   web
    ## 196 thanksgiving  US   web
    ## 197 thanksgiving  US   web
    ## 198 thanksgiving  US   web
    ## 199 thanksgiving  US   web
    ## 200 thanksgiving  US   web
    ## 201 thanksgiving  US   web
    ## 202 thanksgiving  US   web
    ## 203 thanksgiving  US   web
    ## 204 thanksgiving  US   web
    ## 205 thanksgiving  US   web
    ## 206 thanksgiving  US   web
    ## 207 thanksgiving  US   web
    ## 208 thanksgiving  US   web
    ## 209 thanksgiving  US   web
    ## 210 thanksgiving  US   web
    ## 
    ## $interest_by_city
    ##                  location hits      keyword geo gprop
    ## 1                Pembroke   NA thanksgiving  US   web
    ## 2                  Hazlet   NA thanksgiving  US   web
    ## 3                Hillburn   NA thanksgiving  US   web
    ## 4                Leesburg  100 thanksgiving  US   web
    ## 5              Knightdale   NA thanksgiving  US   web
    ## 6             South Miami   NA thanksgiving  US   web
    ## 7               Long Hill   NA thanksgiving  US   web
    ## 8                Westwood   NA thanksgiving  US   web
    ## 9                 Wantagh   NA thanksgiving  US   web
    ## 10           Mount Laurel   NA thanksgiving  US   web
    ## 11               Melville   NA thanksgiving  US   web
    ## 12        Monroe Township   NA thanksgiving  US   web
    ## 13      Marlboro Township   NA thanksgiving  US   web
    ## 14                  Essex   NA thanksgiving  US   web
    ## 15    North New Hyde Park   NA thanksgiving  US   web
    ## 16             Bloomfield   NA thanksgiving  US   web
    ## 17                Holmdel   NA thanksgiving  US   web
    ## 18                Jackson   NA thanksgiving  US   web
    ## 19             Livingston   NA thanksgiving  US   web
    ## 20                 Weston   NA thanksgiving  US   web
    ## 21               Cheshire   NA thanksgiving  US   web
    ## 22                Paramus   NA thanksgiving  US   web
    ## 23       Berkeley Heights   NA thanksgiving  US   web
    ## 24        Sparta Township   NA thanksgiving  US   web
    ## 25          Wall Township   NA thanksgiving  US   web
    ## 26                Beverly   NA thanksgiving  US   web
    ## 27                 Natick   NA thanksgiving  US   web
    ## 28     Middleburg Heights   NA thanksgiving  US   web
    ## 29              Plainview   NA thanksgiving  US   web
    ## 30             Massapequa   NA thanksgiving  US   web
    ## 31                 Edison   83 thanksgiving  US   web
    ## 32                Andover   NA thanksgiving  US   web
    ## 33      Hopewell Township   NA thanksgiving  US   web
    ## 34           Willow Grove   NA thanksgiving  US   web
    ## 35           Eden Prairie   81 thanksgiving  US   web
    ## 36          Mount Lebanon   NA thanksgiving  US   web
    ## 37                 Howell   81 thanksgiving  US   web
    ## 38   Springfield Township   NA thanksgiving  US   web
    ## 39              Levittown   NA thanksgiving  US   web
    ## 40             Merrifield   NA thanksgiving  US   web
    ## 41               Harrison   NA thanksgiving  US   web
    ## 42      Franklin Township   NA thanksgiving  US   web
    ## 43           Coral Gables   NA thanksgiving  US   web
    ## 44                Commack   NA thanksgiving  US   web
    ## 45              Hockinson   NA thanksgiving  US   web
    ## 46          West Deptford   NA thanksgiving  US   web
    ## 47                  Wayne   NA thanksgiving  US   web
    ## 48                 Oakton   NA thanksgiving  US   web
    ## 49             Hicksville   NA thanksgiving  US   web
    ## 50             Branchburg   NA thanksgiving  US   web
    ## 51    Old Bridge Township   NA thanksgiving  US   web
    ## 52             Middletown   NA thanksgiving  US   web
    ## 53             Glen Ridge   NA thanksgiving  US   web
    ## 54  West Windsor Township   NA thanksgiving  US   web
    ## 55        East Providence   NA thanksgiving  US   web
    ## 56           Gaithersburg   NA thanksgiving  US   web
    ## 57            Southington   NA thanksgiving  US   web
    ## 58               Plymouth   NA thanksgiving  US   web
    ## 59               Freeport   NA thanksgiving  US   web
    ## 60           New Rochelle   NA thanksgiving  US   web
    ## 61             Doylestown   NA thanksgiving  US   web
    ## 62            Cherry Hill   NA thanksgiving  US   web
    ## 63      Lawrence Township   NA thanksgiving  US   web
    ## 64           Orchard Park   NA thanksgiving  US   web
    ## 65              West Bend   NA thanksgiving  US   web
    ## 66          Mechanicsburg   NA thanksgiving  US   web
    ## 67              Lexington   NA thanksgiving  US   web
    ## 68                Needham   NA thanksgiving  US   web
    ## 69    Washington Township   NA thanksgiving  US   web
    ## 70          West Hartford   NA thanksgiving  US   web
    ## 71            Glastonbury   NA thanksgiving  US   web
    ## 72     Hilton Head Island   NA thanksgiving  US   web
    ## 73              Princeton   NA thanksgiving  US   web
    ## 74             Cumberland   NA thanksgiving  US   web
    ## 75                Milford   NA thanksgiving  US   web
    ## 76     Manalapan Township   NA thanksgiving  US   web
    ## 77     Montgomery Village   NA thanksgiving  US   web
    ## 78           White Plains   NA thanksgiving  US   web
    ## 79          Miami Springs   NA thanksgiving  US   web
    ## 80             Boca Raton   NA thanksgiving  US   web
    ## 81                Devault   NA thanksgiving  US   web
    ## 82              Attleboro   NA thanksgiving  US   web
    ## 83         East Brunswick   NA thanksgiving  US   web
    ## 84           Myrtle Beach   NA thanksgiving  US   web
    ## 85               Wildwood   NA thanksgiving  US   web
    ## 86                 McLean   NA thanksgiving  US   web
    ## 87             Washington   76 thanksgiving  US   web
    ## 88               Weymouth   NA thanksgiving  US   web
    ## 89            Mooresville   NA thanksgiving  US   web
    ## 90             Middletown   NA thanksgiving  US   web
    ## 91               Surprise   NA thanksgiving  US   web
    ## 92                Hanover   NA thanksgiving  US   web
    ## 93               Stamford   76 thanksgiving  US   web
    ## 94          Coral Springs   NA thanksgiving  US   web
    ## 95               Beaufort   NA thanksgiving  US   web
    ## 96              Fort Mill   NA thanksgiving  US   web
    ## 97             Hackensack   NA thanksgiving  US   web
    ## 98              Levittown   NA thanksgiving  US   web
    ## 99               Aventura   NA thanksgiving  US   web
    ## 100       Fairfax Station   NA thanksgiving  US   web
    ## 101                 Mason   NA thanksgiving  US   web
    ## 102             Watertown   NA thanksgiving  US   web
    ## 103       Carolina Forest   NA thanksgiving  US   web
    ## 104                Reston   NA thanksgiving  US   web
    ## 105          Pimmit Hills   NA thanksgiving  US   web
    ## 106               Clayton   NA thanksgiving  US   web
    ## 107         Pompano Beach   NA thanksgiving  US   web
    ## 108               Tamiami   NA thanksgiving  US   web
    ## 109           Sevierville   NA thanksgiving  US   web
    ## 110           West Orange   NA thanksgiving  US   web
    ## 111        Virginia Beach   74 thanksgiving  US   web
    ## 112             Braintree   NA thanksgiving  US   web
    ## 113               Kendall   NA thanksgiving  US   web
    ## 114               Danbury   NA thanksgiving  US   web
    ## 115              Maitland   NA thanksgiving  US   web
    ## 116              Glenview   NA thanksgiving  US   web
    ## 117            Alexandria   73 thanksgiving  US   web
    ## 118               Bayonne   NA thanksgiving  US   web
    ## 119              Fort Lee   NA thanksgiving  US   web
    ## 120           Bridgewater   NA thanksgiving  US   web
    ## 121                Woburn   NA thanksgiving  US   web
    ## 122                 Salem   NA thanksgiving  US   web
    ## 123            Burlington   NA thanksgiving  US   web
    ## 124         Silver Spring   73 thanksgiving  US   web
    ## 125        North Bethesda   NA thanksgiving  US   web
    ## 126               Roswell   73 thanksgiving  US   web
    ## 127          Delray Beach   NA thanksgiving  US   web
    ## 128               Waltham   NA thanksgiving  US   web
    ## 129              Vineland   NA thanksgiving  US   web
    ## 130              New York   73 thanksgiving  US   web
    ## 131             Weehawken   NA thanksgiving  US   web
    ## 132                 Davie   73 thanksgiving  US   web
    ## 133                Destin   NA thanksgiving  US   web
    ## 134         Bel Air South   NA thanksgiving  US   web
    ## 135                Boston   71 thanksgiving  US   web
    ## 136   Manchester Township   NA thanksgiving  US   web
    ## 137             Rockledge   NA thanksgiving  US   web
    ## 138               Norwalk   NA thanksgiving  US   web
    ## 139             Royal Oak   NA thanksgiving  US   web
    ## 140             Charlotte   71 thanksgiving  US   web
    ## 141                Dublin   NA thanksgiving  US   web
    ## 142                 Wayne   NA thanksgiving  US   web
    ## 143             Hollywood   71 thanksgiving  US   web
    ## 144                Newton   71 thanksgiving  US   web
    ## 145             Billerica   NA thanksgiving  US   web
    ## 146                 Burke   NA thanksgiving  US   web
    ## 147         Ellicott City   NA thanksgiving  US   web
    ## 148           Kings Point   NA thanksgiving  US   web
    ## 149        Merritt Island   NA thanksgiving  US   web
    ## 150       King of Prussia   NA thanksgiving  US   web
    ## 151    Saint Clair Shores   NA thanksgiving  US   web
    ## 152              Oak Park   NA thanksgiving  US   web
    ## 153       Deerfield Beach   NA thanksgiving  US   web
    ## 154            Fruit Cove   NA thanksgiving  US   web
    ## 155                 Largo   NA thanksgiving  US   web
    ## 156               Batavia   NA thanksgiving  US   web
    ## 157              Denville   NA thanksgiving  US   web
    ## 158             Montclair   NA thanksgiving  US   web
    ## 159            Clearwater   71 thanksgiving  US   web
    ## 160        West Lafayette   NA thanksgiving  US   web
    ## 161      Town 'n' Country   NA thanksgiving  US   web
    ## 162             Chantilly   71 thanksgiving  US   web
    ## 163          West Babylon   NA thanksgiving  US   web
    ## 164            Greenville   71 thanksgiving  US   web
    ## 165             Annandale   NA thanksgiving  US   web
    ## 166               Meriden   NA thanksgiving  US   web
    ## 167              Franklin   NA thanksgiving  US   web
    ## 168    Palm Beach Gardens   NA thanksgiving  US   web
    ## 169             Asheville   70 thanksgiving  US   web
    ## 170             Encinitas   NA thanksgiving  US   web
    ## 171                 Aiken   NA thanksgiving  US   web
    ## 172              Columbus   70 thanksgiving  US   web
    ## 173               Dunedin   NA thanksgiving  US   web
    ## 174              Franklin   NA thanksgiving  US   web
    ## 175           Johns Creek   NA thanksgiving  US   web
    ## 176 West University Place   NA thanksgiving  US   web
    ## 177              Elkridge   NA thanksgiving  US   web
    ## 178                  Apex   NA thanksgiving  US   web
    ## 179               Coppell   NA thanksgiving  US   web
    ## 180            Aspen Hill   NA thanksgiving  US   web
    ## 181               Endwell   NA thanksgiving  US   web
    ## 182               Phoenix   70 thanksgiving  US   web
    ## 183              Socastee   NA thanksgiving  US   web
    ## 184                 Doral   70 thanksgiving  US   web
    ## 185                Malden   NA thanksgiving  US   web
    ## 186           Queen Creek   NA thanksgiving  US   web
    ## 187                  Lehi   NA thanksgiving  US   web
    ## 188                Verona   70 thanksgiving  US   web
    ## 189             Lake Mary   NA thanksgiving  US   web
    ## 190            Manchester   NA thanksgiving  US   web
    ## 191          Kernersville   NA thanksgiving  US   web
    ## 192              Farragut   NA thanksgiving  US   web
    ## 193            Somerville   NA thanksgiving  US   web
    ## 194              O'Fallon   NA thanksgiving  US   web
    ## 195            Janesville   NA thanksgiving  US   web
    ## 196          North Naples   NA thanksgiving  US   web
    ## 197         Scotch Plains   NA thanksgiving  US   web
    ## 198             Greenwich   NA thanksgiving  US   web
    ## 199              Bee Cave   NA thanksgiving  US   web
    ## 200                Venice   NA thanksgiving  US   web
    ## 
    ## $related_topics
    ##    subject related_topics                          value geo      keyword
    ## 1      100            top                   Thanksgiving  US thanksgiving
    ## 2       14            top                   Thanksgiving  US thanksgiving
    ## 3       10            top            Thanksgiving dinner  US thanksgiving
    ## 4        8            top                         Dinner  US thanksgiving
    ## 5        7            top                      Happiness  US thanksgiving
    ## 6        4            top Macy's Thanksgiving Day Parade  US thanksgiving
    ## 7        3            top                      Side dish  US thanksgiving
    ## 8        3            top                           Dish  US thanksgiving
    ## 9        3            top                        Dessert  US thanksgiving
    ## 10       2            top   A Charlie Brown Thanksgiving  US thanksgiving
    ## 11       2            top                         Parade  US thanksgiving
    ## 12       2            top                  Hors d'oeuvre  US thanksgiving
    ## 13       1            top                           Wish  US thanksgiving
    ## 14      <1            top                       Blessing  US thanksgiving
    ## 15      <1            top                       Greeting  US thanksgiving
    ## 16    +80%         rising                      Happiness  US thanksgiving
    ## 17    +50%         rising                           Wish  US thanksgiving
    ##    category
    ## 1         0
    ## 2         0
    ## 3         0
    ## 4         0
    ## 5         0
    ## 6         0
    ## 7         0
    ## 8         0
    ## 9         0
    ## 10        0
    ## 11        0
    ## 12        0
    ## 13        0
    ## 14        0
    ## 15        0
    ## 16        0
    ## 17        0

Gather Interest by State
------------------------

You can also embed plots, for example:

``` r
thanksgivingStates <- thanksgiving$interest_by_region
thanksgivingStates
```

    ##                location hits      keyword geo gprop
    ## 1            New Jersey  100 thanksgiving  US   web
    ## 2           Connecticut   93 thanksgiving  US   web
    ## 3         Massachusetts   91 thanksgiving  US   web
    ## 4          Rhode Island   91 thanksgiving  US   web
    ## 5  District of Columbia   87 thanksgiving  US   web
    ## 6              Virginia   87 thanksgiving  US   web
    ## 7         New Hampshire   86 thanksgiving  US   web
    ## 8              Maryland   85 thanksgiving  US   web
    ## 9              New York   85 thanksgiving  US   web
    ## 10              Florida   83 thanksgiving  US   web
    ## 11         Pennsylvania   83 thanksgiving  US   web
    ## 12              Arizona   83 thanksgiving  US   web
    ## 13       South Carolina   82 thanksgiving  US   web
    ## 14                Maine   81 thanksgiving  US   web
    ## 15             Delaware   80 thanksgiving  US   web
    ## 16               Kansas   80 thanksgiving  US   web
    ## 17       North Carolina   79 thanksgiving  US   web
    ## 18               Hawaii   79 thanksgiving  US   web
    ## 19             Illinois   77 thanksgiving  US   web
    ## 20                 Ohio   76 thanksgiving  US   web
    ## 21              Indiana   76 thanksgiving  US   web
    ## 22              Montana   75 thanksgiving  US   web
    ## 23             Missouri   74 thanksgiving  US   web
    ## 24           Washington   73 thanksgiving  US   web
    ## 25             Kentucky   73 thanksgiving  US   web
    ## 26               Nevada   73 thanksgiving  US   web
    ## 27                Texas   72 thanksgiving  US   web
    ## 28                 Utah   72 thanksgiving  US   web
    ## 29             Michigan   72 thanksgiving  US   web
    ## 30                 Iowa   71 thanksgiving  US   web
    ## 31            Tennessee   71 thanksgiving  US   web
    ## 32            Wisconsin   70 thanksgiving  US   web
    ## 33           New Mexico   69 thanksgiving  US   web
    ## 34         North Dakota   68 thanksgiving  US   web
    ## 35           California   68 thanksgiving  US   web
    ## 36             Oklahoma   68 thanksgiving  US   web
    ## 37              Georgia   68 thanksgiving  US   web
    ## 38         South Dakota   66 thanksgiving  US   web
    ## 39               Oregon   66 thanksgiving  US   web
    ## 40            Minnesota   66 thanksgiving  US   web
    ## 41                Idaho   64 thanksgiving  US   web
    ## 42        West Virginia   64 thanksgiving  US   web
    ## 43             Nebraska   63 thanksgiving  US   web
    ## 44              Vermont   63 thanksgiving  US   web
    ## 45               Alaska   63 thanksgiving  US   web
    ## 46              Alabama   62 thanksgiving  US   web
    ## 47             Colorado   62 thanksgiving  US   web
    ## 48            Louisiana   61 thanksgiving  US   web
    ## 49             Arkansas   61 thanksgiving  US   web
    ## 50              Wyoming   57 thanksgiving  US   web
    ## 51          Mississippi   55 thanksgiving  US   web

``` r
#The usmap requires the data in FIPS format.
# To gather the FIPS data, use the fips() function to convert state name to code
#https://www.rdocumentation.org/packages/cdlTools/versions/0.14/topics/fips

thanksgivingStates$fips <-fips(thanksgivingStates$location)
head(thanksgivingStates)
```

    ##               location hits      keyword geo gprop fips
    ## 1           New Jersey  100 thanksgiving  US   web   34
    ## 2          Connecticut   93 thanksgiving  US   web   09
    ## 3        Massachusetts   91 thanksgiving  US   web   25
    ## 4         Rhode Island   91 thanksgiving  US   web   44
    ## 5 District of Columbia   87 thanksgiving  US   web   11
    ## 6             Virginia   87 thanksgiving  US   web   51

Plot interest with the US Map by state
--------------------------------------

You can also embed plots, for example:

``` r
plot_usmap(data = thanksgivingStates, values = "hits",  color = orange, labels=FALSE) + 
  scale_fill_continuous( low = "white", high = orange, 
                         name = "Popularity", label = scales::comma
  ) + 
  theme(legend.position = "right") + 
  theme(panel.background = element_rect(colour = "black")) + 
  labs(title = "Popularity of Thanksgiving Google Search by State", caption = "Source: @littlemissdata") 
```

![](usmap_files/figure-markdown_github/unnamed-chunk-4-1.png)

Plot interest with the US Map by state
--------------------------------------

Regional divisions can be found in the docs
[here](https://cran.r-project.org/web/packages/usmap/usmap.pdf)

``` r
plot_usmap(data = thanksgivingStates, values = "hits", include =  c(.south_atlantic, .mid_atlantic), color = orange, labels=TRUE) + 
  scale_fill_continuous( low = "white", high = orange, 
                         name = "Popularity", label = scales::comma
  ) + 
  theme(legend.position = "right") + 
  theme(panel.background = element_rect(colour = "black")) + 
  labs(title = "US East Coast Popularity of Thanksgiving Google Search", caption = "Source: @littlemissdata") 
```

![](usmap_files/figure-markdown_github/unnamed-chunk-5-1.png)
