knitr::opts_chunk$set(echo = TRUE)
#install.packages("rvest")
library(rvest)

#install.packages("xml2")
library(xml2)

# Load the first  CSV file into a data frame
data <- read.csv("ballparks.csv")



###Extracted from GitHub baseballr page 


#Go through webscrapping to get second file

#' @rdname fg_park
#' @title **Scrape Park Factors from FanGraphs**
#' @description This function allows you to scrape park factors for a given season from FanGraphs.com.
#' @param yr Season for which you want to scrape the park factors.
#' @return Returns a tibble of park factors.
#'  |col_name  |types     |
#'  |:---------|:---------|
#'  |season    |integer   |
#'  |home_team |character |
#'  |basic_5yr |integer   |
#'  |3yr       |integer   |
#'  |1yr       |integer   |
#'  |single    |integer   |
#'  |double    |integer   |
#'  |triple    |integer   |
#'  |hr        |integer   |
#'  |so        |integer   |
#'  |UIBB      |integer   |
#'  |GB        |integer   |
#'  |FB        |integer   |
#'  |LD        |integer   |
#'  |IFFB      |integer   |
#'  |FIP       |integer   |
#' @export
#' @examples \donttest{
#'   try(fg_park(2013))
#' }

fg_park <- function(yr) {
  
  tryCatch(
    expr = {
      park_table <- paste0("http://www.fangraphs.com/guts.aspx?type=pf&teamid=0&season=", yr) %>% 
        xml2::read_html() %>%
        rvest::html_element(xpath = '//*[(@id = "GutsBoard1_dg1_ctl00")]') %>%
        rvest::html_table() %>%
        setNames(c("season", "home_team", "basic_5yr", "3yr", "1yr", "single", "double", "triple", "hr",
                   "so", "UIBB", "GB", "FB", "LD", "IFFB", "FIP"))
      park_table <- park_table %>% 
        make_baseballr_data("Park Factors data from FanGraphs.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no park factors data available!"))
    },
    finally = {
    }
  )
  return(park_table)
}



#' @rdname fg_park
#' @title **Scrape Park Factors by handedness from FanGraphs**
#'
#' @description This function allows you to scrape park factors by handedness from FanGraphs.com for a given single year.
#' @param yr Season for which you want to scrape the park factors.
#' @return Returns a tibble of park factors by handedness.
#'  |col_name      |types     |
#'  |:-------------|:---------|
#'  |season        |integer   |
#'  |home_team     |character |
#'  |single_as_LHH |integer   |
#'  |single_as_RHH |integer   |
#'  |double_as_LHH |integer   |
#'  |double_as_RHH |integer   |
#'  |triple_as_LHH |integer   |
#'  |triple_as_RHH |integer   |
#'  |hr_as_LHH     |integer   |
#'  |hr_as_RHH     |integer   |
#' @importFrom stats setNames
#' @export
#' @examples \donttest{
#'   try(fg_park_hand(2013))
#' }

fg_park_hand <- function(yr) {
  tryCatch(
    expr = {
      park_table <- paste0("http://www.fangraphs.com/guts.aspx?type=pfh&teamid=0&season=", yr) %>% 
        xml2::read_html() %>%
        rvest::html_element(xpath = '//*[(@id = "GutsBoard1_dg1_ctl00")]') %>%
        rvest::html_table() %>%
        stats::setNames(c("season", "home_team", "single_as_LHH", "single_as_RHH",
                          "double_as_LHH", "double_as_RHH", "triple_as_LHH", "triple_as_RHH",
                          "hr_as_LHH", "hr_as_RHH"))
      park_table <- park_table %>% 
        make_baseballr_data("Park Factors by Handedness data from FanGraphs.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no park factors by handedness data available!"))
    },
    finally = {
    }
  )
  
  
  
  
  
  return(park_table)
  
  
  
}

fangraph_data <- fg_park(2022)
extra_data <- fg_park_hand(2022)
               ###Start of merging data frames### 


#view data frames and the data types associated with them 
str(data)
str(fangraph_data)
str(extra_data)
#Correct data types are used with each data frame 


