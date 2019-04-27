Install and Load Packages
-------------------------

Round 1: Simple and Fun Set Intersection
----------------------------------------

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

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
