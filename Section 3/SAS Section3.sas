/*  Activating the library created in first section*/
libname libref '/home/ektasg0';

/* Data manipulation techniques: to group and delete the obs from the data by using 
if then statement and Delete keyword */
 data delete_final;
 set libref.Electric;
 IF sales < 1500 then delete;
 run;
 
 proc print data=delete_final;
 run;
 





/* using drop statement inorder to drop the variables from the data set  */
data drop_set;
set libref.Electric;
DROP cardholder gender;
run;

proc print data=drop_set;
run;

data drop_set2 (drop=cardholder gender);
set libref.electric;
run;
proc print data=drop_set2;
run;

/* using the keep statement - to keep variables in data set */
data keep_set;
set libref.Electric;
KEEP cardholder gender;
run;

proc print data=keep_set;
run;

data keep_set2 (keep=cardholder gender);
set libref.electric;
run;
proc print data=keep_set2;
run;










/* DO END LOOP e.g:  The following program to determine the multiples of 5 up to 100:*/
Data multiply (drop=i);
multiple = 0;
Do i=1 to 20;
	multiple + 5;
	output;
end;
run;

/* DO UNTIL LOOP e.g:  The following program to determine the multiples of 5 up to 100:*/
Data multiply1 (drop=i);
multiple = 0;
Do until (multiple>=100);
	multiple + 5;
	output;
end;
run;

/* DO WHILE LOOP e.g:  The following program to determine the multiples of 5 up to 100:
In this case no output. Change >= to < to get the output*/
Data multiply1 (drop=i);
multiple = 0;
Do while (multiple<100); 
	multiple + 5;
	output;
end;
run;











/* MODIFY THE VARIABLE ATTRIBUTES */
/*  Rename the var by using rename statement */
 data rename_set (rename=(cardholder=card_owner gender=gender_type));
 set libref.electric;
 run;
 proc print data=rename_set;
 run;
 
 /*Diff between label and rename (oldname = newname) , rename chnage name permanently but 
 label retains old name and displays new name once you select the column label in output data */
data rename_set (rename=(cardholder=card_owner gender=gender_type));
 set libref.electric;
 label custID = customer_id;
 run;
 
 /* FORMAT the variables - e.g: Change the length by using format*/
 data format_set (rename=(cardholder=card_owner gender=gender_type));
 set libref.electric;
 format sales dollar10.3;
 run;

/* FORMAT the variables - e.g: Change to uppercase*/
Data admindept;
Input empid name $ salary DOJ date9.;
DATALINES; 
1 Rick 623.3 02APR2001
3 Mike 611.5 21OCT2000
6 Tusar 578.6 01MAR2009  
; 
RUN; 

 data format_set2;
 set admindept;
 format name $upcase9. ;
 run;
 
/* LENGTH statement to define the length of a variable */
data sales_test; 
   length Salesperson $20;
run; 
 
 
 
 
 
 

/* BY statement to aggregate subgroups. Below example computes annual payroll by 
department. */
data salaries;    
   input Department $ Name $ WageCategory $ WageRate;    
   datalines; 
BAD Carol Salaried 20000 
BAD Elizabeth Salaried 5000 
BAD Linda Salaried 7000 
BAD Thomas Salaried 9000 
BAD Lynne Hourly 230
DDG Jason Hourly 200 
DDG Paul Salaried 4000 
PPD Kevin Salaried 5500 
PPD Amber Hourly 150 
PPD Tina Salaried 13000 
STD Helen Hourly 200 
STD Jim Salaried 8000
; 

proc print data=salaries; 
run;

proc sort data=salaries out=temp;    
   by Department;
run;

data budget (keep=Department Payroll);   
   set temp;       
   by Department; 
   if WageCategory='Salaried' then YearlyWage=WageRate*12;    
   else if WageCategory='Hourly' then YearlyWage=WageRate*2000;  

      /* SAS sets FIRST.variable to 1 if this is a new        */
      /* department in the BY group.                          */
   if first.Department then Payroll=0;    
   Payroll+YearlyWage;

      /* SAS sets LAST.variable to 1 if this is the last      */
      /* department in the current BY group.                  */
   if last.Department; 
run;

proc print data=budget;    
   format Payroll dollar10.;
   title 'Annual Payroll by Department'; 
run;



 
 






/*SORT PROCEDURE - BY Default ascending*/
proc sort data=libref.electric OUT=sort_set;
by balance;
run;
proc print data=sort_set;
run;

/*SORT PROCEDURE - descending*/
proc sort data=libref.electric OUT=sort_set_desc;
by descending balance;
run;
proc print data=sort_set_desc;
run;

/* Sorting the original dataset and not creating any output dataset */
proc sort data=libref.electric;
by sales;
run;