# Display all values in the 'team_name' column
data$team_name

#Change the team_name under Data to full team names 
team_mapping <- c(
  ATL = "Braves",
  AZ = "Diamondbacks",
  BAL = "Orioles",
  BOS = "Red Sox",
  CHC = "Cubs",
  CIN = "Reds",
  CLE = "Guardians",
  COL = "Rockies",
  CWS = "White Sox",
  DET = "Tigers",
  HOU = "Astros",
  KC = "Royals",
  LAA = "Angels",
  LAD = "Dodgers",
  MIA = "Marlins",
  MIL = "Brewers",
  MIN = "Twins",
  NYM = "Mets",
  NYY = "Yankees",
  OAK = "Athletics",
  PHI = "Phillies",
  PIT = "Pirates",
  SD = "Padres",
  SEA = "Mariners",
  SF = "Giants",
  STL = "Cardinals",
  TB = "Rays",
  TEX = "Rangers",
  TOR = "Blue Jays",
  WSH = "Nationals"
)
# Replace abbreviations with team names in data$team_name
data$team_name <- team_mapping[data$team_name]


#Change home_team in fangraph_data to team_name also for extra data 

installed.packages("dplyr")
library(dplyr)

fangraph_data <- rename(fangraph_data, team_name = home_team)
extra_data <- rename(extra_data, team_name = home_team)
#Now check to make sure the new columns match with same titles
print(fangraph_data$team_name)
print(data$team_name)
print(extra_data$team_name)


#Set each data frame to organized in alphabetical order 
library(dplyr)

fangraph_data_sorted <- arrange(fangraph_data, team_name)

data_sorted <- arrange(data, team_name)

extra_data_sorted <- arrange(extra_data, team_name)


#Elimate season from fangraph_data_sorted 
fangraph_data_sorted <- select(fangraph_data_sorted, -season)

#Drop the 'team_name' column from fangraph_data_sorted
fangraph_data_sorted <- select(fangraph_data_sorted, -team_name)

#Elimate season from extra_data_sorted 
extra_data_sorted <- select(extra_data_sorted, -season)

#Elimated team_name from extra_data_sorted 
extra_data_sorted <- extra_data_sorted[ , !(names(extra_data_sorted) %in% c("team_name"))]

#Data frames are ready to be horizontally merged 
ballparkfactor_data <- cbind(data_sorted, fangraph_data_sorted, extra_data_sorted)


#Save merged data frame as csv 
# Save ballparkfactor_data as a CSV file
write.csv(ballparkfactor_data, "ballparkfactor_data.csv", row.names = FALSE)
####Q1####

                                                          ###Elevation### 
# Scatter plot with categorized teams
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("ggrepel")
library(ggplot2)
library(dplyr)
library(ggrepel)

# Create categories based on hr_park_effects
ballparkfactor_data$category <- cut(ballparkfactor_data$hr_park_effects,
                                    breaks = c(-Inf, 90, 100, 110, Inf),
                                    labels = c("Much Lower", "Slightly Lower", "Slightly Higher", "Much Higher"),
                                    include.lowest = TRUE)


ggplot(ballparkfactor_data, aes(x = hr_park_effects, y = elevation, color = category)) +
  geom_point() +
  geom_text_repel(data = subset(ballparkfactor_data, team_name %in% c("Rockies", "Reds")), 
                  aes(label = team_name), 
                  nudge_x = 0.25, nudge_y = 0.25, 
                  na.rm = TRUE, size = 3.5) +
  geom_vline(xintercept = 100, linetype = "solid", color = "black", size = 1.5) +  # Bold line at x = 100
  annotate("text", x = 100, y = max(ballparkfactor_data$elevation, na.rm = TRUE), 
           label = "Homerun Park Effect Average", vjust = 1, hjust = 1.1, 
           color = "black", size = 3.5, ) +  # Annotation for the line
  scale_color_manual(values = c("Much Lower" = "blue", 
                                "Slightly Lower" = "green", 
                                "Slightly Higher" = "yellow", 
                                "Much Higher" = "red")) +
  labs(title = "Elevation vs HR Park Effect",
       x = "Homerun Park Effect",
       y = "Elevation",
       color = "Park Effect Category") +
  theme_minimal() +
  theme(panel.grid.major = element_line(color = "gray", size = 0.5),
        panel.grid.minor = element_line(color = "lightgray", size = 0.25),
        legend.position = "bottom") +  # Adjust legend position as needed
  scale_x_continuous(breaks = seq(from = floor(min(ballparkfactor_data$hr_park_effects, na.rm = TRUE)/10)*10, 
                                  to = ceiling(max(ballparkfactor_data$hr_park_effects, na.rm = TRUE)/10)*10, 
                                  by = 10))  # Set x breaks to increments of 10
