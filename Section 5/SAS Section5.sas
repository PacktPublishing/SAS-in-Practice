/*  Activating the library created in first section*/
libname libref '/home/ektasg0';

/*Automatic Data Type Conversion */
data _null_;
  x= 45678923;
  length y $ 4;
  y=x;
  put y;
run;


data _null_;
	x1= 3626885;
	length y1 $ 1;
	y1=x1;
	xs=0.000005;
	length ys $ 1;
	ys=xs;
	put y1= ys=;
run;

/*PUT Function - using put function to change zipcode from numeric to character - 
if source is numeric resulting string is right aligned by default,
if the source is character resulting string is left aligned by default, 
z6. is the format to add zero to all pincode less than 6 */
data test_put;
set libref.clean_dataset;
New_zipcode = PUT(zip_code,z6.);
run;

/*INPUT Function - using input function to convert from character to numeric  */
data test_input;
set test_put;
new_sec_zip = INPUT(New_zipcode,8.0);
run;

/* IMPORTING ECOMMERCE DATASET */
FILENAME REFFILE '/home/ektasg0/Ecommerce_Dataset.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=LIBREF.ECOMMERCE;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=LIBREF.ECOMMERCE; RUN;

/*PROC MEANS */
/* using proc means : descriptive statistics, min, max, mean, std , n */
proc means data=libref.ecommerce;
run;

/* OPTIONS - to extract only no of observations, mean, std */
proc means data=libref.ecommerce N mean std;
run;

/*proc mean using additional statement
Calculates the average Sale and Profit within each Ship_Mode type.  */
proc means data=libref.ecommerce N mean std;
var sales profit;
class ship_mode;
run;

/*Compute median, mode, quartile
keyword Mean generates the average of Sales column for each shipmode type
keyword Median generates the “middle” value or median of Sales column for each shipmode type
keyword Mode generates the most repeated value or mode of Sales column for shipmode.
keyword P25 generates the first quartile value of Sales column for shipmode.
keyword P50 generates the second quartile value of Sales column for shipmode.
keyword P75 generates the third quartile value of Sales column for shipmode. */
proc means data=libref.ecommerce N Mean median mode p25 p50 p75;
var profit;
class ship_mode;
run;




/*PROC FREQ  */
proc sort data=libref.ecommerce;
by order_priority;
run;

proc freq data=libref.ecommerce;
tables order_priority;
run;

/*The NLEVELS option is used to count number of unique values in a variable. 
The OUT option is used to store result in a data file.
NOPRINT option prevents SAS to print it in results window.*/
proc freq data=libref.ecommerce nlevels noprint;
tables order_priority/ out=temp;
run;

/* Do not want cumulative frequency and cumulative percent to be displayed in the 
table. The option NOCUM and NOPERCENT tells SAS to not to return cumulative scores and percent resp*/
proc freq data=libref.ecommerce;
tables order_priority/nocum nopercent;
run;

/*In PROC FREQ, the categories of a character variable are ordered alphabetically by default. 
For numeric variables, the categories are ordered from smallest to largest value.
To sort categories on descending order by frequency (from largest to smallest count), 
add ORDER=FREQ option.
By default, PROC FREQ does not consider missing values while calculating percent and 
cumulative percent.By adding MISSING option, it includes missing value as a separate category 
and all the respective statistics are generated based on it.*/
proc freq data=libref.ecommerce order=freq;
tables order_priority/missing;
run;









/*PROC UNIVARIATE*/
proc univariate data=libref.ecommerce;
var sales;
run;

/*The CLASS statement is used to define categorical variable. */
proc univariate data=libref.ecommerce;
var sales;
class ship_mode;
run;

/* Suppose you want only percentiles to be appeared in output window. By default, 
PROC UNIVARIATE creates five output tables : Moments, BasicMeasures, TestsForLocation, 
Quantiles, and ExtremeObs. The ODS SELECT can be used to select only one of the table. 
The Quantiles is the standard table name of PROC UNIVARIATE for percentiles which we want.
ODS stands for Output Delivery System. */
ods select Quantiles;
proc univariate data=libref.ecommerce;
var sales;
run;

/*we can generate extreme values with extremeobs option. 
The ODS OUTPUT tells SAS to write the extreme values information to a dataset named outlier. 
The "extremeobs" is the standard table name of PROC UNIVARIATE for extreme values.  */
ods output extremeobs = outlier;
proc univariate data=libref.ecommerce;
var sales;
run;
ods output close;

/*Histogram shows visually whether data is normally distributed.  */
proc univariate data=libref.ecommerce;
var sales;
histogram sales/normal;
run;

/* PROC PRINT */
proc print data=libref.electric;
where sales>1200;
run;