Install and Load Packages
-------------------------

Round 1: Simple and Fun Set Intersection
----------------------------------------

### Assign the Set Sizing

``` r
#Data
expressionInput <- c(`#rstats` = 5, memes = 5, `#rstats&memes`=3)
```

### Create a Venn Diagram

``` r
#Venn
#note on set up for java v11 jdk (v12 does not work with this)
myExpVenn <- venneuler(expressionInput)
plot(myExpVenn, main = "Why I Love Twitter", sub = "@littlemissdata")
```

![](readme_files/figure-markdown_github/unnamed-chunk-2-1.png)

### Create an UpsetR Chart

``` r
#UpsetR
upset(fromExpression(expressionInput), order.by = "freq")
grid.text(
  "Why I Love Twitter @littlemissdata",
  x = 0.80,
  y = 0.05,
  gp = gpar(
    fontsize = 10,
    fontface = 3
  )
) #created the label via grid with hack found here: https://github.com/hms-dbmi/UpSetR/issues/76
```

![](readme_files/figure-markdown_github/unnamed-chunk-3-1.png)

Bring in Data
-------------

The data is based on the [2017 Toronto Senior Survey](https://www.toronto.ca/city-government/data-research-maps/open-data/open-data-catalogue/community-services/#9ece3c85-08c9-097d-f4c8-bb7374fea6c1) from the [Toronto Open Data Catalogue](Open%20Data%20Catalogue).

I have taken it and reformatted, to include general questions relating to the person as well as transportation questions.

<table style="width:39%;">
<colgroup>
<col width="19%" />
<col width="19%" />
</colgroup>
<thead>
<tr class="header">
<th>Column</th>
<th>Source Column</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>ID</td>
<td>Not previously included. This is a new unique key column.</td>
</tr>
<tr class="even">
<td>physicalActivity</td>
<td>Survey Question: &quot;1. In the past 3 months, how often did you participate in physical activities like walking?&quot;</td>
</tr>
<tr class="odd">
<td>volunteerParticipation</td>
<td>Survey Question: &quot;5. During the past 3 months, how often did you participate in volunteer or charity work?&quot;</td>
</tr>
<tr class="even">
<td>difficultFinancial</td>
<td>Survey Question: &quot;9. In the last year, have you had difficulty paying your rent, mortgage, Hydro bill, or other housing costs? For example, have you had to go without groceries to pay for rent or other monthly housing expenses?&quot;</td>
</tr>
<tr class="odd">
<td>supportSystem</td>
<td>Survey Question: &quot;13. Do you have people in your life who you can call on for help if you need it?&quot;</td>
</tr>
<tr class="even">
<td>postalCode</td>
<td>&quot;Survey Question: 14. What are the first three characters of your postal code?&quot;</td>
</tr>
<tr class="odd">
<td>employmentStatus</td>
<td>Survey Question: &quot;15. What is your current employment status?&quot;</td>
</tr>
<tr class="even">
<td>sex</td>
<td>Survey Question: &quot;16. What is your sex/gender?&quot;</td>
</tr>
<tr class="odd">
<td>primaryLanguage</td>
<td>Survey Question: &quot;18. In what language(s) would you feel most comfortable to receive services?&quot; (first option listed)</td>
</tr>
<tr class="even">
<td>ageRange</td>
<td>Survey Question: &quot;19. Which age category do you belong to?&quot;</td>
</tr>
<tr class="odd">
<td>ttcTransportation</td>
<td>Survey Question: &quot;6. To get around Toronto, what modes of transportation do you use frequently? [TTC (bus, subway, or streetcar)]&quot;</td>
</tr>
<tr class="even">
<td>walkTransportation</td>
<td>Survey Question: &quot;6. To get around Toronto, what modes of transportation do you use frequently? [Walk]&quot;</td>
</tr>
<tr class="odd">
<td>driveTransportation</td>
<td>Survey Question: &quot;6. To get around Toronto, what modes of transportation do you use frequently? [Drive]&quot;</td>
</tr>
<tr class="even">
<td>cycleTransportation</td>
<td>Survey Question: &quot;6. To get around Toronto, what modes of transportation do you use frequently? [Cycle]&quot;</td>
</tr>
<tr class="odd">
<td>taxiTransportation</td>
<td>Survey Question: &quot; 6. To get around Toronto, what modes of transportation do you use frequently? [Taxi or Uber]&quot;</td>
</tr>
<tr class="even">
<td>communityRideTransportation</td>
<td>Survey Question: &quot;6. To get around Toronto, what modes of transportation do you use frequently? [Community Transportation Program, for example Toronto Ride or iRIDE]&quot;</td>
</tr>
<tr class="odd">
<td>wheelTransTransportation</td>
<td>Survey Question: &quot;6. To get around Toronto, what modes of transportation do you use frequently? [Wheel-Trans]&quot;</td>
</tr>
<tr class="even">
<td>friendsTransportation</td>
<td>Survey Question: &quot;6. To get around Toronto, what modes of transportation do you use frequently? [Rides from family, friends or neighbours]&quot;</td>
</tr>
</tbody>
</table>

    volunteerParticipation                                                          

``` r
sets <- read.csv(file="https://raw.githubusercontent.com/lgellis/MiscTutorial/master/sets/seniorTransportation.csv",
                      header=TRUE, sep=",", stringsAsFactors = FALSE)

#Some formatting

head(sets,2)
```

    ##   ID     physicalActivity volunteerParticipation difficultFinancial
    ## 1  1  At least once a day                  Never                 No
    ## 2  2 At least once a week                                        No
    ##   supportSystem postalCode employmentStatus    sex primaryLanguage
    ## 1           Yes        m4S          Retired Female         English
    ## 2           Yes        M3h          Retired                       
    ##      ageRange ttcTransportation walkTransportation driveTransportation
    ## 1 70-74 years                 1                  1                  NA
    ## 2                             1                 NA                  NA
    ##   cycleTransportation taxiTransportation communityRideTransportation
    ## 1                  NA                 NA                          NA
    ## 2                  NA                 NA                          NA
    ##   wheelTransTransportation friendsTransportation
    ## 1                       NA                    NA
    ## 2                        1                    NA
