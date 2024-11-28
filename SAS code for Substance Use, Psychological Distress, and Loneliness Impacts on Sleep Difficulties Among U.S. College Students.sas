*1. Import the data into SAS using a method of your choosing;

libname Capstone '/home/u59247163/sasuser.v94/HEPS'; run; 

proc import file="/home/u59247163/sasuser.v94/HEPS/Untitled6 (1).sav"
    out=Capstone.Project1
    dbms=SAV;
run;

/*label & Formats*/
data Capstone.Project2;
set Capstone.Project1;
label 
    TOBACCORISK = "ASSIST tobacco risk" /*continuous*/
    CANNABISRISK = "ASSIST cannabis risk" /*continuous*/
	COCAINERISK = "ASSIST cocaine risk"  /*continuous*/
	ALCOHOLRISK = "ASSIST alcohol risk" /*continuous*/ 
	N3Q66P = "Academic performance - Sleep difficulties" /*continuous*/ 
	RKESSLER6 = "Recoded Kessler 6 (K6) Non-Specific Psychological Distress" /*continuous*/
	RULS3 = "Recoded UCLA Loneliness Scale" /*continuous*/
	RSEX = "SEX AND GENDER" /*categorical, starting Demographics*/ 
	N3Q69 = "Age" /*continuous*/ 
	N3Q72 = "Year in school" /*categorical*/
	N3Q73 = "enrollment status" /*categorical*/
	N3Q75 = "Race" /*categorical*/
	N3Q78 = "Housing" /*categorical*/
	N3Q79 = "Health insurance status" /*categorical*/
;
RUN;

PROC FORMAT;    
    value TOBACCORISK 1 ="Low Risk (0-3)" 2 = "Moderate Risk (4-26)" 3 = "High Risk (27-39)";
	value CANNABISRISK 1 ="Low Risk (0-3)" 2 = "Moderate Risk (4-26)" 3 = "High Risk (27-39)";
	value ALCOHOLRISK 1 ="Low Risk (0-3)" 2 = "Moderate Risk (4-26)" 3 = "High Risk (27-39)";
	value N3Q66P 1 =" Did not experience this issue" 2 ="Did not affect academic performance" 3 ="Negatively impacted performance in a class" 4="Delayed progress towards degree";
	value RKESSLER6_ 1 ="No or low psychological distress (0-4)" 2 =" Moderate psychological distress (5-12)" 3="Serious psychological distress (13-24)";
	value RULS3_ 1 ="Negative for loneliness (3-5)" 2 ="Positive for loneliness (6-9)";
	value RSEX 1 ="Female" 2="Male" 3="Non-Binary" -9="Missing";
	value N3Q72_ 1="1st year undergraduate" 2="2nd year undergraduate" 3="3rd year undergraduate" 4="4th year undergraduate" 5="5th year or more undergraduate" 6="Master's (MA, MS, MFA, MBA, MPP, MPA, MPH, etc)" 7="Doctorate (PhD, EdD, MD, JD, etc)" 8="Not seeking a degree" 9="Other";
	value N3Q73_ 1="Full-time" 2="Part-time" 3="Other";
	value N3Q75_ 1="American Indian or Native Alaskan" 2="Asian or Asian American" 3="Black or African American" 4="Hispanic or Latino/a/x" 5="Middle Eastern/North African (MENA) or Arab Origin" 6="Native Hawaiian or Other Pacific Islander Native" 7="White" 8="Biracial or Multiracial" 9="My identity is not listed above";
	value N3Q78_ 1="Campus or university housing" 2="Parent/guardian/other family member’s home" 3="Off-campus or other non-university housing" 4="Temporarily staying with a relative, friend, or “couch surfing” until I find housing" 5="I don’t currently have a place to live" 6="Other";
	value N3Q79_ 1="I have a college/university Student Health Insurance Plan" 2="I am covered by my parent/guardian’s plan" 3="I am covered by my employer-based plan (or my spouse/partner’s employer-based plan)" 4="I have Medicaid, Medicare, SCHIP, or VA/Tricare coverage" 5="I bought a plan on my own" 6="I don’t have health insurance" 7="I don’t know if I have health insurance" 8="I have health insurance, but I don’t know the primary source";
RUN;	


Data Capstone.Project2; set Capstone.Project1 
(keep = TOBACCORISK CANNABISRISK ALCOHOLRISK N3Q66P RKESSLER6 RULS3 RSEX N3Q69 N3Q72 N3Q73 N3Q75 N3Q78 N3Q79 ); /*add N3Q75B later*/
run;


PROC FREQ data = Capstone.Project2;
tables TOBACCORISK CANNABISRISK ALCOHOLRISK N3Q66P RKESSLER6 RULS3 RSEX N3Q69 N3Q72 N3Q73 N3Q75 N3Q78 N3Q79 / plots =freqplot;
format 
TOBACCORISK TOBACCORISK. CANNABISRISK CANNABISRISK. ALCOHOLRISK ALCOHOLRISK. N3Q66P N3Q66P. RKESSLER6 RKESSLER6_. RULS3 RULS3_. RSEX RSEX.
N3Q72 N3Q72_. N3Q73 N3Q73_. N3Q75 N3Q75_. N3Q78 N3Q78_. N3Q79 N3Q79_.;
run;

Data Capstone.Project3; set Capstone.Project2;
IF N3Q66P= . then delete;
IF RKESSLER6= . then delete;
IF RULS3 = . then delete;
IF RSEX = . then delete;
run;

