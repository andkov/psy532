
Data Preparation is Imporatant: An Example Using SATSA
========================================================
author: Jamie Knight
date: University of Victoria

Introduction
========================================================

Hello!

Things we will cover today:
- Why is data preparation imporatant
- An example
- Introduction to SATSA data set


Why is data preparation imporatant?
========================================================

- You will spend the majority of your time prepping your data set
  - Do this well to get good, reproducible results
  - Any errors are likely going to affect your analysis
- Some of you will use other people's data: Don't assume it is clean!
  - Even well used and documented data may have problems


An Example
========================================================

Let's examine an example of why data preparation is imporatant using the SATSA data.

SATSA is freely available on the internet.
It is well used and there are over 30,000 publications using this data set!
You can access it by signing up on their website here: http://www.icpsr.umich.edu/icpsrweb/DSDR/studies/3843


Introduction to SATSA
========================================================

The data set is comprised of twins raised together and apart and includes data on:
- Health Status
- Work Environment
- Personality

Data for this Project
========================================================
A subsample of the participants were interviewed in seven waves of in-person testing and those measurements included smell and taste questions along with cognitive and functional capacity.

This subsample is what we will use in our analysis and includes:
- Questionnaire 3 and In-Person Testing Time 3 (1990); 
- In-Person Testing Time 5 (2004); 
- Questionnaire 6 and In-Person Testing Time 6 (2007); 
- In-Person Testing Time 7 (2010)


Data Preparation
========================================================

Each wave of SATSA is in a separate data set and combining several waves of data requires a substantial amount of work.

In the folder called reports we have a script dedicated to how we merged 4 waves of in person data colected from questionnaires with the administrative and cognitive data sets.


Here comes the problem
========================================================

At the point where I merge the data you can start to see where the error is

- show photo of frequncy tables




```
Error in eval(expr, envir, enclos) : object 'C_warning' not found
```
