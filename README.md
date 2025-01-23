# Ballpark-Factors-2022



Full Report with graphics and explanations found in the WrittenReport word document. 

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





##RESULTS 

#Environmental Factors and Homerun Effect
Our analysis explored how environmental factors such as elevation, temperature, and daytime games influence home run probabilities in MLB parks. Key findings include:

Elevation:

Insight: Parks at higher elevations, like Coors Field (Colorado Rockies), exhibit increased home run effects.
Correlation: Weak positive correlation (0.13).
Takeaway: Elevation impacts home run frequency but is not the sole determinant. Parks at similar elevations still display a wide range of home run effects due to other factors.
Temperature:

Insight: Warmer parks, such as those for the Diamondbacks and Cardinals, slightly favor home runs. Cooler parks, like the Reds’, can still exhibit high home run effects.
Correlation: Minimal positive correlation (0.18).
Takeaway: Temperature alone is a poor predictor of home run probabilities.
Daytime Games:

Insight: Parks with more daytime games (e.g., Wrigley Field) show a slight decrease in home run effects.
Correlation: Weak negative correlation (-0.21).
Takeaway: Timing of games has minimal impact on home run statistics compared to other park-specific factors

![image](https://github.com/user-attachments/assets/02e708ab-ddd2-4204-89c7-9e8bf6362a5d)
![image](https://github.com/user-attachments/assets/795d8a0b-ea99-420f-a340-ffd43ddb5337)
![image](https://github.com/user-attachments/assets/0120ef49-3f65-4063-aa3f-e0a986a30811)
![image](https://github.com/user-attachments/assets/955de668-8b5b-4de3-a399-f777dc2b5919)
![image](https://github.com/user-attachments/assets/67f183dc-928d-4ebd-9865-406891b02a26)

Extra Base Hits and Extra Distance in MLB Stadiums
This analysis examined the relationship between extra-base hits (doubles and triples) and extra distance gained in MLB parks. Key findings include:

Doubles by Right-Handed Hitters (RHH):

Insight: Most parks show minimal variation in extra distance for doubles by RHH.
Notable Exception: Coors Field (Colorado Rockies) significantly increases the extra distance due to altitude and spacious outfields.
Correlation: Moderate (0.54), indicating some influence but not universally significant.
Doubles by Left-Handed Hitters (LHH):

Insight: Similar patterns to RHH, with Coors Field again standing out for longer distances.
Additional Note: Fenway Park (Boston Red Sox) shows a high frequency of doubles, but extra distance remains unremarkable due to other factors.
Correlation: Weak (0.25), suggesting limited park influence overall.
Triples by Right-Handed Hitters (RHH):
![image](https://github.com/user-attachments/assets/099f7088-0041-4d41-bbcc-baca57ad1de5)


Insight: Coors Field remains a clear outlier, with significantly longer triples. Arizona's Chase Field also shows some increase in distance, while most parks cluster around lower ranges.
Additional Note: Comerica Park (Detroit Tigers) allows more triples but without a significant extra distance boost.
Correlation: Moderate (0.41), indicating variability influenced by specific parks.
Triples by Left-Handed Hitters (LHH):
![image](https://github.com/user-attachments/assets/74bf93f2-dad4-446a-aa6d-f24b379ae1e2)


Insight: Coors Field again dominates as an outlier. Chase Field shows moderate increases, while most parks maintain consistent extra distances.
Additional Note: Detroit's Comerica Park facilitates more triples but not necessarily longer distances.
Correlation: Weak (0.20), emphasizing minimal park influence.
![image](https://github.com/user-attachments/assets/6bb07d1a-f4ea-4a9b-a103-8e8a845236a9)


Takeaways
Coors Field’s Unique Impact: Its high altitude and spacious design consistently amplify extra distances for doubles and triples across both handedness groups.
Park-Specific Variability: While certain parks like Chase Field and Comerica Park exhibit trends, the overall effect of extra distance is limited in most MLB parks.
Conclusion: While some parks influence extra distances for hits, these effects are not universally drastic, highlighting the unique but localized nature of park-specific factors.


Home Runs Analysis: Handedness and Pull-Side Distance
This analysis examines the relationship between home run frequencies, hitter handedness (RHH and LHH), and pull-side distances (left field for RHH, right field for LHH) in MLB parks. Key insights include:

Right-Handed Hitters (RHH): Home Runs vs. Left Field Distance
![image](https://github.com/user-attachments/assets/05070cb7-8e2f-46fd-9b7e-a5a8240cee43)


Insight: A varied relationship exists between left field distances and RHH home run rates.
Notable Findings:
Coors Field leads in RHH home runs due to hitter-friendly conditions.
Teams like the Red Sox, Yankees, and Astros exhibit high RHH home run rates despite shorter left field distances, likely due to advantageous park designs.
Longer left field distances (e.g., Cubs and Brewers) do not necessarily suppress RHH home runs.
Conclusion: Park dimensions influence RHH home runs, but other factors like wall height and elevation play significant roles.
Left-Handed Hitters (LHH): Home Runs vs. Right Field Distance
![image](https://github.com/user-attachments/assets/648e6b6f-b675-4cf9-a699-1a38ff7f2cd6)

Insight: No strong correlation exists between right field distance and LHH home run rates.
Notable Findings:
Cubs, Rockies, and Brewers show high LHH home run rates despite varying right field distances.
Giants and Red Sox have lower LHH home run rates even with shorter right fields, suggesting other factors are at play.
Conclusion: Right field distances alone do not dictate LHH home run frequencies; stadium design and environmental variables matter.
Home Run Rate Differentials (LHH vs. RHH):

Table and Bar Graph Analysis:
Significant variation in home run differentials across MLB teams.
Teams like the Dodgers show a pronounced advantage for LHH, while the Yankees favor RHH.
Correlations with Field Dimensions:
Shorter pull-side distances do not always correspond with higher home run rates. Factors such as wall height and ballpark design significantly influence outcomes.








