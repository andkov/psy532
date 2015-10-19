# Exam I

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->


















We load the data from a private, secure location and de-identify it


Compute the total score for the exam

```r
# head(ds) 
ds$total <- rowSums(ds) # compute the total
# head(ds)
```

## Basic stats
Get basic statistical summary for each item

```
        FvNP_statements FvNP_concepts NHST_statements define_model tension_riddle define_parsimony mill_canons
Min.               5.00         0.000           5.000         0.00          3.000             0.00       0.000
1st Qu.            6.75         4.000           5.000         2.75          4.375             1.00       3.500
Median             8.00         5.000           5.000         4.00          5.750             1.50       4.000
Mean               7.25         4.167           5.083         3.25          5.083             1.75       3.833
3rd Qu.            8.00         5.000           5.000         4.00          6.000             3.00       5.000
Max.               8.00         5.000           6.000         4.00          6.000             3.00       5.000
        validity_questions validity_answers ch2_slide4 find_complex bonus_models sse_formula glm_anatomy total
Min.                  0.00            0.000     0.0000       0.0000        0.000       0.000        3.50 35.00
1st Qu.               1.00            4.000     0.0000       1.0000        0.750       1.500        4.75 40.25
Median                1.00            4.000     1.0000       1.0000        1.000       2.000        5.50 45.75
Mean                  1.25            3.667     0.9167       0.9167        1.167       1.917        5.25 45.50
3rd Qu.               2.00            4.000     2.0000       1.0000        2.000       3.000        6.00 50.38
Max.                  2.00            4.000     2.0000       1.0000        2.000       3.000        6.00 55.00
```




# grades 


