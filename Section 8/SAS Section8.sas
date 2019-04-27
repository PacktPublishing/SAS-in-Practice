/*  Activating the library created in first section*/
libname libref '/home/ektasg0';

/* creating the SQL query */
PROC SQL;
select gender, sales from libref.electric;
quit;

/*Apply condition using where and group by */
proc sql;
select gender, sum(sales) as salesnumber from libref.electric
where sales>1400 group by gender;
run;

/*having condition  */
proc sql;
title 'oldest cust of each gender';
select * from libref.electric group by gender
having sales = max(sales);
run;

/*sorting based on ascending  */
proc sql;
select gender, sales from libref.electric
where sales>1500 order by sales;
quit;

/*sorting based on descending  */
proc sql;
select gender, sales from libref.electric
where sales>1500 order by sales desc;
quit;

/*  creating a new table */
proc sql;
create table libref.newtable as 
select gender, sales , (sales*0.5) as bonus from libref.electric
where sales>1500 order by sales desc;
quit;











/*SAS MACROS  */
/* to create automatic sas macro var */
proc print data= libref.electric;
where gender =1;
title "status of sales order as &sysday &sysdate &systime";
run;

/* to get all automatic system generated variables */
%put _automatic_;

/*  displays all user defined macro var*/
%put _user_;

/*TO CREATE USER DEFINED MACRO VARIABLE :enables you to create a value once and replace that value 
repeatedly within a program   */
%let gender_type=2;
proc print data=libref.electric;
where gender=&gender_type;
title "status of sales order as &sysday &sysdate &systime";
quit;






/* macro statement: how to use macro statement: test is macro name and demo is parameter .*/
%macro test (demo=);
proc print data=libref.electric;
where balance> &demo;
run;
%mend;
%test (demo=10000);




/*Using Macro functions like UPCASE and SCAN with PROC MEAN  */
%let DSN=libref.electric;
%let var=sales balance;

proc means data = &DSN;
title "%UPCASE (%SCAN(&var,1)) and %UPCASE (%SCAN(&var,2))
 for %UPCASE (&DSN) channel";
var &var;
class gender;
run;






