/*  Creating your own library */
libname libref '/home/ektasg0';





/* creating the data set in work lib which is temporary lib */ It will disappear if we log off from SAS and come back.

Data Electronic1 ;
input product_name$ salesman_name$ price;
datalines;
LED MOHAN 500
LCD KEVIN 400
MOBILE SUMIT 300
IRON ARUN 125
;

PROC PRINT DATA = Electronic1;
title electronic dataset of ABC online store;
run;





/* creating the data set in your own permanent lib */
Data libref.Electronic1 ;
input product_name$ salesman_name$ price;
datalines;
LED MOHAN 500
LCD KEVIN 400
MOBILE SUMIT 300
IRON ARUN 125
;

/*Prints a listing of the values*/
PROC PRINT DATA = libref.Electronic1;
title electronic dataset of ABC online store;
run;

/*Describes the structure of the data set rather than the data values*/
PROC CONTENTS DATA=libref.Electronic1; RUN;


/* Stream a CSV representation of SASHELP.CARS directly to the user's browser. */

proc export data=sashelp.cars
            outfile=_dataout
            dbms=csv replace;
run;

%let _DATAOUT_MIME_TYPE=text/csv;
%let _DATAOUT_NAME=cars.csv;