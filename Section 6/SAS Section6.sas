/*  Activating the library created in first section*/
libname libref '/home/ektasg0';

/*LIST REPORTS USING PROC PRINT */
PROC PRINT DATA=libref.salesmasterdata;
var custid balance;
run;

/*Customizing Text in Column Headings*/
PROC PRINT DATA=libref.salesmasterdata split='*' n obs='Observation*Number*===========';
var custid balance;
label custid = 'Customer ID' balance='Balance Amount';
title 'Balance Amount of the Customers';
run;

/*Creating reports for group of observations using BY Statement */
PROC SORT DATA=libref.salesmasterdata;
by gender;
run;

proc print data=libref.salesmasterdata n='Number of observations : ' 
           noobs label;
var custid balance sales;
by gender;
label gender = 'gender';
title 'Balance and Sales details of Customer Based on Gender';
run;

/*Summing Numeric Variables */
proc print data=libref.salesmasterdata noobs label sumlabel n='Number of observations : ' ;
var custid balance sales;
label gender = 'gender';
sum balance sales;
by gender;
title 'Total Balance and Sales details for #byval(gender) gender';
run;
options byline;

/*Customized Layout with BY Groups and ID Variables*/
options nodate pageno=1 linesize=64 pagesize=60;
proc sort data=libref.salesmasterdata out=tempsales;
   by gender cardholder;
run;

proc print data=tempsales split='*';
   id gender;
   by gender;
   var cardholder sales;
   sum sales;	
   label gender='GENDER*========'
         cardholder='Cardholder*======'
         sales='Sales*=============';
   title 'Sales Figures';
run;







/*SUMMARY REPORT USING PROC MEANS  */
PROC MEANS data=libref.fashion min max mean maxdec=3;
var sales;
class gender fraudrisk;
run;

/*SUMMARY FREQUENCY REPORTS - one way . It generates two one way frequency tables */
PROC FREQ DATA=libref.ecommerce;
tables ship_mode product;
run;

PROC FREQ DATA=libref.ecommerce;
tables ship_mode /nocum nopercent;
run;

/*Two Way Cross Tabulation Table 
Row Pct and Col Pct appears only in cross tabulation table*/
PROC FREQ DATA=libref.ecommerce;
tables ship_mode*order_priority;
run;

PROC FREQ DATA=libref.ecommerce;
tables ship_mode*order_priority/nopercent;
run;

/*Use list option to simplify the format in which table appears*/
PROC FREQ DATA=libref.ecommerce;
tables ship_mode*order_priority/list;
run;

/*Display list as default cross tabulation table*/
PROC FREQ DATA=libref.ecommerce;
tables ship_mode*order_priority/crosslist;
run;


/*PROC REPORT - TO CREATE THE REPORT  */
PROC REPORT DATA = LIBREF.demo;
COLUMN ORDID Product Sales Incentive;
define Product/display 'Prod_name';
define Sales /display; 
define Incentive/ computed format = dollarx10.1;
compute Incentive ;
Incentive = Sales*0.1;
endcomp;
Title 'Sales Report';
run;

/*ODS REPORTS */
/*HTML REPORT */
ODS HTML 
   PATH = '/home/ektasg0/'
   FILE = 'Sales.html'
/*    STYLE = EGDefault; */
	STYLE= STATISTICAL;
proc sql;
select gender, sum(sales) as salesnumber from libref.electric
where sales>1400 group by gender;
quit;

ODS HTML CLOSE; 
ODS PREFERENCES; /*Reset the HTML DEFAULT USING THIS STATEMENT*/

/*PDF Reports  */
ODS PDF 
     FILE = '/home/ektasg0/Sales.PDF'
/*    STYLE = EGDefault; */
	STYLE= STATISTICAL;
proc sql;
select gender, sum(sales) as salesnumber from libref.electric
where sales>1400 group by gender;
quit;

ODS PDF CLOSE; 

/*RTF Reports  */
ODS RTF 
     FILE = '/home/ektasg0/Sales.RTF'
/*    STYLE = EGDefault; */
	STYLE= STATISTICAL;
proc sql;
select gender, sum(sales) as salesnumber from libref.electric
where sales>1400 group by gender;
quit;

ODS RTF CLOSE; 

/*ODS EXCEL -  how to rotate column headings 90 degrees using the ROW_HEIGHTS=
suboption and the TAGATTR= attribute. */
ods excel file="/home/ektasg0/Sales.xlsx" options(row_heights="55px");
proc print data=libref.electric(obs=3)style(header)={tagattr="rotate:90"}
noobs;
run;
ods excel close;

/*To list all the styles*/
PROC TEMPLATE; LIST STYLES; RUN;
