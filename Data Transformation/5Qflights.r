Ask 5 questions about flights in 2013

### Q1. In the first quarter, which were the top 5 airlines with the longest flight delays and **Departure before schedule**?

```r
top5_long_delay <- flights %>%
  filter(month %in% c(1,2,3), year == 2013) %>%
  select(month, carrier, dep_delay, arr_delay, origin, dest) %>%
  arrange(desc(dep_delay)) %>%
  head(5) %>%
  left_join(airlines)
----------------------------------------------------------------------------
Output:
  month carrier dep_delay arr_delay origin dest  name                  
  <int> <chr>       <dbl>     <dbl> <chr>  <chr> <chr>                 
1     1 HA           1301      1272 JFK    HNL   Hawaiian Airlines Inc.
2     1 MQ           1126      1109 EWR    ORD   Envoy Air             
3     3 DL            911       915 LGA    MSP   Delta Air Lines Inc.  
4     1 MQ            853       851 JFK    BWI   Envoy Air             
5     2 F9            853       834 LGA    DEN   Frontier Airlines Inc.
```

### Q2. Top 5 most popular pairs of origin and destination stations in 2013

```r
Pop_ori_dest <- flights %>%
  select(origin, dest, distance) %>%
  group_by(origin, dest) %>%
  summarise(mean_distance = mean(distance),
            times = n()) %>%
  arrange(desc(times)) %>%
  head(5)
---------------------------------------------------------------------------
Output:
 origin dest   mean_distance   times
  <chr>  <chr>         <dbl>   <int>
1 JFK    LAX            2475   11262
2 LGA    ATL             762   10263
3 LGA    ORD             733    8857
4 JFK    SFO            2586    8204
5 LGA    CLT             544    6168
```

### Q3. Top 5 popular airlines and not the most popular in 2013

- **Q3.1**  **Top 5 unpopular airlines**
    
    ```r
    Unpop_al <- flights %>%
      select(Airlines = "carrier") %>%
      count(Airlines) %>%
      arrange(n) %>%
      head(5) %>%
      left_join(airlines, by = c("Airlines" = "carrier"))
    -------------------------------------
    Airlines     n   name                  
      <chr>    <int> <chr>                 
    1 OO          32 SkyWest Airlines Inc. 
    2 HA         342 Hawaiian Airlines Inc.
    3 YV         601 Mesa Airlines Inc.    
    4 F9         685 Frontier Airlines Inc.
    5 AS         714 Alaska Airlines Inc.
    ```
    
- **Q3.2 Top 5 popular airlines**
    
    ```r
    
    Pop_al <- flights %>%
      select(Airlines = "carrier") %>%
      count(Airlines) %>%
      arrange(desc(n)) %>%
      head(5) %>%
      left_join(airlines, by = c("Airlines" = "carrier"))
    --------------------------------------
    Airlines     n name                    
      <chr>    <int> <chr>                   
    1 UA       58665 United Air Lines Inc.   
    2 B6       54635 JetBlue Airways         
    3 EV       54173 ExpressJet Airlines Inc.
    4 DL       48110 Delta Air Lines Inc.    
    5 AA       32729 American Airlines Inc.
    ```
    

### Q4. Top 10 Airtime of origin and destination stations

```r
AT_oridest <- flights %>%
  filter(air_time != "") %>%
  select(carrier, origin, dest, air_time) %>%
  group_by(origin, dest) %>%
  summarise(mean_airtimes = mean(air_time),
            times = n()) %>%
  arrange(desc(mean_airtimes)) %>%
  head(10)
-------------------------------------------------
origin    dest  mean_airtimes times
   <chr>  <chr>         <dbl> <int>
 1 JFK    HNL            623.   342
 2 EWR    HNL            612.   359
 3 EWR    ANC            413.     8
 4 JFK    SFO            347.  8109
 5 JFK    SJC            347.   328
 6 JFK    OAK            345.   309
 7 EWR    SFO            343.  5064
 8 JFK    SMF            336.   282
 9 JFK    BUR            334.   370
10 JFK    PSP            333.    18

```

### Q5. Statistics from 2013 on flights that departed ahead of schedule

```r
stat_fl_2013 <- flights %>%
  select(Airlines = "carrier", origin, dest, dep_delay ) %>%
  filter(dep_delay < 0) %>%
  group_by(Airlines, origin, dest) %>%
  summarise(Avg_depdelay = mean(dep_delay),
            max_depdelay = max(dep_delay),
            med_depdelay = median(dep_delay),
            min_depdelay = min(dep_delay),
            times = n(),
            var_depdelay = var(dep_delay),
            sd_depdelay = sd(dep_delay)) %>%
  arrange(desc(times)) 
------------------------------------------------------------------
Airlines  origin   dest  Avg_depdelay max_depdelay med_depdelay min_depdelay times var_depdelay sd_depdelay
   <chr>    <chr>  <chr>        <dbl>        <dbl>        <dbl>        <dbl> <int>        <dbl>       <dbl>
 1 AA       LGA    ORD          -5.75           -1           -6          -18  3715         8.25        2.87
 2 DL       LGA    ATL          -4.18           -1           -4          -16  3608         4.86        2.20
 3 US       LGA    BOS          -6.87           -1           -7          -18  3362         5.66        2.38
 4 AA       LGA    DFW          -5.39           -1           -5          -16  3242         7.53        2.74
 5 US       LGA    DCA          -6.10           -1           -6          -17  3221         6.44        2.54
 6 AA       LGA    MIA          -5.21           -1           -5          -15  2534         7.59        2.75
 7 US       LGA    CLT          -5.17           -1           -5          -15  2414         6.56        2.56
 8 US       EWR    CLT          -5.40           -1           -5          -19  2410         6.65        2.58
 9 DL       LGA    DTW          -4.76           -1           -5          -21  2086         6.57        2.56
10 MQ       LGA    RDU          -6.55           -1           -6          -21  2035        10.3         3.21
# ℹ 412 more rows
```