# Create a list of teams under each category
team_categories <- split(ballparkfactor_data$team_name, ballparkfactor_data$category)



# Create a bullet-point list
bullet_list <- ""
for(category in names(team_categories)) {
  bullet_list <- paste(bullet_list, sprintf("- %s: %s\n", category, paste(team_categories[[category]], collapse = ", ")), sep = "")
}


# Exclude the 'Rockies' from the dataset for correlation calculation
filtered_data <- ballparkfactor_data[ballparkfactor_data$team_name != "Rockies", ]
# Calculate the correlation coefficient
correlation <- cor(ballparkfactor_data$hr_park_effects, ballparkfactor_data$elevation, use = "complete.obs")
correlation_output <- (round(correlation, 2))


cat("Correlation coefficient between Homerun Park Effects and Elevation:\n")
correlation_output
cat("Teams categorized by Park Effects on Elevation:\n")
cat(bullet_list)



                                                         ###AVGTEMP###
# Create categories based on hr_park_effects
ballparkfactor_data$category <- cut(ballparkfactor_data$hr_park_effects,
                                    breaks = c(-Inf, 90, 100, 110, Inf),
                                    labels = c("Much Lower", "Slightly Lower", "Slightly Higher", "Much Higher"),
                                    include.lowest = TRUE)




# Scatter plot with categorized teams and black labels for each team
ggplot(ballparkfactor_data, aes(x = hr_park_effects, y = avg_temp, color = category)) +
  geom_point() +
  geom_text_repel(aes(label = team_name),  # Label each data point with the team name
                  nudge_x = 0.25, nudge_y = 0.25, 
                  na.rm = TRUE, size = 3.5, color = "black") +  # Set label color to black
  geom_vline(xintercept = 100, linetype = "solid", color = "black", size = 1.5) +  # Bold line at x = 100
  annotate("text", x = 100, y = max(ballparkfactor_data$avg_temp, na.rm = TRUE), 
           label = "Homerun Park Effect Average", vjust = 1, hjust = -0.15, 
           color = "black", size = 3.5, fontface = "bold") +  # Annotation for the line
  scale_color_manual(values = c("Much Lower" = "blue", 
                                "Slightly Lower" = "green", 
                                "Slightly Higher" = "brown", 
                                "Much Higher" = "red")) +
  labs(title = "Average Temperature vs HR Park Effect",
       x = "Homerun Park Effect",
       y = "Average Temperature",
       color = "Park Effect Category") +
  theme_minimal() +
  theme(panel.grid.major = element_line(color = "gray", size = 0.5),
        panel.grid.minor = element_line(color = "lightgray", size = 0.25),
        legend.position = "bottom") +
  scale_x_continuous(breaks = seq(from = floor(min(ballparkfactor_data$hr_park_effects, na.rm = TRUE)/10)*10, 
                                  to = ceiling(max(ballparkfactor_data$hr_park_effects, na.rm = TRUE)/10)*10, 
                                  by = 10))  # Set x breaks to increments of 10
#Calculate the correlation coefficient
correlation <- cor(ballparkfactor_data$hr_park_effects, ballparkfactor_data$avg_temp, use = "complete.obs")
correlation_output <- paste("Correlation coefficient between Homerun Park Effects and Average Temperature: ", round(correlation, 2))


