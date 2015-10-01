dsDemo <- readRDS("./data/demo.rds")
str(dsDemo)


names.labels <- function(domain, file, wave){
    ds <- dsDemo
    nl <- data.frame(matrix(NA, nrow=ncol(ds), ncol=2))
    names(nl) <- c("name","label")
      for (i in seq_along(names(ds))){
        nl[i,"name"] <- attr(ds[i], "names")
          if(is.null(attr(ds[[i]], "label")) ){
          nl[i,"label"] <- NA}else{
          nl[i,"label"] <- attr(ds[[i]], "label")  
          }
      }
    return(nl)
}

names.labels(dsDemo)



ds0 <- readRDS("./data/derived/ds0.rds")
str(ds0[1:2])

attr(ds$id,"label") <- "Person identifier"

attr(ds$study,"label") <- "The particular sub-study within RADC"
ds %>% dplyr::count(study)