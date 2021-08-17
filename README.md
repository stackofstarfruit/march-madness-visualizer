# march-madness-visualizer
Uses kenpom rankings to provide a visual representation of relative team strengths in the NCAA Mens' March Madness Basketball Tournament

The project is currently hosted at https://stackofstarfruit.shinyapps.io/march-madness-visualizer/. It was previously updated live as 
teams were eliminated from the tournament, but right now it uses an archived webpage from right before the tournament began. 
All statistical data is imported from https://kenpom.com/ using the rvest web scraping package. The "underseeded" metric compares 
tournament seedings to kenpom rankings, while Efficiency denotes the expected margin of victory against another D1 basketball team.