# Create a list of teams under each category
team_categories <- split(ballparkfactor_data$team_name, ballparkfactor_data$category)

# Create and print a bullet-point list
bullet_list <- ""
for(category in names(team_categories)) {
  bullet_list <- paste(bullet_list, sprintf("- %s: %s\n", category, paste(team_categories[[category]], collapse = ", ")), sep = "")
} 


correlation_output
cat("Teams categorized by Park Effects on Average Temperature:\n")
cat(bullet_list)
library(ggplot2)
library(dplyr)
library(ggrepel)

# Create and print a bullet-point list
bullet_list <- ""
for(category in names(team_categories)) {
  bullet_list <- paste(bullet_list, sprintf("- %s: %s\n", category, paste(team_categories[[category]], collapse = ", ")), sep = "")
}
cat(bullet_list)

# Scatter plot with categorized teams and black labels for each team
ggplot(ballparkfactor_data, aes(x = hr_park_effects, y = daytime, color = category)) +
  geom_point() +
  geom_text_repel(aes(label = team_name), 
                  nudge_x = 0.07, nudge_y = 0.07, 
                  na.rm = TRUE, size = 3.5, color = "black") +
  geom_vline(xintercept = 100, linetype = "solid", color = "black", size = 1.5) +
  annotate("text", x = 100, y = max(ballparkfactor_data$daytime, na.rm = TRUE), 
           label = "Homerun Park Effect Average", vjust = 1.5, hjust = -0.15, 
           color = "black", size = 3.5, fontface = "bold") +
  scale_color_manual(values = c("Much Lower" = "blue", 
                                "Slightly Lower" = "green", 
                                "Slightly Higher" = "brown", 
                                "Much Higher" = "red")) +
  labs(title = "Daytime vs HR Park Effect",
       x = "Homerun Park Effect",
       y = "Daytime",
       color = "Park Effect Category") +
  theme_minimal() +
  theme(panel.grid.major = element_line(color = "gray", size = 0.5),
        panel.grid.minor = element_line(color = "lightgray", size = 0.25),
        legend.position = "bottom") +
  scale_x_continuous(breaks = seq(from = floor(min(ballparkfactor_data$hr_park_effects, na.rm = TRUE)/10)*10, 
                                  to = ceiling(max(ballparkfactor_data$hr_park_effects, na.rm = TRUE)/10)*10, 
                                  by = 10))  # Set x breaks to increments of 10
# Create categories based on hr_park_effects
ballparkfactor_data$category <- cut(ballparkfactor_data$hr_park_effects,
                                    breaks = c(-Inf, 90, 100, 110, Inf),
                                    labels = c("Much Lower", "Slightly Lower", "Slightly Higher", "Much Higher"),
                                    include.lowest = TRUE)

# Calculate the correlation coefficient using 'daytime' column
correlation <- cor(ballparkfactor_data$hr_park_effects, ballparkfactor_data$daytime, use = "complete.obs")
correlation_output <- paste("Correlation coefficient between Homerun Park Effects and Daytime: ", round(correlation, 2))



# Create a list of teams under each category
team_categories <- split(ballparkfactor_data$team_name, ballparkfactor_data$category)

# Create and print a bullet-point list
bullet_list <- ""
for(category in names(team_categories)) {
  bullet_list <- paste(bullet_list, sprintf("- %s: %s\n", category, paste(team_categories[[category]], collapse = ", ")), sep = "")
}


correlation_output
cat("Teams categorized by Park Effects on Daytime:\n")
cat(bullet_list)

library(ggplot2)
library(dplyr)
library(ggrepel)

data <- ballparkfactor_data


