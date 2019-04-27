/*  Activating the library created in first section*/
libname libref '/home/ektasg0';




/*SYNTAX ERRORS  */
/*misspelled SAS keyword */
date temp;
   x='ekta';
run;

proc print data=temp;
run;

/*missing a semicolon */
data temp
/*data temp  */
   x='ekta';
run;

proc print data=temp;
run;

/*unmatched quotation marks */
data temp;
x="Here's a sentence";
/* Comment above line and uncomment below line to see the error */
/*x='Here's a sentence';  */
run;

proc print data=temp;
run;

/*Invalid Data set Option*/
data libref.attrition (rop=retain_indicator);
run;

/*Invalid Statement Option - variable names must begin with a letter or an undescore.*/
data temp;
input *emp_id name $ salary;
datalines;
1 jack 25000
2 kim 29000
3 sam 43000
;
run;




/*LOGIC ERRORS */
/* PUTLOG or PUT - to write custom messages*/
data temp;
set  libref.electric; 
if balance < 12000 then do; 

      putlog 'MY_WARNING: The balance is too low: '
              custID 'balance= ' balance '.';
      putlog 'MY_WARNING: customer deleted from temp dataset.';
      putlog ' ';
      delete;
end; 

run;

/*To write the current contents of the dataset or values of all variables */
data temp;
set  libref.electric; 
putlog _ALL_;
run;

/* _N_ and _ERROR_ */
data temp;
set libref.electric;
If sales>1200 then bonus=sales*0.5;
else put 'DATA ERROR : ' sales = _n_ = ;
run;






/*DATA ERROR - Invalid Data*/
DATA emp;
input emp_id name $ salary;
datalines;
1 jack 250o0
2 kim 29000
3 sam 43000
4 rick 56o756
5 Tom 456789
;
run;
proc print data=emp;
run;



