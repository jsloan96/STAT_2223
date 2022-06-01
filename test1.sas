/* TEST 1 */
ODS PDF FILE = 'C:\Users\Jeremy\Desktop\test1Resultspdf' STYLE= statistical;
* Import Data;
data pulse;
infile 'C:\Users\Jeremy\Desktop\pulse.txt';
 input ID Pulse1 Pulse2 Ran Smokes Sex Height Weight Activity;
 run;
* 1a.) Find the sample mean and sample standard deviation for pulse2, weight and height.;
proc means data=pulse mean std MAXDEC=3; 
var Pulse2;
var Weight;
var Height;
Title "1a.) Find the sample mean and sample standard deviation for pulse2, Weight and Height.";
run;
/* 1b.) Make a scatter plot between weight and pulse1, grouped by ran. What pattern do you observe
	    between weight and pulse1? */
proc sgplot data=pulse;
  scatter x=Weight y=Pulse1 / group=Height;
  Title "1.b) Weight Vs. Pulse1 Grouped By Height";
run;
* The scatter plot appears to be centered around 140 lbs and a pulse1 of 70 bpm. ;

/* NUMBER 2 */

* 2a.) Calculate the mean and standard deviation of all Midterm and Homework scores. ;
data grades;
input  name$ homework midterm final;
datalines;
Frank 97 95 92
Emily 93 92 96
William 95 90 88
Janet 88 83 75
Betty 86 79 84
Joe 85 82 86
Bob 72 63 72
;
Title "Number 2: Grades";
proc print;
run;
proc means data=grades mean std MAXDEC=3; 
var homework;
var midterm;
Title "2a.) Calculate the mean and standard deviation of all Midterm and Homework scores.";
run;

* 2b.) Construct a 99% confidence interval for the mean midterm score.;
proc means n mean alpha=0.01 clm ;
var midterm; * numeric variable for calculating statistics ;
Title "2b.) Construct a 99% confidence interval for the mean midterm score.";
run ;

* 2c.) Given a = .1, determine whether the mean of Final is less than 88. Set up appropriate
	   hypotheses, calculate your test statistic and report your P-value.;

* Test that the mean of final < 88;
* Ho: M >= 88, Ha: M < 88;
PROC TTEST data=grades H0=88 SIDES=L plots=none; /* Left (Lower)  tailed test */
VAR final;
Title "2c.) Given alpha = .1, determine whether the mean of Final is less than 88. Set up appropriate
	   hypotheses, calculate your test statistic and report your P-value.";
/* Test Statistic = 5.5771
 * P-value = 0.1770 > alphs=0.1 
 * Decision: Fail to Reject Ho
 * Interpretation: There is enough evidence to support the claim that the mean Final grade is less than 88. */
Run;

/* NUMBER 3*/
proc import out=sleep
    datafile="C:\Users\Jeremy\Desktop\sleep.csv"
    dbms=csv
    replace;
    getnames=YES;
	title "Number 3: Sleep";
run;
proc print;
run;

* 3a.) What is a 80% confidence interval for the population average sleeping time, based on the sample?;
proc means data=sleep mean std MAXDEC=3; 
var sleep;
Title "3a.) Calculate the mean and standard deviation of all sleep times.";
run;
proc means n mean alpha=0.2 clm ;
*var sleep; * numeric variable for calculating statistics ;
Title "3b.) Construct a 80% confidence interval for the mean sleep time.";
run ;

* 3b.) State your null and alternative hypotheses.
		* Ho: Mu <= 7
		* Ha: Mu > 7

* 3c.) What is the p-value?;
PROC TTEST data=sleep H0=7 SIDES=U plots=none; /* Right (upper)  tailed test */
VAR sleep;
Title "3c.) ";
/* Test Statistic = 5.5771
 * P-value = 0.9742 */
Run;

* 3d.) What is the decision(the hypothesis is true or not) and interpretation?
* Decision: Fail to Reject Ho
* Interpretation: There is enough evidence to support the claim;


ODS PDF CLOSE;
