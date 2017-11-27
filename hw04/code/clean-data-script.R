########
#Title: Clean Data Script
#Subtitle: script for part 5 of hw
# Stats 133 Fall 17
# Author: Robby Grewal
########

#Load required scripts and libraries
library("dplyr")
source('functions.R')

#Read in the data
dat <- read.csv('../data/rawdata/rawscores.csv')

#Sinking Structure including print stats
sink('../output/summary-rawscores.txt')
str(dat)
dat_names <- colnames(dat)

for(a in 1:16) {
  print(dat_names[a])
  print_stats(summary_stats(dat[a]))
}
sink()

#replacing all NA elements with Null or 0
for (i in 1:nrow(dat)) {
  for (j in 1:ncol(dat)) {
    if (is.na(dat[i,j])) {
      dat[i,j] <- 0
    }}}

#rescaling quizzes to scales outlined on the hw04 prompt
dat$QZ1 <- rescale100(dat$QZ1, 0, 12)
dat$QZ2 <- rescale100(dat$QZ2, 0, 18)
dat$QZ3 <- rescale100(dat$QZ3, 0, 20)
dat$QZ4 <- rescale100(dat$QZ4, 0, 20)

#Adding new Test 1 and Test 2 variables by rescaling EZ1 and EZ2
dat$Test1 <- rescale100(dat$EX1, 0, 80)
dat$Test2 <- rescale100(dat$EX2, 0, 90)

#Adding Homework Variable
dat$Homework <- NA
hws <- data.frame(hw1 = dat$HW1,
                 hw2 = dat$HW2,
                 hw3 = dat$HW3,
                 hw4 = dat$HW4,
                 hw5 = dat$HW5,
                 hw6 = dat$HW6,
                 hw7 = dat$HW7,
                 hw8 = dat$HW8,
                 hw9 = dat$HW9)

for (i in 1:nrow(dat)) {
  dat$Homework[i] <- score_homework(c(hws$hw1[i], hws$hw2[i], hws$hw3[i], hws$hw4[i], hws$hw5[i], 
                                      hws$hw6[i], hws$hw7[i], hws$hw8[i], hws$hw9[i]), drop = TRUE)
}


#Adding Quiz Variable
dat$Quiz <- NA
quizzes <- data.frame(q1 = dat$QZ1,
                      q2 = dat$QZ2,
                      q3 = dat$QZ3,
                      q4 = dat$QZ4)

for (i in 1:nrow(dat)) {
  dat$Quiz[i] <- score_quiz(c(quizzes$q1[i], quizzes$q2[i], quizzes$q3[i], quizzes$q4[i]), drop = TRUE)
}

#Adding Lab Score Variable
dat$Lab <- NA
for (j in 1:nrow(dat)) {
  dat$Lab <- score_lab(dat$ATT[i])
}

#Adding Overall Score Variable
dat$Overall <- NA
dat <- mutate(dat, Overall = .1 * Lab + .3 * Homework + .15 * Quiz + .2 * Test1 + .2 * Test2) 

#Adding Grade Variable
dat$Grade <- NA
for (j in nrow(dat)) {
  dat$Grade[i] <- grader(dat$Overall[i])
}

#Sinking summary stats for labs, hws, quizzes, the tests, and overall
sink_names <- c("../output/Test1-stats.txt", "../output/Test2-stats.txt", "../output/Lab-stats.txt",
           "../output/homework-stats.txt", "../output/Quiz-stats.txt", "../output/Overall-stats.txt")

for (j in 17:22) {
  sink(sink_names[j - 16])
  print_stats(summary_stats(dat[,j]))
  sink()
}

#Sinking into a data frame of clean scores
sink("../output/summary-cleanscores.txt")
str(dat)
sink()

#Exporting Data to cleanscores.csv
write.csv(dat, "../data/cleandata/cleanscores.csv")