/*IF TOBACCORISK =. then delete;
IF CANNABISRISK =. then delete;
IF COCAINERISK =. then delete;
IF RXSTIMULANTRISK  =. then delete;
IF METHRISK =. then delete;
IF INHALANTRISK =. then delete;
IF SEDATIVERISK =. then delete;
IF HALLUCINOGENRISK =. then delete;
IF HEROINRISK =. then delete;
IF RXOPIOIDRISK =. then delete;
IF OTHERSSISRISK =. then delete;
IF ALCOHOLRISK =. then delete;*/

*TOBACCORISK 
	CANNABISRISK 
	COCAINERISK 
	RXSTIMULANTRISK 
	METHRISK 
	INHALANTRISK 
	SEDATIVERISK 
	HALLUCINOGENRISK 
	HEROINRISK 
	RXOPIOIDRISK 
	OTHERSSISRISK 
	ALCOHOLRISK; 

PROC TABULATE DATA = Capstone.Project3 S=[just = c cellwidth=60];
CLASS  
    TOBACCORISK 
	CANNABISRISK 
	ALCOHOLRISK 
	N3Q66P 
	RKESSLER6 
	RULS3 
	RSEX 
	N3Q69
	N3Q72 
	N3Q73 
	N3Q75
/S=[cellwidth=150 font_weight = bold] ;
CLASSLEV  
	TOBACCORISK 
	CANNABISRISK 
	ALCOHOLRISK 
	N3Q66P 
	RKESSLER6 
	RULS3 
	RSEX 
	N3Q69
	N3Q72 
	N3Q73 
	N3Q75
 /S=[just = R];
TABLE 
    TOBACCORISK = "ASSIST tobacco risk" /*continuous*/
    CANNABISRISK = "ASSIST cannabis risk" /*continuous*/
	ALCOHOLRISK = "ASSIST alcohol risk" /*continuous*/ 
	RSEX = "SEX AND GENDER" /*categorical, starting Demographics*/ 
	N3Q69 = "Age"
	N3Q72 = "Year in school" /*categorical*/
	N3Q73 = "enrollment status" /*categorical*/
	N3Q75 = "Race"
	RSEX = "SEX AND GENDER", all ='Total'*(N COLPCTN = '%') 
	N3Q66P = "Academic performance - Sleep difficulties" /*continuous*/ * (N COLPCTN = '%') 
	RKESSLER6 = "Recoded Kessler 6 (K6) Non-Specific Psychological Distress" /*continuous*/ * (N COLPCTN = '%')
	RULS3 = "Recoded UCLA Loneliness Scale" /*continuous*/ * (N COLPCTN = '%')
	/ BOX = '';
	format TOBACCORISK TOBACCORISK. CANNABISRISK CANNABISRISK. ALCOHOLRISK ALCOHOLRISK. N3Q66P N3Q66P. RKESSLER6 RKESSLER6_. RULS3 RULS3_. RSEX RSEX.
N3Q72 N3Q72_. N3Q73 N3Q73_. N3Q75 N3Q75_.;
Title 'Table 1. Sample Characteristics by Academic performance - Sleep difficulties';
Run;

ODS pdf close;

*Total N = 6943;

*Sleep Difficulties;
/* Step 5: Linear regression analysis */
proc surveyreg data=Capstone.Project3;
    strata N3Q75;
    cluster N3Q72;
    weight N3Q69 RSEX N3Q72 N3Q78 N3Q79;
    model N3Q66P = TOBACCORISK CANNABISRISK ALCOHOLRISK RSEX N3Q69 N3Q72 N3Q73 N3Q75 / solution;
    format 
        TOBACCORISK TOBACCORISK. 
        CANNABISRISK CANNABISRISK. 
        ALCOHOLRISK ALCOHOLRISK. 
        N3Q66P N3Q66P. 
        RKESSLER6 RKESSLER6_. 
        RULS3 RULS3_. 
        RSEX RSEX.
        N3Q72 N3Q72_. 
        N3Q73 N3Q73_. 
        N3Q75 N3Q75_. ;
    title "Linear Regression Analysis with Strata, Cluster, and Weights";
run;

*Psychological Distress;
proc surveyreg data=Capstone.Project3;
    strata N3Q75;
    cluster N3Q72;
    weight N3Q69 RSEX N3Q72 N3Q78 N3Q79;
    model RKESSLER6 = TOBACCORISK CANNABISRISK ALCOHOLRISK RSEX N3Q69 N3Q72 N3Q73 N3Q75 / solution;
    format 
        TOBACCORISK TOBACCORISK. 
        CANNABISRISK CANNABISRISK. 
        ALCOHOLRISK ALCOHOLRISK. 
        N3Q66P N3Q66P. 
        RKESSLER6 RKESSLER6_. 
        RULS3 RULS3_. 
        RSEX RSEX.
        N3Q72 N3Q72_. 
        N3Q73 N3Q73_. 
        N3Q75 N3Q75_. ;
    title "Linear Regression Analysis with Strata, Cluster, and Weights";
run;

*Loneliness;
proc surveyreg data=Capstone.Project3;
    strata N3Q75;
    cluster N3Q72;
    weight N3Q69 RSEX N3Q72 N3Q78 N3Q79;
    model RULS3 = TOBACCORISK CANNABISRISK ALCOHOLRISK RSEX N3Q69 N3Q72 N3Q73 N3Q75 / solution;
    format 
        TOBACCORISK TOBACCORISK. 
        CANNABISRISK CANNABISRISK. 
        ALCOHOLRISK ALCOHOLRISK. 
        N3Q66P N3Q66P. 
        RKESSLER6 RKESSLER6_. 
        RULS3 RULS3_. 
        RSEX RSEX.
        N3Q72 N3Q72_. 
        N3Q73 N3Q73_. 
        N3Q75 N3Q75_. ;
    title "Linear Regression Analysis with Strata, Cluster, and Weights";
run;

*Total N = 6943;

