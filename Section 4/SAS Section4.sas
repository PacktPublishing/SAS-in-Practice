/*  Activating the library created in first section*/
libname libref '/home/ektasg0';

/* CHARACTER FUNCTIONS */
/*Scan (str,n,dlm) is used to extract nth part of the string  */
data temp;
str = "Mr. Rob/K*Thomas";
/* Extracting Title First Name and Surname */
title = SCAN(str, 1);
first_name = SCAN(str,2);
surname = SCAN(str,-1);
invalid_second_arg_1 = SCAN(str,100);
invalid_second_arg_2 = SCAN(str,0);
run;

proc print data = temp;
run;


/* SUBSTR(charvar,start,length) is used for extracting a part of string */
data temp;
sample_str = "Pin Code 411014";
all_str = SUBSTR(sample_str,1);
mid_str = SUBSTR(sample_str,5,4);
wrong_lngth = SUBSTR(sample_str,5,100);
wrong_strt = SUBSTR(sample_str,100,2);
run;

 
proc print data = temp;
run;

/*SUBSTR( ) Used on Left Side on Assignment Statement.  */
data new;
sample_str = "Pin Code 411014";
SUBSTR(sample_str, 4, 5) = ":";
run;
 
proc print data = new;
run;

/*TRIM(str) Removes only trailing blanks from the string  */
data temp;
sample_str1 = "Hello World ";
sample_str2="Ekta ";
total_str_notrim= sample_str1 || sample_str2;
trim_str = TRIM(sample_str1) || sample_str2;
run;
proc print data = temp;
run;

/* UPCASE(char_string)Changes all the characters in given char_string to upper case */
data temp;
str='John B. Smith';
name=upcase(str);
run;
proc print data=temp;
run;

/* LOWCASE(char_string)Changes all the characters in given char_string to lower case */
data temp;
str="JOHN B SMITH";
name=lowcase(str);
run;
proc print data=temp;
run;

/* MATHEMATICAL FUNCTIONS*/
/* ROUND FUNCTION */
data temp;
input x;
x=ROUND(x);
datalines;
1.43
2.65
3.34
6.78
8.50
;
run;
proc print data=temp;
title "round to nearest integer";
run;

/*Round to first decimal  */
data temp;
input x;
x=ROUND(x,0.1);
datalines;
1.43
2.65
3.34
6.78
8.50
;
run;
proc print data=temp;
title "round to first decimal";
run;

/*Round to even number  */
data temp;
input x;
x=ROUND(x,2);
datalines;
1.43
2.65
3.34
6.78
8.50
;
run;
proc print data=temp;
title "round to even number";
run;

/* INT FUNCTION */
data temp;
input Age Weight;
Age= int(Age);
wtkg = round(2.2*Weight, 0.1);
Weight=round(Weight);
datalines;
23.4 100.6
18.6 59.4
56.5 75.4
;
run;
proc print data=temp;
run;


/*DATE AND TIME FUNCTIONS  */
/*MDY -Returns a SAS date value from month, day, and year values.*/
Data temp;
birthday=mdy(8,27,90);
put birthday; 
format birthday worddate.;
birthday1=mdy(8,27,90);
format birthday1 date9.;
run;

/*TODAY - Returns the current date as a numeric SAS date value.*/
Data temp;
today_ = Today(); 
format today_ worddate.;
format today_ date9.;
run;

/* DATE - Returns the current date as a SAS date value */
Data temp;
date_ = DATE(); 
format date_ worddate.;
format date_ date9.;
run;

/* TIME - Returns the current time of day as a numeric SAS time value.*/
Data temp;
time_ = TIME(); 
format time_ time9.;
run;










/*DAY Function -  Returns the day of the month from a SAS date value.*/
Data temp;
date='25jan94'd;
d=day(date);
run;

/*MONTH Function - Returns the month from a SAS date value. */
Data temp;
date='25oct94'd;
m=month(date);
run;

/*YEAR Function - Returns the year from a SAS date value*/
Data temp;
date='25jan16'd;
y=year(date);
run;

/* QTR Function - Returns the quarter of the year from a SAS date value. */
Data temp;
date='25oct94'd;
q=QTR(date);
run;




/*INTCK FUNCTION  - Get the interval between the dates in specified interval. 
For the CONTINUOUS method, the distance in months between January 15,2000 
and February 15, 2000 is one month.
Alias	C or CONT
*/
data b;
   WeddingDay='14feb2000'd;
   Today=today();
   YearsMarried=INTCK('YEAR',WeddingDay,today(),'C');
   format WeddingDay Today date9.;
run;
proc print data=b;
run;

data date_functions;
INPUT @1 date1 date9. @11 date2 date9.;
format date1 date9.  date2 date9.;
Years_ = INTCK('YEAR',date1,date2);
DATALINES;
21OCT2000 16AUG1998
01MAR2009 11JUL2012
;
proc print data = date_functions noobs;
run;

/* INTNX FUNCTION - below example shows how to determine the date of the start of 
the week that is six weeks from the week of October 17, 2003.*/
Data temp;
x=intnx('week', '17oct03'd, 6);
format x date9.;
proc print data=temp;
run;

/*DATDIF FUNCTION - DATDIF returns the actual number of days between two dates, 
as well as the number of days based on a 30-day month and a 360-day year. */
data _null;
   sdate='16oct78'd;
   format sdate date9.;
   edate='16feb96'd;
   format edate date9.;
   actual=datdif(sdate, edate, 'act/act');
   days360 =datdif(sdate, edate, '30/360');
run;

/* YRDIF FUNCTION -YRDIF returns the difference in years between two dates based on 
each of the options for basis. */
data _null;
   sdate='16oct1998'd;
   format sdate date9.;
   edate='16feb2010'd;
   format edate date9.;
   y30360=yrdif(sdate, edate, '30/360');
   yactact=yrdif(sdate, edate, 'ACT/ACT');
   yact360=yrdif(sdate, edate, 'ACT/360');
   yact365=yrdif(sdate, edate, 'ACT/365');
run;

/*calculate a person’s age by using three arguments in the YRDIF function. 
The third argument, basis, must have a value of AGE:  */
data _null;
   sdate='16oct1998'd;
   format sdate date9.;
   edate='16feb2010'd;
   format edate date9.;
   age=yrdif(sdate, edate, 'AGE');
run;