/*  Activating the library created in first section*/
libname libref '/home/ektasg0';

proc print Data=libref.electric;
run;

proc print Data=libref.fashion;
run;

/*SET statement to concatenate two datasets having same variables*/
Data libref.concatenateset;
set libref.electric libref.fashion;
run;

/*SET statement to concatenate datasets in which one is having more variable than other*/
Data admindept;
Input empid name $ salary DOJ date9.;
DATALINES; 
1 Rick 623.3 02APR2001
3 Mike 611.5 21OCT2000
6 Tusar 578.6 01MAR2009  
; 
RUN; 

Data financedept;
Input empid name $ salary ;
DATALINES; 
2 Andy 567.2 
4 Rusell 683.2 
7 John 594.5   
; 
RUN;

Data combineset;
SET admindept financedept;
run;





/* PROC APPEND PROCEDURE */
PROC APPEND BASE=admindept DATA=financedept FORCE;
run;

proc print data=admindept;
run;

/*PROC APPEND if we reverse the base and data to be appended */
proc append base=financedept data=admindept force;
run;
proc print data=financedept;
run;



/*INTERLEAVING  by sorting of data first*/
proc sort data = libref.fashion;
by custID;
run;

proc sort data = libref.electric;
by custID;
run;

data interleavedata;
set libref.fashion libref.electric;
by custID;
run;


/*  One-to-One Reading*/
Data Customer;
INPUT orderid sales product$;
Datalines;
1 5000 Camera
2 6000 TV
3 4000 Fridge
4 8000 Laptop
5 7000 Desktop
;
RUN;

Data Sales;
Input orderid customername$ pincode;
Datalines;
1 Mike 560035
2 Rusell 560045
3 Adam 560078
4 Gary 560075
5 Steve 560076
6 Craig 560035
;
RUN; 

Data onetoonereadset;
SET customer;
SET SALES;
RUN;

/*Now lets change the value of orderid variables for one dataset.In this case the value of 
orderid will be overridden with that of the second or last dataset.*/

Data Sales;
Input orderid customername$ pincode;
Datalines;
1 Mike 560035
2 Rusell 560045
3 Adam 560078
6 Gary 560075
7 Steve 560076
8 Craig 560035
;
RUN; 

Data onetoonereadset;
SET customer;
SET SALES;
RUN;


/*  One-to-One Merging*/
Data onetoonemergeset;
merge  sales customer;
run;

/*  One-to-One Merging reverse the dataset */
Data onetoonemergeset;
merge  customer sales;
run;