###DOUBLE LHH 
# Scatter plot for 'double_as_LHH' vs 'extra_distance' without categories
ggplot(data, aes(x = double_as_LHH, y = extra_distance, label = team_name)) +
  geom_point(color = "blue") +  # Set a fixed color for the points
  geom_text_repel(size = 3.5, 
                  box.padding = unit(0.35, "lines"),  # Adjust text box padding
                  point.padding = unit(0.5, "lines"),  # Adjust text repulsion from points
                  color = "black") +  # Ensure labels are black
  geom_vline(xintercept = 100, linetype = "solid", color = "black", size = 1.0) +  # Highlighted bar at x = 100
  annotate("text", x = 100, y = Inf, label = "Average Doubles as LHH in MLB", 
           color = "black", vjust = -0.5, hjust = 0.5, fontface = "plain", angle = 0) +  # Annotation for the bar
  labs(title = "Double as Left-Handed Hitter vs Extra Distance",
       x = "Double as LHH",
       y = "Extra Distance") +
  theme_minimal() +
  theme(legend.position = "none",  # Hide the legend
        panel.grid.major = element_line(color = "grey80"),  # Adjust gridline color
        panel.grid.minor = element_blank(),  # Hide minor gridlines
        text = element_text(size = 12)) +  # Adjust text size globally
  scale_x_continuous(breaks = seq(0, 150, by = 10))  # Set breaks every 10 units


##DOUBLE RHH 
# Scatter plot for 'double_as_RHH' vs 'extra_distance' without categories
ggplot(data, aes(x = double_as_RHH, y = extra_distance, label = team_name)) +
  geom_point(color = "blue") +  # Set a fixed color for the points
  geom_text_repel(size = 3.5, 
                  box.padding = unit(0.35, "lines"),  # Adjust text box padding
                  point.padding = unit(0.5, "lines"),  # Adjust text repulsion from points
                  color = "black") +  # Ensure labels are black
  geom_vline(xintercept = 100, linetype = "solid", color = "black", size = 1.0) +  # Highlighted bar at x = 100
  annotate("text", x = 100, y = Inf, label = "Average Doubles as RHH in MLB", 
           color = "black", vjust = -0.5, hjust = 0.5, fontface = "plain", angle = 0) +  # Annotation for the bar
  labs(title = "Double as Right-Handed Hitter vs Extra Distance",
       x = "Double as RHH",
       y = "Extra Distance") +
  theme_minimal() +
  theme(legend.position = "none",  # Hide the legend
        panel.grid.major = element_line(color = "grey80"),  # Adjust gridline color
        panel.grid.minor = element_blank(),  # Hide minor gridlines
        text = element_text(size = 12)) +  # Adjust text size globally
  scale_x_continuous(breaks = seq(0, 150, by = 10))  # Set breaks every 10 units



##TRIPLE LHH 
# Scatter plot for 'triple_as_LHH' vs 'extra_distance' without categories
ggplot(data, aes(x = triple_as_LHH, y = extra_distance, label = team_name)) +
  geom_point(color = "blue") +  # Set a fixed color for the points
  geom_text_repel(size = 3.5, 
                  box.padding = unit(0.35, "lines"),  # Adjust text box padding
                  point.padding = unit(0.5, "lines"),  # Adjust text repulsion from points
                  color = "black") +  # Ensure labels are black
  geom_vline(xintercept = 100, linetype = "solid", color = "black", size = 1.0) +  # Highlighted bar at x = 100
  annotate("text", x = 100, y = Inf, label = "Average Triples as LHH in MLB", 
           color = "black", vjust = -0.5, hjust = 0.5, fontface = "plain", angle = 0) +  # Annotation for the bar
  labs(title = "Triple as Left-Handed Hitter vs Extra Distance",
       x = "Triple as LHH",
       y = "Extra Distance") +
  theme_minimal() +
  theme(legend.position = "none",  # Hide the legend
        panel.grid.major = element_line(color = "grey80"),  # Adjust gridline color
        panel.grid.minor = element_blank(),  # Hide minor gridlines
        text = element_text(size = 12)) +  # Adjust text size globally
  scale_x_continuous(breaks = seq(0, 150, by = 10))  # Set breaks every 10 units


