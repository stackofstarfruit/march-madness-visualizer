source("marchmadness.R")

server <- function(input, output) {
  output$conference_plot <- renderPlot({
    conference_plot
  })
  output$efficiency_plot <- renderPlot({
    efficiency_plot
  })
  output$offense_plot <- renderPlot({
    offense_plot
  })
  output$defense_plot <- renderPlot({
    defense_plot
  })
  output$tempo_plot <- renderPlot({
    tempo_plot
  })
  output$luck_plot <- renderPlot({
    luck_plot
  })
  output$winrate_plot <- renderPlot({
    winrate_plot
  })
  output$underseeded_plot <- renderPlot({
    underseeded_plot
  })
  output$offense_defense_plot <- renderPlot({
    offense_defense_plot
  })
  output$unbalanced_plot <- renderPlot({
    unbalanced_plot
  })
}