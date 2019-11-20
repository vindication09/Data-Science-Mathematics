---1) Calculate what % of Global Sales  were made in North America (NOT PER TITLE)

---IFNULL(variable, convert null to "what") use this to convert null into some other non-null value 

select 
round(na_sales/(na_sales+eu_sales+jp_sales+other_sales),2)*100 as na_sales_percent
from 
(
	select 
	sum(IFNULL(NA_Sales, 0)) as na_sales,
	sum(IFNULL(EU_Sales, 0)) as eu_sales,
	sum(IFNULL(JP_Sales, 0)) as jp_sales,
	sum(IFNULL(Other_Sales, 0)) as other_sales
	from `media-data-science.tutorial_data.console_games`
)


---2) produce a table of console game titles ordered by platform name in asc order and year of release desc order 
select 
Name , Year, Platform 
from `media-data-science.tutorial_data.console_games`
group by 1, 2, 3
order by Year desc , Platform asc 


----3) For each game title, extract the first four letters of the publishers name 
---group by not needed here because you are not performing aggregation but rather extracting fields with manipulation 
select 
Name,
#SUBSTRING(Publisher,0,4) as reduced_publisher
substr(Publisher,0,4) as reduced_publisher
from `media-data-science.tutorial_data.console_games`

-----4) Display all console platforms which were released either just before black friday or just before Christmas in a year of your choice. 
---Lets pick 2016 , before black friday which was on 11/26/16
SELECT Platform
FROM `media-data-science.tutorial_data.console_dates`
WHERE  FirstRetailAvailability < '2016-11-26'
and Discontinued > '2003-01-01'
group by Platform



----5) Order the platforms by their longevity in asc order 
---here we need to compute the difference between columns first retail date and date discontinued (I will also compute the difference in number of days)
select 
Platform, date_diff 
from 
(
	SELECT 
	Platform, DATE_DIFF(MAX(Discontinued), MIN(FirstRetailAvailability),  DAY) as date_diff
	FROM `media-data-science.tutorial_data.console_dates`
	group by Platform
)
where date_diff is not null 
order by date_diff asc 


----6) Show how to deal with the Game_Year column if the client wants to convert it to a different data type. 
---one example to convert to days 
SELECT 
Platform,
EXTRACT(MONTH FROM FirstRetailAvailability) as month,
EXTRACT(DAY FROM FirstRetailAvailability) as opening_day,
EXTRACT(YEAR FROM FirstRetailAvailability) as year
from  `media-data-science.tutorial_data.console_dates`;


----7) Provide recommendations on how to deal with missing data in the file (open ended)