##TRIPLE as RHH 
# Scatter plot for 'triple_as_RHH' vs 'extra_distance' without categories
ggplot(data, aes(x = triple_as_RHH, y = extra_distance, label = team_name)) +
  geom_point(color = "blue") +  # Set a fixed color for the points
  geom_text_repel(size = 3.5, 
                  box.padding = unit(0.35, "lines"),  # Adjust text box padding
                  point.padding = unit(0.5, "lines"),  # Adjust text repulsion from points
                  color = "black") +  # Ensure labels are black
  geom_vline(xintercept = 100, linetype = "solid", color = "black", size = 1.0) +  # Highlighted bar at x = 100
  annotate("text", x = 100, y = Inf, label = "Average Triples as RHH in MLB", 
           color = "black", vjust = -0.5, hjust = 0.5, fontface = "plain", angle = 0) +  # Annotation for the bar
  labs(title = "Triple as Right-Handed Hitter vs Extra Distance",
       x = "Triple as RHH",
       y = "Extra Distance") +
  theme_minimal() +
  theme(legend.position = "none",  # Hide the legend
        panel.grid.major = element_line(color = "grey80"),  # Adjust gridline color
        panel.grid.minor = element_blank(),  # Hide minor gridlines
        text = element_text(size = 12)) +  # Adjust text size globally
  scale_x_continuous(breaks = seq(0, 150, by = 10))  # Set breaks every 10 units

# Calculate the correlation coefficients
cor_double_LHH <- cor(data$double_as_LHH, data$extra_distance)
cor_double_RHH <- cor(data$double_as_RHH, data$extra_distance)
cor_triple_LHH <- cor(data$triple_as_LHH, data$extra_distance)
cor_triple_RHH <- cor(data$triple_as_RHH, data$extra_distance)

# Print all correlation coefficients at the end
print(paste("Correlation coefficient between Double as Left-Handed Hitter and Extra Distance:", round(cor_double_LHH, 2)))
print(paste("Correlation coefficient between Double as Right-Handed Hitter and Extra Distance:", round(cor_double_RHH, 2)))
print(paste("Correlation coefficient between Triple as Left-Handed Hitter and Extra Distance:", round(cor_triple_LHH, 2)))
print(paste("Correlation coefficient between Triple as Right-Handed Hitter and Extra Distance:", round(cor_triple_RHH, 2)))
data <- ballparkfactor_data

library(ggplot2)
library(ggrepel)


# Plotting hr_as_RHH vs left_field
p1 <- ggplot(data, aes(x = hr_as_RHH, y = left_field, label = team_name)) +
  geom_point(aes(color = hr_as_RHH)) +
  geom_vline(xintercept = 100, linetype = "dashed", color = "red") +
  geom_text_repel() +
  labs(title = "HR as Right-Handed Hitter vs Left Field",
       x = "HR as RHH",
       y = "Left Field") +
  theme_minimal()

# Plotting hr_as_LHH vs right_field
p2 <- ggplot(data, aes(x = hr_as_LHH, y = right_field, label = team_name)) +
  geom_point(aes(color = hr_as_LHH)) +
  geom_vline(xintercept = 100, linetype = "dashed", color = "red") +
  geom_text_repel() +
  labs(title = "HR as Left-Handed Hitter vs Right Field",
       x = "HR as LHH",
       y = "Right Field") +
  theme_minimal()

# Print the plots
print(p1)
print(p2)

# Calculate the average HR for RHH and LHH
average_hr <- aggregate(cbind(hr_as_RHH, hr_as_LHH) ~ team_name, data, mean)

# Calculate the difference in HR between RHH and LHH
average_hr$hr_difference <- abs(average_hr$hr_as_RHH - average_hr$hr_as_LHH)

# Add 'left_field' and 'right_field' columns to the output
average_hr$left_field <- data$left_field[match(average_hr$team_name, data$team_name)]
average_hr$right_field <- data$right_field[match(average_hr$team_name, data$team_name)]

# Print the updated dataframe
print(average_hr)
library(ggplot2)

# Create a horizontal bar chart with unique colors and ordered by hr_difference
ggplot(data = average_hr, aes(x = reorder(team_name, -hr_difference), y = hr_difference, fill = team_name)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Home Run Difference by Team LHH and RHH",
    x = "MLB Team",
    y = "HR Difference"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_fill_discrete() +  # Use unique colors for each team
  coord_flip()
