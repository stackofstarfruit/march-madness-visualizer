# march-madness-visualizer
Uses kenpom rankings to provide a visual representation of relative team strengths in the NCAA Mens' March Madness Basketball Tournament

The project is currently hosted at https://stackofstarfruit.shinyapps.io/March_Madness/, but it does not display much information
because it is designed to auto-update when teams are eliminated from the tournament (and only one team remains, the champions Baylor). 
All statistical data is imported from https://kenpom.com/ using the rvest web scraping package. The "underseeded" metric compares 
tournament seedings to kenpom rankings, while Efficiency denotes the expected margin of victory against another D1 basketball team.
