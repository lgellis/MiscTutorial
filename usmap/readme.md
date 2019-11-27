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

Use the [gTrendsR
Package](https://cran.r-project.org/web/packages/gtrendsR/gtrendsR.pdf)
to get the query trends for thanksgiving in the US for the past 24 hours

``` r
thanksgiving <- gtrends("thanksgiving",geo = "US", time = "now 1-d") # last day
head(thanksgiving)
```

    ## $interest_over_time
    ##                    date hits geo    time      keyword gprop category
    ## 1   2019-11-26 16:32:00   60  US now 1-d thanksgiving   web        0
    ## 2   2019-11-26 16:40:00   59  US now 1-d thanksgiving   web        0
    ## 3   2019-11-26 16:48:00   58  US now 1-d thanksgiving   web        0
    ## 4   2019-11-26 16:56:00   61  US now 1-d thanksgiving   web        0
    ## 5   2019-11-26 17:04:00   59  US now 1-d thanksgiving   web        0
    ## 6   2019-11-26 17:12:00   58  US now 1-d thanksgiving   web        0
    ## 7   2019-11-26 17:20:00   60  US now 1-d thanksgiving   web        0
    ## 8   2019-11-26 17:28:00   60  US now 1-d thanksgiving   web        0
    ## 9   2019-11-26 17:36:00   58  US now 1-d thanksgiving   web        0
    ## 10  2019-11-26 17:44:00   58  US now 1-d thanksgiving   web        0
    ## 11  2019-11-26 17:52:00   57  US now 1-d thanksgiving   web        0
    ## 12  2019-11-26 18:00:00   57  US now 1-d thanksgiving   web        0
    ## 13  2019-11-26 18:08:00   56  US now 1-d thanksgiving   web        0
    ## 14  2019-11-26 18:16:00   58  US now 1-d thanksgiving   web        0
    ## 15  2019-11-26 18:24:00   57  US now 1-d thanksgiving   web        0
    ## 16  2019-11-26 18:32:00   56  US now 1-d thanksgiving   web        0
    ## 17  2019-11-26 18:40:00   56  US now 1-d thanksgiving   web        0
    ## 18  2019-11-26 18:48:00   56  US now 1-d thanksgiving   web        0
    ## 19  2019-11-26 18:56:00   54  US now 1-d thanksgiving   web        0
    ## 20  2019-11-26 19:04:00   56  US now 1-d thanksgiving   web        0
    ## 21  2019-11-26 19:12:00   55  US now 1-d thanksgiving   web        0
    ## 22  2019-11-26 19:20:00   54  US now 1-d thanksgiving   web        0
    ## 23  2019-11-26 19:28:00   55  US now 1-d thanksgiving   web        0
    ## 24  2019-11-26 19:36:00   55  US now 1-d thanksgiving   web        0
    ## 25  2019-11-26 19:44:00   54  US now 1-d thanksgiving   web        0
    ## 26  2019-11-26 19:52:00   55  US now 1-d thanksgiving   web        0
    ## 27  2019-11-26 20:00:00   52  US now 1-d thanksgiving   web        0
    ## 28  2019-11-26 20:08:00   53  US now 1-d thanksgiving   web        0
    ## 29  2019-11-26 20:16:00   51  US now 1-d thanksgiving   web        0
    ## 30  2019-11-26 20:24:00   52  US now 1-d thanksgiving   web        0
    ## 31  2019-11-26 20:32:00   53  US now 1-d thanksgiving   web        0
    ## 32  2019-11-26 20:40:00   50  US now 1-d thanksgiving   web        0
    ## 33  2019-11-26 20:48:00   50  US now 1-d thanksgiving   web        0
    ## 34  2019-11-26 20:56:00   52  US now 1-d thanksgiving   web        0
    ## 35  2019-11-26 21:04:00   51  US now 1-d thanksgiving   web        0
    ## 36  2019-11-26 21:12:00   51  US now 1-d thanksgiving   web        0
    ## 37  2019-11-26 21:20:00   51  US now 1-d thanksgiving   web        0
    ## 38  2019-11-26 21:28:00   50  US now 1-d thanksgiving   web        0
    ## 39  2019-11-26 21:36:00   51  US now 1-d thanksgiving   web        0
    ## 40  2019-11-26 21:44:00   50  US now 1-d thanksgiving   web        0
    ## 41  2019-11-26 21:52:00   52  US now 1-d thanksgiving   web        0
    ## 42  2019-11-26 22:00:00   52  US now 1-d thanksgiving   web        0
    ## 43  2019-11-26 22:08:00   53  US now 1-d thanksgiving   web        0
    ## 44  2019-11-26 22:16:00   50  US now 1-d thanksgiving   web        0
    ## 45  2019-11-26 22:24:00   52  US now 1-d thanksgiving   web        0
    ## 46  2019-11-26 22:32:00   53  US now 1-d thanksgiving   web        0
    ## 47  2019-11-26 22:40:00   53  US now 1-d thanksgiving   web        0
    ## 48  2019-11-26 22:48:00   54  US now 1-d thanksgiving   web        0
    ## 49  2019-11-26 22:56:00   54  US now 1-d thanksgiving   web        0
    ## 50  2019-11-26 23:04:00   53  US now 1-d thanksgiving   web        0
    ## 51  2019-11-26 23:12:00   54  US now 1-d thanksgiving   web        0
    ## 52  2019-11-26 23:20:00   54  US now 1-d thanksgiving   web        0
    ## 53  2019-11-26 23:28:00   53  US now 1-d thanksgiving   web        0
    ## 54  2019-11-26 23:36:00   54  US now 1-d thanksgiving   web        0
    ## 55  2019-11-26 23:44:00   52  US now 1-d thanksgiving   web        0
    ## 56  2019-11-26 23:52:00   55  US now 1-d thanksgiving   web        0
    ## 57  2019-11-27 00:00:00   53  US now 1-d thanksgiving   web        0
    ## 58  2019-11-27 00:08:00   52  US now 1-d thanksgiving   web        0
    ## 59  2019-11-27 00:16:00   54  US now 1-d thanksgiving   web        0
    ## 60  2019-11-27 00:24:00   53  US now 1-d thanksgiving   web        0
    ## 61  2019-11-27 00:32:00   53  US now 1-d thanksgiving   web        0
    ## 62  2019-11-27 00:40:00   52  US now 1-d thanksgiving   web        0
    ## 63  2019-11-27 00:48:00   51  US now 1-d thanksgiving   web        0
    ## 64  2019-11-27 00:56:00   52  US now 1-d thanksgiving   web        0
    ## 65  2019-11-27 01:04:00   51  US now 1-d thanksgiving   web        0
    ## 66  2019-11-27 01:12:00   51  US now 1-d thanksgiving   web        0
    ## 67  2019-11-27 01:20:00   51  US now 1-d thanksgiving   web        0
    ## 68  2019-11-27 01:28:00   53  US now 1-d thanksgiving   web        0
    ## 69  2019-11-27 01:36:00   51  US now 1-d thanksgiving   web        0
    ## 70  2019-11-27 01:44:00   49  US now 1-d thanksgiving   web        0
    ## 71  2019-11-27 01:52:00   50  US now 1-d thanksgiving   web        0
    ## 72  2019-11-27 02:00:00   48  US now 1-d thanksgiving   web        0
    ## 73  2019-11-27 02:08:00   47  US now 1-d thanksgiving   web        0
    ## 74  2019-11-27 02:16:00   49  US now 1-d thanksgiving   web        0
    ## 75  2019-11-27 02:24:00   49  US now 1-d thanksgiving   web        0
    ## 76  2019-11-27 02:32:00   50  US now 1-d thanksgiving   web        0
    ## 77  2019-11-27 02:40:00   49  US now 1-d thanksgiving   web        0
    ## 78  2019-11-27 02:48:00   49  US now 1-d thanksgiving   web        0
    ## 79  2019-11-27 02:56:00   47  US now 1-d thanksgiving   web        0
    ## 80  2019-11-27 03:04:00   46  US now 1-d thanksgiving   web        0
    ## 81  2019-11-27 03:12:00   46  US now 1-d thanksgiving   web        0
    ## 82  2019-11-27 03:20:00   46  US now 1-d thanksgiving   web        0
    ## 83  2019-11-27 03:28:00   46  US now 1-d thanksgiving   web        0
    ## 84  2019-11-27 03:36:00   45  US now 1-d thanksgiving   web        0
    ## 85  2019-11-27 03:44:00   46  US now 1-d thanksgiving   web        0
    ## 86  2019-11-27 03:52:00   45  US now 1-d thanksgiving   web        0
    ## 87  2019-11-27 04:00:00   44  US now 1-d thanksgiving   web        0
    ## 88  2019-11-27 04:08:00   45  US now 1-d thanksgiving   web        0
    ## 89  2019-11-27 04:16:00   44  US now 1-d thanksgiving   web        0
    ## 90  2019-11-27 04:24:00   44  US now 1-d thanksgiving   web        0
    ## 91  2019-11-27 04:32:00   43  US now 1-d thanksgiving   web        0
    ## 92  2019-11-27 04:40:00   41  US now 1-d thanksgiving   web        0
    ## 93  2019-11-27 04:48:00   43  US now 1-d thanksgiving   web        0
    ## 94  2019-11-27 04:56:00   42  US now 1-d thanksgiving   web        0
    ## 95  2019-11-27 05:04:00   41  US now 1-d thanksgiving   web        0
    ## 96  2019-11-27 05:12:00   39  US now 1-d thanksgiving   web        0
    ## 97  2019-11-27 05:20:00   40  US now 1-d thanksgiving   web        0
    ## 98  2019-11-27 05:28:00   40  US now 1-d thanksgiving   web        0
    ## 99  2019-11-27 05:36:00   36  US now 1-d thanksgiving   web        0
    ## 100 2019-11-27 05:44:00   35  US now 1-d thanksgiving   web        0
    ## 101 2019-11-27 05:52:00   35  US now 1-d thanksgiving   web        0
    ## 102 2019-11-27 06:00:00   36  US now 1-d thanksgiving   web        0
    ## 103 2019-11-27 06:08:00   36  US now 1-d thanksgiving   web        0
    ## 104 2019-11-27 06:16:00   34  US now 1-d thanksgiving   web        0
    ## 105 2019-11-27 06:24:00   35  US now 1-d thanksgiving   web        0
    ## 106 2019-11-27 06:32:00   35  US now 1-d thanksgiving   web        0
    ## 107 2019-11-27 06:40:00   34  US now 1-d thanksgiving   web        0
    ## 108 2019-11-27 06:48:00   36  US now 1-d thanksgiving   web        0
    ## 109 2019-11-27 06:56:00   34  US now 1-d thanksgiving   web        0
    ## 110 2019-11-27 07:04:00   36  US now 1-d thanksgiving   web        0
    ## 111 2019-11-27 07:12:00   35  US now 1-d thanksgiving   web        0
    ## 112 2019-11-27 07:20:00   36  US now 1-d thanksgiving   web        0
    ## 113 2019-11-27 07:28:00   34  US now 1-d thanksgiving   web        0
    ## 114 2019-11-27 07:36:00   34  US now 1-d thanksgiving   web        0
    ## 115 2019-11-27 07:44:00   35  US now 1-d thanksgiving   web        0
    ## 116 2019-11-27 07:52:00   34  US now 1-d thanksgiving   web        0
    ## 117 2019-11-27 08:00:00   35  US now 1-d thanksgiving   web        0
    ## 118 2019-11-27 08:08:00   35  US now 1-d thanksgiving   web        0
    ## 119 2019-11-27 08:16:00   34  US now 1-d thanksgiving   web        0
    ## 120 2019-11-27 08:24:00   35  US now 1-d thanksgiving   web        0
    ## 121 2019-11-27 08:32:00   32  US now 1-d thanksgiving   web        0
    ## 122 2019-11-27 08:40:00   35  US now 1-d thanksgiving   web        0
    ## 123 2019-11-27 08:48:00   36  US now 1-d thanksgiving   web        0
    ## 124 2019-11-27 08:56:00   34  US now 1-d thanksgiving   web        0
    ## 125 2019-11-27 09:04:00   35  US now 1-d thanksgiving   web        0
    ## 126 2019-11-27 09:12:00   35  US now 1-d thanksgiving   web        0
    ## 127 2019-11-27 09:20:00   37  US now 1-d thanksgiving   web        0
    ## 128 2019-11-27 09:28:00   37  US now 1-d thanksgiving   web        0
    ## 129 2019-11-27 09:36:00   37  US now 1-d thanksgiving   web        0
    ## 130 2019-11-27 09:44:00   36  US now 1-d thanksgiving   web        0
    ## 131 2019-11-27 09:52:00   42  US now 1-d thanksgiving   web        0
    ## 132 2019-11-27 10:00:00   43  US now 1-d thanksgiving   web        0
    ## 133 2019-11-27 10:08:00   44  US now 1-d thanksgiving   web        0
    ## 134 2019-11-27 10:16:00   46  US now 1-d thanksgiving   web        0
    ## 135 2019-11-27 10:24:00   47  US now 1-d thanksgiving   web        0
    ## 136 2019-11-27 10:32:00   48  US now 1-d thanksgiving   web        0
    ## 137 2019-11-27 10:40:00   50  US now 1-d thanksgiving   web        0
    ## 138 2019-11-27 10:48:00   53  US now 1-d thanksgiving   web        0
    ## 139 2019-11-27 10:56:00   53  US now 1-d thanksgiving   web        0
    ## 140 2019-11-27 11:04:00   55  US now 1-d thanksgiving   web        0
    ## 141 2019-11-27 11:12:00   57  US now 1-d thanksgiving   web        0
    ## 142 2019-11-27 11:20:00   56  US now 1-d thanksgiving   web        0
    ## 143 2019-11-27 11:28:00   58  US now 1-d thanksgiving   web        0
    ## 144 2019-11-27 11:36:00   61  US now 1-d thanksgiving   web        0
    ## 145 2019-11-27 11:44:00   65  US now 1-d thanksgiving   web        0
    ## 146 2019-11-27 11:52:00   72  US now 1-d thanksgiving   web        0
    ## 147 2019-11-27 12:00:00   76  US now 1-d thanksgiving   web        0
    ## 148 2019-11-27 12:08:00   76  US now 1-d thanksgiving   web        0
    ## 149 2019-11-27 12:16:00   78  US now 1-d thanksgiving   web        0
    ## 150 2019-11-27 12:24:00   80  US now 1-d thanksgiving   web        0
    ## 151 2019-11-27 12:32:00   85  US now 1-d thanksgiving   web        0
    ## 152 2019-11-27 12:40:00   87  US now 1-d thanksgiving   web        0
    ## 153 2019-11-27 12:48:00   90  US now 1-d thanksgiving   web        0
    ## 154 2019-11-27 12:56:00   90  US now 1-d thanksgiving   web        0
    ## 155 2019-11-27 13:04:00   95  US now 1-d thanksgiving   web        0
    ## 156 2019-11-27 13:12:00   96  US now 1-d thanksgiving   web        0
    ## 157 2019-11-27 13:20:00   97  US now 1-d thanksgiving   web        0
    ## 158 2019-11-27 13:28:00   95  US now 1-d thanksgiving   web        0
    ## 159 2019-11-27 13:36:00   95  US now 1-d thanksgiving   web        0
    ## 160 2019-11-27 13:44:00   97  US now 1-d thanksgiving   web        0
    ## 161 2019-11-27 13:52:00   96  US now 1-d thanksgiving   web        0
    ## 162 2019-11-27 14:00:00   94  US now 1-d thanksgiving   web        0
    ## 163 2019-11-27 14:08:00   96  US now 1-d thanksgiving   web        0
    ## 164 2019-11-27 14:16:00   95  US now 1-d thanksgiving   web        0
    ## 165 2019-11-27 14:24:00   99  US now 1-d thanksgiving   web        0
    ## 166 2019-11-27 14:32:00   94  US now 1-d thanksgiving   web        0
    ## 167 2019-11-27 14:40:00   95  US now 1-d thanksgiving   web        0
    ## 168 2019-11-27 14:48:00   93  US now 1-d thanksgiving   web        0
    ## 169 2019-11-27 14:56:00   94  US now 1-d thanksgiving   web        0
    ## 170 2019-11-27 15:04:00   95  US now 1-d thanksgiving   web        0
    ## 171 2019-11-27 15:12:00   91  US now 1-d thanksgiving   web        0
    ## 172 2019-11-27 15:20:00   92  US now 1-d thanksgiving   web        0
    ## 173 2019-11-27 15:28:00   91  US now 1-d thanksgiving   web        0
    ## 174 2019-11-27 15:36:00   95  US now 1-d thanksgiving   web        0
    ## 175 2019-11-27 15:44:00   94  US now 1-d thanksgiving   web        0
    ## 176 2019-11-27 15:52:00   95  US now 1-d thanksgiving   web        0
    ## 177 2019-11-27 16:00:00   94  US now 1-d thanksgiving   web        0
    ## 178 2019-11-27 16:08:00   90  US now 1-d thanksgiving   web        0
    ## 179 2019-11-27 16:16:00   92  US now 1-d thanksgiving   web        0
    ## 180 2019-11-27 16:24:00  100  US now 1-d thanksgiving   web        0
    ## 
    ## $interest_by_country
    ## NULL
    ## 
    ## $interest_by_region
    ##                location hits      keyword geo gprop
    ## 1            New Jersey  100 thanksgiving  US   web
    ## 2         Massachusetts   90 thanksgiving  US   web
    ## 3           Connecticut   90 thanksgiving  US   web
    ## 4          Rhode Island   89 thanksgiving  US   web
    ## 5         New Hampshire   86 thanksgiving  US   web
    ## 6              Virginia   86 thanksgiving  US   web
    ## 7              New York   86 thanksgiving  US   web
    ## 8  District of Columbia   85 thanksgiving  US   web
    ## 9              Maryland   84 thanksgiving  US   web
    ## 10         Pennsylvania   82 thanksgiving  US   web
    ## 11              Arizona   82 thanksgiving  US   web
    ## 12              Florida   81 thanksgiving  US   web
    ## 13       South Carolina   80 thanksgiving  US   web
    ## 14             Delaware   80 thanksgiving  US   web
    ## 15                Maine   79 thanksgiving  US   web
    ## 16               Hawaii   79 thanksgiving  US   web
    ## 17               Kansas   77 thanksgiving  US   web
    ## 18       North Carolina   77 thanksgiving  US   web
    ## 19             Illinois   76 thanksgiving  US   web
    ## 20              Indiana   75 thanksgiving  US   web
    ## 21                 Ohio   75 thanksgiving  US   web
    ## 22           Washington   75 thanksgiving  US   web
    ## 23              Montana   72 thanksgiving  US   web
    ## 24             Missouri   71 thanksgiving  US   web
    ## 25                Texas   71 thanksgiving  US   web
    ## 26             Michigan   71 thanksgiving  US   web
    ## 27             Kentucky   71 thanksgiving  US   web
    ## 28               Nevada   71 thanksgiving  US   web
    ## 29                 Utah   71 thanksgiving  US   web
    ## 30         North Dakota   71 thanksgiving  US   web
    ## 31            Tennessee   70 thanksgiving  US   web
    ## 32            Wisconsin   70 thanksgiving  US   web
    ## 33           New Mexico   69 thanksgiving  US   web
    ## 34                 Iowa   69 thanksgiving  US   web
    ## 35              Georgia   68 thanksgiving  US   web
    ## 36           California   68 thanksgiving  US   web
    ## 37             Oklahoma   67 thanksgiving  US   web
    ## 38               Oregon   65 thanksgiving  US   web
    ## 39            Minnesota   65 thanksgiving  US   web
    ## 40         South Dakota   65 thanksgiving  US   web
    ## 41                Idaho   64 thanksgiving  US   web
    ## 42               Alaska   64 thanksgiving  US   web
    ## 43        West Virginia   63 thanksgiving  US   web
    ## 44             Nebraska   63 thanksgiving  US   web
    ## 45             Colorado   62 thanksgiving  US   web
    ## 46              Vermont   62 thanksgiving  US   web
    ## 47              Alabama   61 thanksgiving  US   web
    ## 48             Arkansas   61 thanksgiving  US   web
    ## 49            Louisiana   61 thanksgiving  US   web
    ## 50              Wyoming   56 thanksgiving  US   web
    ## 51          Mississippi   54 thanksgiving  US   web
    ## 
    ## $interest_by_dma
    ##                                                    location hits
    ## 1                                   Hartford & New Haven CT  100
    ## 2                              Providence RI-New Bedford MA   99
    ## 3                                   Boston MA-Manchester NH   99
    ## 4                                               New York NY   97
    ## 5                                           Philadelphia PA   95
    ## 6                             Washington DC (Hagerstown MD)   95
    ## 7                             West Palm Beach-Ft. Pierce FL   95
    ## 8                                       Ft. Myers-Naples FL   91
    ## 9                                   Miami-Ft. Lauderdale FL   91
    ## 10                                             Baltimore MD   90
    ## 11                       Norfolk-Portsmouth-Newport News VA   90
    ## 12                               Albany-Schenectady-Troy NY   89
    ## 13                                               Phoenix AZ   89
    ## 14                       Tampa-St. Petersburg (Sarasota) FL   88
    ## 15                                       Portland-Auburn ME   88
    ## 16                                             Charlotte NC   87
    ## 17                                            Pittsburgh PA   87
    ## 18                                              Glendive MT   86
    ## 19                                              Columbus OH   86
    ## 20                                 Florence-Myrtle Beach SC   86
    ## 21                                            Charleston SC   86
    ## 22                                                Austin TX   86
    ## 23                                              Honolulu HI   85
    ## 24                                            Cincinnati OH   85
    ## 25                                          Jacksonville FL   85
    ## 26                                             Rochester NY   85
    ## 27       Greenville-Spartanburg SC-Asheville NC-Anderson SC   84
    ## 28                                               Buffalo NY   84
    ## 29                       Orlando-Daytona Beach-Melbourne FL   84
    ## 30                                   Richmond-Petersburg VA   84
    ## 31                         Raleigh-Durham (Fayetteville) NC   83
    ## 32                                               Chicago IL   83
    ## 33                     Harrisburg-Lancaster-Lebanon-York PA   83
    ## 34                                 Tucson (Sierra Vista) AZ   82
    ## 35                                             Knoxville TN   82
    ## 36                                             Lafayette IN   82
    ## 37                                     Roanoke-Lynchburg VA   81
    ## 38                                           Kansas City MO   81
    ## 39                                 Wilkes Barre-Scranton PA   81
    ## 40                                          Indianapolis IN   81
    ## 41                                               Houston TX   80
    ## 42                                        Seattle-Tacoma WA   80
    ## 43                                              Missoula MT   80
    ## 44                                       Charlottesville VA   80
    ## 45                                           Los Angeles CA   80
    ## 46                                             San Diego CA   80
    ## 47                                   Springfield-Holyoke MA   79
    ## 48                                    South Bend-Elkhart IN   79
    ## 49                                             Milwaukee WI   79
    ## 50                                              Syracuse NY   79
    ## 51                                             Nashville TN   79
    ## 52                                            Binghamton NY   79
    ## 53                                      Dallas-Ft. Worth TX   79
    ## 54                                               Madison WI   78
    ## 55                                    Green Bay-Appleton WI   78
    ## 56                                            Louisville KY   78
    ## 57                              Cleveland-Akron (Canton) OH   78
    ## 58                                               Detroit MI   78
    ## 59                                           Great Falls MT   78
    ## 60                                        Salt Lake City UT   77
    ## 61                                            St. Joseph MO   77
    ## 62                                            Wilmington NC   77
    ## 63                                               Atlanta GA   76
    ## 64                                          Harrisonburg VA   76
    ## 65                                             Salisbury MD   76
    ## 66                                             St. Louis MO   76
    ## 67                                             Lexington KY   76
    ## 68                                             Billings, MT   76
    ## 69                                           Chattanooga TN   76
    ## 70                                             Las Vegas NV   75
    ## 71                                                Bangor ME   75
    ## 72                                                Topeka KS   75
    ## 73                                  Albuquerque-Santa Fe NM   75
    ## 74                   Grand Rapids-Kalamazoo-Battle Creek MI   75
    ## 75                                       Des Moines-Ames IA   74
    ## 76                                              Portland OR   74
    ## 77                Mobile AL-Pensacola (Ft. Walton Beach) FL   74
    ## 78                                              Columbia SC   74
    ## 79                                                 Omaha NE   74
    ## 80                                           Springfield MO   74
    ## 81                                                Elmira NY   74
    ## 82                           Sacramento-Stockton-Modesto CA   74
    ## 83                                    Wichita-Hutchinson KS   74
    ## 84                   Greensboro-High Point-Winston Salem NC   73
    ## 85                                                Juneau AK   73
    ## 86                                Flint-Saginaw-Bay City MI   73
    ## 87                                           San Antonio TX   73
    ## 88                                            Rapid City SD   73
    ## 89                        San Francisco-Oakland-San Jose CA   73
    ## 90                                                 Utica NY   72
    ## 91                                         Oklahoma City OK   72
    ## 92                   Minot-Bismarck-Dickinson(Williston) ND   72
    ## 93                                              Savannah GA   72
    ## 94                                          Presque Isle ME   72
    ## 95                                               Spokane WA   72
    ## 96                             Burlington VT-Plattsburgh NY   71
    ## 97                                         Butte-Bozeman MT   71
    ## 98             Cedar Rapids-Waterloo-Iowa City & Dubuque IA   71
    ## 99                                                  Erie PA   71
    ## 100                                            Anchorage AK   71
    ## 101                                               Alpena MI   71
    ## 102                                    Fargo-Valley City ND   71
    ## 103                                               Dayton OH   70
    ## 104                                        Bowling Green KY   70
    ## 105                                                Tulsa OK   70
    ## 106                                          New Orleans LA   70
    ## 107                                           Zanesville OH   70
    ## 108                                               Toledo OH   69
    ## 109                      Champaign & Springfield-Decatur IL   69
    ## 110                                          Panama City FL   69
    ## 111                                       Corpus Christi TX   69
    ## 112                                  Joplin MO-Pittsburg KS   69
    ## 113                                 Minneapolis-St. Paul MN   68
    ## 114                                   Peoria-Bloomington IL   68
    ## 115                                    Waco-Temple-Bryan TX   68
    ## 116                                             Rockford IL   68
    ## 117                              Columbia-Jefferson City MO   68
    ## 118                                           San Angelo TX   68
    ## 119                                               Denver CO   67
    ## 120                                          Gainesville FL   67
    ## 121                                         Palm Springs CA   67
    ## 122                              Colorado Springs-Pueblo CO   67
    ## 123                                               Helena MT   67
    ## 124                             Wheeling WV-Steubenville OH   66
    ## 125                       Greenville-New Bern-Washington NC   66
    ## 126                                Ottumwa IA-Kirksville MO   66
    ## 127                                    Johnstown-Altoona PA   66
    ## 128                         Quincy IL-Hannibal MO-Keokuk IA   66
    ## 129                                        Tri-Cities TN-VA   66
    ## 130                                           Birmingham AL   66
    ## 131                      Davenport IA-Rock Island-Moline IL   66
    ## 132                                             Victoria TX   65
    ## 133                                            Marquette MI   65
    ## 134                                       Fresno-Visalia CA   65
    ## 135                                              El Paso TX   65
    ## 136                                             Amarillo TX   65
    ## 137                               Traverse City-Cadillac MI   65
    ## 138                                          Terre Haute IN   65
    ## 139                                            Ft. Wayne IN   65
    ## 140             Ft. Smith-Fayetteville-Springdale-Rogers AR   65
    ## 141                                   Abilene-Sweetwater TX   64
    ## 142                                              Lansing MI   64
    ## 143                                       Sherman TX-Ada OK   64
    ## 144                           Bluefield-Beckley-Oak Hill WV   64
    ## 145                                            Watertown NY   64
    ## 146                                                 Reno NV   64
    ## 147                              Grand Junction-Montrose CO   64
    ## 148                                Sioux Falls(Mitchell) SD   64
    ## 149                                      Casper-Riverton WY   64
    ## 150                                   Wausau-Rhinelander WI   64
    ## 151                            Wichita Falls TX & Lawton OK   63
    ## 152                                                Boise ID   63
    ## 153                                           Evansville IN   63
    ## 154                                              Lubbock TX   63
    ## 155                                            Fairbanks AK   62
    ## 156                                              Memphis TN   62
    ## 157                                           Twin Falls ID   62
    ## 158                    Rochester MN-Mason City IA-Austin MN   62
    ## 159                               Little Rock-Pine Bluff AR   62
    ## 160                                           Youngstown OH   62
    ## 161                                Idaho Falls-Pocatello ID   61
    ## 162                                             Columbus GA   61
    ## 163 Paducah KY-Cape Girardeau MO-Harrisburg-Mount Vernon IL   61
    ## 164                      Yakima-Pasco-Richland-Kennewick WA   61
    ## 165                           Tallahassee FL-Thomasville GA   61
    ## 166                        Huntsville-Decatur (Florence) AL   60
    ## 167                                          Parkersburg WV   60
    ## 168                                   Duluth MN-Superior WI   60
    ## 169                                      Biloxi-Gulfport MS   60
    ## 170                                              Jackson TN   59
    ## 171                                    Yuma AZ-El Centro CA   59
    ## 172                                              Mankato MN   59
    ## 173                                       Odessa-Midland TX   58
    ## 174                                                 Lima OH   58
    ## 175                                     Monterey-Salinas CA   57
    ## 176                                              Augusta GA   57
    ## 177            Santa Barbara-Santa Maria-San Luis Obispo CA   57
    ## 178                                Charleston-Huntington WV   57
    ## 179                                          Baton Rouge LA   56
    ## 180                                                 Bend OR   56
    ## 181                 Tyler-Longview(Lufkin & Nacogdoches) TX   55
    ## 182                                         Lake Charles LA   55
    ## 183                                           Alexandria LA   55
    ## 184                                   Hattiesburg-Laurel MS   55
    ## 185                           Columbus-Tupelo-West Point MS   54
    ## 186                                 La Crosse-Eau Claire WI   54
    ## 187                                                Macon GA   54
    ## 188                                        Chico-Redding CA   53
    ## 189                                    Clarksburg-Weston WV   53
    ## 190                                               Eugene OR   53
    ## 191                                           Shreveport LA   53
    ## 192                           Lincoln & Hastings-Kearney NE   53
    ## 193                                             Meridian MS   53
    ## 194                                            Lafayette LA   53
    ## 195                                               Dothan AL   53
    ## 196                                               Albany GA   53
    ## 197                                          Bakersfield CA   53
    ## 198                                   Montgomery (Selma) AL   52
    ## 199                                               Laredo TX   52
    ## 200                Harlingen-Weslaco-Brownsville-McAllen TX   51
    ## 201                                 Beaumont-Port Arthur TX   51
    ## 202                                            Jonesboro AR   50
    ## 203                                               Eureka CA   50
    ## 204                                  Monroe LA-El Dorado AR   50
    ## 205                                Medford-Klamath Falls OR   50
    ## 206                              Cheyenne WY-Scottsbluff NE   50
    ## 207                                              Jackson MS   46
    ## 208                                           Sioux City IA   46
    ## 209                                         North Platte NE   42
    ## 210                                 Greenwood-Greenville MS   40
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
    ## 2                Hillburn   NA thanksgiving  US   web
    ## 3             South Miami   NA thanksgiving  US   web
    ## 4               Long Hill   NA thanksgiving  US   web
    ## 5              Knightdale   NA thanksgiving  US   web
    ## 6                Leesburg  100 thanksgiving  US   web
    ## 7                Westwood   NA thanksgiving  US   web
    ## 8                   Essex   NA thanksgiving  US   web
    ## 9                 Wantagh   NA thanksgiving  US   web
    ## 10                Horsham   NA thanksgiving  US   web
    ## 11           Mount Laurel   NA thanksgiving  US   web
    ## 12               Melville   NA thanksgiving  US   web
    ## 13        Monroe Township   NA thanksgiving  US   web
    ## 14             Bloomfield   NA thanksgiving  US   web
    ## 15      Marlboro Township   NA thanksgiving  US   web
    ## 16    North New Hyde Park   NA thanksgiving  US   web
    ## 17               Johnston   NA thanksgiving  US   web
    ## 18       Berkeley Heights   NA thanksgiving  US   web
    ## 19                Holmdel   NA thanksgiving  US   web
    ## 20     Middleburg Heights   NA thanksgiving  US   web
    ## 21                 Weston   NA thanksgiving  US   web
    ## 22             Livingston   NA thanksgiving  US   web
    ## 23          Wall Township   NA thanksgiving  US   web
    ## 24                Jackson   NA thanksgiving  US   web
    ## 25                 Natick   NA thanksgiving  US   web
    ## 26               Cheshire   NA thanksgiving  US   web
    ## 27             Massapequa   NA thanksgiving  US   web
    ## 28           Coral Gables   NA thanksgiving  US   web
    ## 29              Hauppauge   NA thanksgiving  US   web
    ## 30                Commack   NA thanksgiving  US   web
    ## 31              Plainview   NA thanksgiving  US   web
    ## 32      Franklin Township   NA thanksgiving  US   web
    ## 33      Hopewell Township   NA thanksgiving  US   web
    ## 34                 Edison   87 thanksgiving  US   web
    ## 35                Beverly   NA thanksgiving  US   web
    ## 36          Mount Lebanon   NA thanksgiving  US   web
    ## 37   Springfield Township   NA thanksgiving  US   web
    ## 38                  Wayne   NA thanksgiving  US   web
    ## 39    Old Bridge Township   NA thanksgiving  US   web
    ## 40                 Howell   87 thanksgiving  US   web
    ## 41           Eden Prairie   87 thanksgiving  US   web
    ## 42        Sparta Township   NA thanksgiving  US   web
    ## 43  West Windsor Township   NA thanksgiving  US   web
    ## 44                Paramus   NA thanksgiving  US   web
    ## 45          Mechanicsburg   NA thanksgiving  US   web
    ## 46             Merrifield   NA thanksgiving  US   web
    ## 47               Freeport   NA thanksgiving  US   web
    ## 48                Andover   NA thanksgiving  US   web
    ## 49              Levittown   NA thanksgiving  US   web
    ## 50               Plymouth   NA thanksgiving  US   web
    ## 51             Middletown   NA thanksgiving  US   web
    ## 52                Needham   NA thanksgiving  US   web
    ## 53    Washington Township   NA thanksgiving  US   web
    ## 54      Lawrence Township   NA thanksgiving  US   web
    ## 55            West Orange   NA thanksgiving  US   web
    ## 56                 Oakton   NA thanksgiving  US   web
    ## 57           Gaithersburg   NA thanksgiving  US   web
    ## 58                Clayton   NA thanksgiving  US   web
    ## 59            Southington   NA thanksgiving  US   web
    ## 60              Hockinson   NA thanksgiving  US   web
    ## 61              Princeton   NA thanksgiving  US   web
    ## 62            Cherry Hill   NA thanksgiving  US   web
    ## 63              Lexington   NA thanksgiving  US   web
    ## 64                Devault   NA thanksgiving  US   web
    ## 65          Miami Springs   NA thanksgiving  US   web
    ## 66                 McLean   NA thanksgiving  US   web
    ## 67              Braintree   NA thanksgiving  US   web
    ## 68           White Plains   NA thanksgiving  US   web
    ## 69             Glen Ridge   NA thanksgiving  US   web
    ## 70           Pimmit Hills   NA thanksgiving  US   web
    ## 71            Mooresville   NA thanksgiving  US   web
    ## 72           New Rochelle   NA thanksgiving  US   web
    ## 73           Severna Park   NA thanksgiving  US   web
    ## 74                 Reston   NA thanksgiving  US   web
    ## 75              Levittown   NA thanksgiving  US   web
    ## 76     Manalapan Township   NA thanksgiving  US   web
    ## 77                Hanover   NA thanksgiving  US   web
    ## 78             Doylestown   NA thanksgiving  US   web
    ## 79     Hilton Head Island   NA thanksgiving  US   web
    ## 80             Middletown   NA thanksgiving  US   web
    ## 81        East Providence   NA thanksgiving  US   web
    ## 82               Westport   NA thanksgiving  US   web
    ## 83       Roxbury Township   NA thanksgiving  US   web
    ## 84                 Hamden   NA thanksgiving  US   web
    ## 85           Orchard Park   NA thanksgiving  US   web
    ## 86                Bayonne   NA thanksgiving  US   web
    ## 87               Weymouth   NA thanksgiving  US   web
    ## 88               Surprise   NA thanksgiving  US   web
    ## 89          Pompano Beach   NA thanksgiving  US   web
    ## 90           Myrtle Beach   NA thanksgiving  US   web
    ## 91            Glastonbury   NA thanksgiving  US   web
    ## 92          West Hartford   NA thanksgiving  US   web
    ## 93               Fort Lee   NA thanksgiving  US   web
    ## 94              Fort Mill   NA thanksgiving  US   web
    ## 95               Stamford   NA thanksgiving  US   web
    ## 96                Milford   NA thanksgiving  US   web
    ## 97     Montgomery Village   NA thanksgiving  US   web
    ## 98             Cumberland   NA thanksgiving  US   web
    ## 99               Beaufort   NA thanksgiving  US   web
    ## 100              Maitland   NA thanksgiving  US   web
    ## 101            Burlington   NA thanksgiving  US   web
    ## 102       Carolina Forest   NA thanksgiving  US   web
    ## 103             West Bend   NA thanksgiving  US   web
    ## 104            Boca Raton   NA thanksgiving  US   web
    ## 105                 Salem   NA thanksgiving  US   web
    ## 106             Watertown   NA thanksgiving  US   web
    ## 107             Tarrytown   NA thanksgiving  US   web
    ## 108                Woburn   NA thanksgiving  US   web
    ## 109              Aventura   NA thanksgiving  US   web
    ## 110              Vineland   NA thanksgiving  US   web
    ## 111        Virginia Beach   78 thanksgiving  US   web
    ## 112        North Bethesda   NA thanksgiving  US   web
    ## 113               Tamiami   NA thanksgiving  US   web
    ## 114                 Mason   NA thanksgiving  US   web
    ## 115        East Brunswick   NA thanksgiving  US   web
    ## 116           Bridgewater   NA thanksgiving  US   web
    ## 117            Washington   78 thanksgiving  US   web
    ## 118               Suwanee   NA thanksgiving  US   web
    ## 119               Norwalk   NA thanksgiving  US   web
    ## 120                Destin   NA thanksgiving  US   web
    ## 121            Alexandria   77 thanksgiving  US   web
    ## 122               Kendall   NA thanksgiving  US   web
    ## 123                  Golf   NA thanksgiving  US   web
    ## 124         Bel Air South   NA thanksgiving  US   web
    ## 125           Kings Point   NA thanksgiving  US   web
    ## 126          Delray Beach   NA thanksgiving  US   web
    ## 127             Billerica   NA thanksgiving  US   web
    ## 128         Silver Spring   77 thanksgiving  US   web
    ## 129         Scotch Plains   NA thanksgiving  US   web
    ## 130             Attleboro   NA thanksgiving  US   web
    ## 131                 Brick   NA thanksgiving  US   web
    ## 132              New York   77 thanksgiving  US   web
    ## 133            Hackensack   NA thanksgiving  US   web
    ## 134         Coral Springs   NA thanksgiving  US   web
    ## 135                 Davie   77 thanksgiving  US   web
    ## 136                Boston   77 thanksgiving  US   web
    ## 137       King of Prussia   NA thanksgiving  US   web
    ## 138           Sevierville   NA thanksgiving  US   web
    ## 139              Glenview   NA thanksgiving  US   web
    ## 140               Roswell   76 thanksgiving  US   web
    ## 141               Coppell   NA thanksgiving  US   web
    ## 142              Franklin   NA thanksgiving  US   web
    ## 143               Waltham   NA thanksgiving  US   web
    ## 144             Greenwich   NA thanksgiving  US   web
    ## 145                Newton   76 thanksgiving  US   web
    ## 146           Johns Creek   NA thanksgiving  US   web
    ## 147              Elkridge   NA thanksgiving  US   web
    ## 148                 Doral   76 thanksgiving  US   web
    ## 149                Dublin   NA thanksgiving  US   web
    ## 150            Fruit Cove   NA thanksgiving  US   web
    ## 151               Danbury   NA thanksgiving  US   web
    ## 152              Denville   NA thanksgiving  US   web
    ## 153         Ellicott City   NA thanksgiving  US   web
    ## 154 West University Place   NA thanksgiving  US   web
    ## 155                  Lehi   NA thanksgiving  US   web
    ## 156                 Largo   NA thanksgiving  US   web
    ## 157             Montclair   NA thanksgiving  US   web
    ## 158    Palm Beach Gardens   NA thanksgiving  US   web
    ## 159              Wildwood   NA thanksgiving  US   web
    ## 160          West Babylon   NA thanksgiving  US   web
    ## 161            Somerville   NA thanksgiving  US   web
    ## 162            Clearwater   74 thanksgiving  US   web
    ## 163             Weehawken   NA thanksgiving  US   web
    ## 164               Batavia   NA thanksgiving  US   web
    ## 165             Chantilly   74 thanksgiving  US   web
    ## 166              Columbus   74 thanksgiving  US   web
    ## 167        Merritt Island   NA thanksgiving  US   web
    ## 168       Deerfield Beach   NA thanksgiving  US   web
    ## 169                  Apex   NA thanksgiving  US   web
    ## 170           Glen Burnie   NA thanksgiving  US   web
    ## 171             Lake Mary   NA thanksgiving  US   web
    ## 172   Manchester Township   NA thanksgiving  US   web
    ## 173                Verona   74 thanksgiving  US   web
    ## 174                Malden   NA thanksgiving  US   web
    ## 175               Phoenix   74 thanksgiving  US   web
    ## 176      Town 'n' Country   NA thanksgiving  US   web
    ## 177              Oak Park   NA thanksgiving  US   web
    ## 178           Queen Creek   NA thanksgiving  US   web
    ## 179             Annandale   NA thanksgiving  US   web
    ## 180    Saint Clair Shores   NA thanksgiving  US   web
    ## 181        Mount Pleasant   NA thanksgiving  US   web
    ## 182             Royal Oak   NA thanksgiving  US   web
    ## 183          College Park   NA thanksgiving  US   web
    ## 184             Hollywood   74 thanksgiving  US   web
    ## 185              Franklin   NA thanksgiving  US   web
    ## 186             Charlotte   74 thanksgiving  US   web
    ## 187               Endwell   NA thanksgiving  US   web
    ## 188                 Burke   NA thanksgiving  US   web
    ## 189         Daytona Beach   NA thanksgiving  US   web
    ## 190       Menomonee Falls   NA thanksgiving  US   web
    ## 191              Bee Cave   NA thanksgiving  US   web
    ## 192                Quincy   NA thanksgiving  US   web
    ## 193            Aspen Hill   NA thanksgiving  US   web
    ## 194            Plantation   73 thanksgiving  US   web
    ## 195               Dunedin   NA thanksgiving  US   web
    ## 196               Warwick   NA thanksgiving  US   web
    ## 197       Fairfax Station   NA thanksgiving  US   web
    ## 198                Albany   73 thanksgiving  US   web
    ## 199          Owings Mills   NA thanksgiving  US   web
    ## 200              Farragut   NA thanksgiving  US   web
    ## 
    ## $related_topics
    ##    subject related_topics                          value geo      keyword
    ## 1      100            top                   Thanksgiving  US thanksgiving
    ## 2       14            top                   Thanksgiving  US thanksgiving
    ## 3       10            top            Thanksgiving dinner  US thanksgiving
    ## 4        7            top                      Happiness  US thanksgiving
    ## 5        7            top                         Dinner  US thanksgiving
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
    ## 17    +60%         rising                           Wish  US thanksgiving
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

Select the data frame for interest by state and then convert the names
of the states to FIPS codes (2 characters for state, 5 characters for
county).

``` r
thanksgivingStates <- thanksgiving$interest_by_region

#The usmap requires the data in FIPS format.
# To gather the FIPS data, use the fips() function to convert state name to code
#https://www.rdocumentation.org/packages/cdlTools/versions/0.14/topics/fips

thanksgivingStates$fips <-fips(thanksgivingStates$location)
```

Plot interest with the US Map by state
--------------------------------------

Create a US heatmap with google search popularity for the keyword
“thanksgiving”.

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

Drill in on the seemingly most popular regions using the “include”
parameter in the plot\_usmap() function. Regional divisions can be found
in the docs
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
