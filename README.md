# Ballpark-Factors-2022

Authors: Tommy Heideman, Joey Matuisk, and Jake Mitchell


This R script provides a comprehensive analysis of ballpark factors in Major League Baseball (MLB) stadiums for the 2022 season. It aims to explore how different stadiums affect game outcomes, specifically focusing on factors like ballpark dimensions, altitude, and local weather conditions.

The data is specifically about performance in every MLB teams stadiums during any given game during the 2022 season. Due to stadium name changes we referred to every team name in the project for common persons understanding of data. 

Features
Data Collection: Kaggle and Baseball Savant: The ballparkfactors.csv file, a primary data source, is sourced from Kaggle but is also available on Baseball Savant. This dataset provides comprehensive information about ballpark factors, which are crucial for analyzing the impact of different stadiums on game outcomes.

Web Scraping from Fangraphs: We have employed web scraping techniques to gather additional datasets directly from Fangraphs. This approach allows us to extract up-to-date and detailed statistics about games, which are essential for our analysis. The scraped data include game-specific statistics that are not readily available in traditional datasets.

Data Processing: The script streamlines data from multiple sources for analysis. This involves cleaning, merging, and normalizing steps to ensure data consistency and reliability. Special attention is given to integrating the ballparkfactors.csv file with the web-scraped data from Fangraphs, ensuring a seamless blend of information.

Statistical Analysis: The script uses robust statistical methods to assess the influence of different ballpark characteristics on game dynamics. By analyzing combined datasets, we can draw more comprehensive conclusions about the impact of stadiums on game outcomes.

Data Visualization: The script generates insightful visualizations to represent the combined data effectively, helping to identify trends, patterns, and correlations between ballpark factors and game results.

## Data Dictionary

The dataset includes the following fields:

| Column Name       | Description                                                       | Data Type |
|-------------------|-------------------------------------------------------------------|-----------|
| `team_name`       | The name of the baseball team                                     | `chr`     |
| `ballpark`        | The name of the baseball park or stadium                          | `chr`     |
| `left_field`      | Distance to left field in feet                                    | `int`     |
| `center_field`    | Distance to center field in feet                                  | `int`     |
| `right_field`     | Distance to right field in feet                                   | `int`     |
| `min_wall_height` | Minimum height of the ballpark walls in feet                      | `num`     |
| `max_wall_height` | Maximum height of the ballpark walls in feet                      | `int`     |
| `hr_park_effects` | Home run park effects factor, scaled where 100 is average         | `int`     |
| `extra_distance`  | Total extra distance that a particular ballpark adds to hits     | `num`     |
| `avg_temp`        | Average temperature at the ballpark                               | `num`     |
| `elevation`       | Elevation of the ballpark above sea level in feet                 | `int`     |
| `roof`            | Percent of time the roof is used in the ballpark                  | `num`     |
| `daytime`         | Percent of time games are played in daytime                       | `num`     |
| `basic_5yr`       | Basic 5-year performance factor, scaled where 100 is average      | `int`     |
| `3yr`             | 3-year performance factor, scaled where 100 is average            | `int`     |
| `1yr`             | 1-year performance factor, scaled where 100 is average            | `int`     |
| `single`          | Single hit rate, scaled where 100 is average                      | `int`     |
| `double`          | Double hit rate, scaled where 100 is average                      | `int`     |
| `triple`          | Triple hit rate, scaled where 100 is average                      | `int`     |
| `hr`              | Home run rate, scaled where 100 is average                        | `int`     |
| `so`              | Strikeout rate, scaled where 100 is average                       | `int`     |
| `UIBB`            | Unintentional walks rate, scaled where 100 is average             | `int`     |
| `GB`              | Ground Ball rate, scaled where 100 is average                     | `int`     |
| `FB`              | Fly Ball rate, scaled where 100 is average                        | `int`     |
| `LD`              | Line Drive rate, scaled where 100 is average                      | `int`     |
| `IFFB`            | Infield Fly Ball rate, scaled where 100 is average                | `int`     |
| `FIP`             | Fielding Independent Pitching, scaled where 100 is average        | `int`     |
| `single_as_LHH`   | Singles rate as Left-Handed Hitter, scaled where 100 is average   | `int`     |
| `single_as_RHH`   | Singles rate as Right-Handed Hitter, scaled where 100 is average  | `int`     |
| `double_as_LHH`   | Doubles rate as Left-Handed Hitter, scaled where 100 is average   | `int`     |
| `double_as_RHH`   | Doubles rate as Right-Handed Hitter, scaled where 100 is average  | `int`     |
| `triple_as_LHH`   | Triples rate as Left-Handed Hitter, scaled where 100 is average   | `int`     |
| `triple_as_RHH`   | Triples rate as Right-Handed Hitter, scaled where 100 is average  | `int`     |
| `hr_as_LHH`       | Home Run rate as Left-Handed Hitter, scaled where 100 is average  | `int`     |
| `hr_as_RHH`       | Home Run rate as Right-Handed Hitter, scaled where 100 is average | `int`     |

