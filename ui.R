ui <- fluidPage(
  titlePanel("Select a metric to see March Madness teams ranked by that metric!"),
  tabsetPanel(
    tabPanel("Conference", plotOutput(outputId = "conference_plot")),
    tabPanel("Efficiency", plotOutput(outputId = "efficiency_plot")),
    tabPanel("Offense", plotOutput(outputId = "offense_plot")),
    tabPanel("Defense", plotOutput(outputId = "defense_plot")),
    tabPanel("Offense + Defense", p("Scroll down to see teams ranked by how 
                                    unbalanced their offense / defense is."), 
             plotOutput(outputId = "offense_defense_plot"),
             plotOutput(outputId = "unbalanced_plot")),
    tabPanel("Tempo", plotOutput(outputId = "tempo_plot")),
    tabPanel("Luck", plotOutput(outputId = "luck_plot")),
    tabPanel("Winrate", plotOutput(outputId = "winrate_plot")),
    tabPanel("Underseeded", plotOutput(outputId = "underseeded_plot"))
  ),
  p("Information sourced from Ken Pomeroy's rankings at kenpom.com")
)