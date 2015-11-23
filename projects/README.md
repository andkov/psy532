Final Projects
--- 
Guidelines for submitting your final project

A. Your project must contain the following files:
* .Rproj file
* README.md file containing the live links and succinct descriptions of every script and report in your project.

B. The root of the repository must contain **these and only these** folders: 
* ./data
* ./scripts
* ./reports
* ./libs

C. The folder `./data` must contain :
* sub-folder `./data/raw` 
* sub-folder `./data/derived` 
* `README.md` file with live links to and descriptions of each data file 
Place the data in EXACT form you obtain it from the source into ./data/raw folder. Everything that happens to it as you prepare it must be accomplished using scripts, to make our reports reproducible. Data processing scripts must result in a data object being placed in ./data/derived for further reference throughout reports.  

D. The folder `./reports` must contain:
* a separate folder for each report  
* Each folder should contain .Rmd and .R files of the same name (optional) 
* `README.md` files with live links to and descriptions of each report    
I **suggest** at least two reports:  
* `data_preparation` with the report narrating data preparation 
* `data_analysis` with the report narrating data analysis

F. The folder `./scripts` in general must contain only .R files (possibly in individual sub-folders (e.g. `./scripts/data` , `./scripts/graphs` ).

G. The folder `./libs` should contain supporting files. Some of the suggested sub-folders:
* images  
* css  
* ppt  