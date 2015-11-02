options(stringsAsFactors = F)
library(reshape2)
library(ggplot2)
library(plyr)
library(stringr)
library(MASS)
source("./data/xtable.r")

if (!file.exists("deaths.rds")) {
  src <- "https://github.com/hadley/mexico-mortality/raw/master/deaths/deaths08.csv.bz2"
  download.file(src, "deaths.csv.bz2", quiet = TRUE)
  
  deaths <- read.csv("deaths.csv.bz2")
  unlink("deaths.csv.bz2")
  deaths$hod[deaths$hod == 99] <- NA
  deaths$hod[deaths$hod == 24] <- 0
  deaths$hod[deaths$hod == 0] <- NA
  deaths$hod <- as.integer(deaths$hod)  
  deaths <- arrange(deaths, yod, mod, dod, hod, cod)
  deaths <- deaths[c("yod", "mod", "dod", "hod", "cod")]
  
  saveRDS(deaths, "deaths-andkov.rds")
}

deaths <- readRDS("deaths-andkov.rds")

ok <- subset(deaths, yod == 2008 & mod != 0 & dod != 0)
xtable(ok[c(1, 1:14 * 2000), c("yod", "mod", "dod", "hod", "cod")], 
  "raw.tex")

codes <- read.csv("./case-study/icd-main.csv")
codes$disease <- sapply(codes$disease, function(x)
  str_c(strwrap(x, width = 30), collapse = "\n"))
names(codes)[1] <- "cod"
codes <- codes[!duplicated(codes$cod), ]

# Display overall hourly deaths
hod_all <- subset(count(deaths, "hod"), !is.na(hod))
qplot(hod, freq, data = hod_all, geom = "line") + 
  scale_y_continuous("Number of deaths", labels = function(x) format(x, big.mark = ",")) + 
  xlab("Hour of day")
ggsave("overall.pdf", width = 10, height = 6)

# Count deaths per hour, per disease
hod2 <- plyr::count(deaths, c("cod", "hod"))
hod2 <- base::subset(hod2, !is.na(hod))
hod2 <- plyr::join(hod2, codes)
hod2 <- plyr::ddply(hod2, "cod", transform, prop = freq / sum(freq))
str(hod2)

# hod2 <- dplyr::count_(deaths, c("cod", "hod")) #%>% dplyr::rename(freq=n) 
# hod2 <- dplyr::filter(hod2, !is.na(hod))
# hod2 <- dplyr::left_join(hod2, codes, by="cod")
# http://stackoverflow.com/questions/24133356/how-to-replicate-ddply-behavior-with-dplyr
# str(hod2)
  
# Compare to overall abundance
overall <- plyr::ddply(hod2, "hod", summarise, freq_all = sum(freq))
overall <- plyr::mutate(overall, prop_all = freq_all / sum(freq_all))

hod2 <- plyr::join(overall, hod2, by = "hod")

# Pick better subset of rows to show
cods <- plyr::join(arrange(count(deaths, "cod"), desc(freq)), codes)
plyr::mutate(tail(subset(cods, freq > 100), 30), disease = str_sub(disease, 1, 30))

hod3 <- base::subset(hod2, cod %in% c("I21", "N18", "E84", "B16") & hod >= 8 & hod <= 12)[1:15, c("hod", "cod", "disease", "freq", "prop", "freq_all", "prop_all")]

xtable(hod3[c("hod", "cod", "freq")], "counts.tex")
xtable(hod3[c("disease")], "counts-disease.tex")
xtable(hod3[5], "counts-prop.tex")
xtable(hod3[6:7], "counts-all.tex")

head(hod3)
knitr::kable(hod3[c("hod", "cod", "freq")])
knitr::kable(hod3[c("hod", "cod", "freq")], format="html")
knitr::kable(hod3[c("hod", "cod", "freq")], format="latex")
knitr::kable(hod3[c("hod", "cod", "freq")], format="markdown", padding=2)

devi <- plyr::ddply(hod2, "cod", summarise, n = sum(freq), 
  dist = mean((prop - prop_all)^2))
devi <- subset(devi, n > 50)

# Find outliers
xlog10 <- scale_x_log10(
  breaks = c(100, 1000, 10000), 
  labels = c(100, 1000, 10000), 
  minor_breaks = log10(outer(1:9, 10^(1:5), "*")))
ylog10 <- scale_y_log10(
  breaks = 10 ^ -c(3, 4, 5), 
  labels = c("0.001", "0.0001", "0.00001"),
  minor_breaks = log10(outer(1:9, 10^-(3:6), "*")))

qplot(n, dist, data = devi)
ggsave("n-dist-raw.pdf", width = 6, height = 6)
qplot(n, dist, data = devi) + 
  geom_smooth(method = "rlm", se = F) + 
  xlog10 + 
  ylog10
ggsave("n-dist-log.pdf", width = 6, height = 6)

devi$resid <- resid(rlm(log(dist) ~ log(n), data = devi))
coef(rlm(log(dist) ~ log(n), data = devi))
ggplot(devi, aes(n, resid)) + 
  geom_hline(yintercept = 1.5, colour = "grey50") +
  geom_point() + 
  xlog10
ggsave("n-dist-resid.pdf", width = 6, height = 6)

unusual <- base::subset(devi, resid > 1.5)
hod_unusual_big <- plyr::match_df(hod2, subset(unusual, n > 350))
hod_unusual_sml <- plyr::match_df(hod2, subset(unusual, n <= 350))

# Visualise unusual causes of death
ggplot(hod_unusual_big, aes(hod, prop)) + 
  geom_line(aes(y = prop_all), data = overall, colour = "grey50") +
  geom_line() + 
  facet_wrap(~ disease, ncol = 3)
ggsave("unusual-big.pdf", width = 8, height = 6)
last_plot() %+% hod_unusual_sml
ggsave("unusual-sml.pdf", width = 8, height = 4)
