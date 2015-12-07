Grading comments

## Ryan Wong
- readme works
- in Readme, I would add a few words description of each report, so that the reader doesn't have to follow the links to get the idea what that report is about. 

### `/.data_prep/hrs_final/hrs_final.R`
- not sure what line 58 of ` does. be careful here. I see no visible change to data, but it has the potential to radically transform the object  
-  chunk DataForModel, line 71. Avoid using `dplyr` verbs referring to the package implicitly. Always make the package explicit: `dplyr::select` instead of `select`. It is especially relevant in working with dplyr and plyr, because they have different function with the same name.
- line 75. If you are removing the cases with missing values, show me what effect that procedure had. How many were removed? THis is a very important information for any analysis  
- great graph on lines 109-116 to show individual variation over time. crisp. simple.  

 
### Report Notes
- great job, i liked the story  
- wished there was one more graph: "Fit Indices for All Models" but zoomed on only M0-M4. M00 distorts the y-scale and I can't see well how the model performance changes as we get into more interesting developments of the model.
- great job on working through a mixed models methodology. This example will set you up for a nice reference material. 


### Presentation Notes
- I like the minimalist style.   
- crisp bullets. Minimum text. 
- consider wide-screen option for the slide frame
- don't forget spaces when you use dashes to create bullets 

### Performance
- you made 5 points for the visit card
- you made 60 / 60 points for homework and paper models
- you made 46 / 50  points on exam 1
- you made 87 / 100 points on exam 2
- you made 90 /90 points on report and presentation
- your total points : 288
- your percentage grade: .96
- your RECORDED letter grade: A+




