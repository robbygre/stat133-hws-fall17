#Title: Hw03-Robby-Grewal
#Description: Create a csv file and prepare data
#Inputs: nba2017-teams.csv


library(dplyr)
library(ggplot2)

#Load the Roster

setwd("~/stat133/stat133-hws-fall17/hw03/data")

github_url <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/"
csv <- "data/nba2017-roster.csv"
download.file(url = paste0(github_url, csv), destfile = 'nba2017-roster.csv')
roster_data <- read.csv('nba2017-roster.csv', stringsAsFactors = FALSE)

#Load the Data
csv <- "data/nba2017-stats.csv"
download.file(url = paste0(github_url, csv), destfile = 'nba2017-stats.csv')
stats_data <- read.csv('nba2017-stats.csv', stringsAsFactors = FALSE)


#Adding Missing Variables
stats_data <- stats_data %>% 
              mutate(missed_fg = stats_data$field_goals_atts - stats_data$field_goals_made)

stats_data <- stats_data %>% 
              mutate(missed_ft = stats_data$points1_atts - stats_data$points1_made)

stats_data <- stats_data %>% 
              mutate(points = stats_data$points1_made + (stats_data$points2_made * 2) + (stats_data$points3_made * 3))

stats_data <- stats_data %>% 
              mutate(rebounds = stats_data$off_rebounds + stats_data$def_rebounds)

stats_data <- stats_data %>% 
              mutate(efficiency = (stats_data$points + stats_data$rebounds + stats_data$assists + stats_data$steals +
                                    stats_data$blocks - stats_data$missed_fg - stats_data$missed_ft - stats_data$turnovers)/
                                    stats_data$games_played)

#Exporting data from summary
setwd("~/stat133/stat133-hws-fall17/hw03/output")
sink(file = "efficiency-summary.txt")
summary(stats_data$efficiency)
sink()

setwd("~/stat133/stat133-hws-fall17/hw03/code")
dat <- merge(stats_data, roster_data)


#Creating nba2017-teams.csv
dat$salary <- round(dat$salary/1000000, 2)
teams <- dat %>%
  group_by(team) %>%
  select(team, experience, salary, points3_made, points2_made, points1_made,
         points, off_rebounds, def_rebounds, assists, steals, blocks,
         turnovers, fouls, efficiency)

teams <- teams %>% summarise_all(funs(sum))
summary(teams)

sink(file = "~/stat133/stat133-hws-fall17/hw03/data/teams-summary.txt")
summary(teams)
sink()

setwd("~/stat133/stat133-hws-fall17/hw03/data")
write.csv(teams, file = "nba2017-teams.csv")

#star plot
setwd("~/stat133/stat133-hws-fall17/hw03/images")
pdf(file = "teams_star_plot.pdf")
stars(teams[,-1], labels = teams$team)
dev.off()

#scatterplot
pdf(file = "experience_salary.pdf")
ggplot(teams, aes(x = experience, y = salary, col = team)) +
  geom_point() +
  labs(title = "Salary vs Experience") 
dev.off()
  













