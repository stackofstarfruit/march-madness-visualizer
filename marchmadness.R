library(rvest)
library(dplyr)
library(purrr)
library(stringr)
library(tidyr)
library(ggplot2)
library(reshape2)

get_page <- read_html("https://kenpom.com")

rank <- 
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes(".hard_left") %>%
  html_text()

seed <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes(".next_left") %>%
  html_nodes(".seed") %>%
  html_text()

team <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes(".next_left") %>%
  html_nodes("a") %>%
  html_text()

conference <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes(".conf") %>%
  html_nodes("a") %>%
  html_text()

record <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes(".wl") %>%
  html_text()

vector_selector <-
  c(F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F)

vector_selector[5] = T
efficiency <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes("td") %>%
  html_text()
efficiency = efficiency[vector_selector]

vector_selector[5] = F
vector_selector[6] = T
offense <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes("td") %>%
  html_text()
offense = offense[vector_selector]

vector_selector[6] = F
vector_selector[7] = T
offense_rank <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes("td") %>%
  html_text()
offense_rank = offense_rank[vector_selector]

vector_selector[7] = F
vector_selector[8] = T
defense <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes("td") %>%
  html_text()
defense = defense[vector_selector]

vector_selector[8] = F
vector_selector[9] = T
defense_rank <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes("td") %>%
  html_text()
defense_rank = defense_rank[vector_selector]

vector_selector[9] = F
vector_selector[10] = T
tempo <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes("td") %>%
  html_text()
tempo = tempo[vector_selector]

vector_selector[10] = F
vector_selector[11] = T
tempo_rank <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes("td") %>%
  html_text()
tempo_rank = tempo_rank[vector_selector]

vector_selector[11] = F
vector_selector[12] = T
luck <-
  get_page %>%
  html_nodes("table") %>%
  html_nodes(".tourney") %>%
  html_nodes("td") %>%
  html_text()
luck = luck[vector_selector]

team_table <- data.frame(rank, seed, team, conference, record, efficiency, 
                         offense, offense_rank, defense, defense_rank, tempo,
                         tempo_rank, luck)

team_table <- 
  team_table %>%
  separate(record, c("wins","losses"), sep = "-") %>%
  mutate("wins" = as.numeric(wins)) %>%
  mutate("losses" = as.numeric(losses)) %>%
  mutate("winrate" = wins / (wins + losses)) %>%
  mutate("rank" = as.numeric(rank)) %>%
  mutate("seed" = as.numeric(seed)) %>%
  mutate("efficiency" = as.numeric(efficiency)) %>%
  mutate("offense" = as.numeric(offense)) %>%
  mutate("offense_rank" = as.numeric(offense_rank)) %>%
  mutate("defense" = as.numeric(defense)) %>%
  mutate("defense_rank" = as.numeric(defense_rank)) %>%
  mutate("tempo" = as.numeric(tempo)) %>%
  mutate("tempo_rank" = as.numeric(tempo_rank)) %>%
  mutate("luck" = as.numeric(luck))
team_table$team <- factor(team_table$team, levels = team_table$team)

conf_table <- as.data.frame(table(team_table$conference))
conference_plot <-
  ggplot(conf_table, aes(x = reorder(Var1, -Freq), y = Freq)) + 
  geom_col(fill = "#ff4500") +
  ggtitle("March Madness Teams by Conference") +
  labs(x = "Conference", y = "Number of Teams") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

efficiency_plot <-
  ggplot(team_table, aes(x = reorder(team, -efficiency), y = efficiency)) + 
  geom_col(fill = "#ff4500") +
  ggtitle("March Madness Teams by Efficiency") +
  labs(x = "Team", y = "Expected Margin of Victory)") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

offense_plot <-
  ggplot(team_table, aes(x = reorder(team, -offense), y = offense)) + 
  geom_col(fill = "#ff4500") +
  ggtitle("March Madness Teams by Offense") +
  labs(x = "Team", y = "Expected Points Scored") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  coord_cartesian(ylim = c(80,130))

defense_plot <-
  ggplot(team_table, aes(x = reorder(team, defense), y = defense)) + 
  geom_col(fill = "#ff4500") +
  ggtitle("March Madness Teams by Defense") +
  labs(x = "Team", y = "Expected Points Against") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  coord_cartesian(ylim = c(80,130))

tempo_plot <-
  ggplot(team_table, aes(x = reorder(team, -tempo), y = tempo)) + 
  geom_col(fill = "#ff4500") +
  ggtitle("March Madness Teams by Tempo") +
  labs(x = "Team", y = "Tempo (Expected Possessions per 40 Minutes)") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  coord_cartesian(ylim = c(60,80))

luck_plot <-
  ggplot(team_table, aes(x = reorder(team, -luck), y = luck)) + 
  geom_col(fill = "#ff4500") +
  ggtitle("March Madness Teams by Luck") +
  labs(x = "Team", y = "Luck (Deviation Between Actual and Expected Record)") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

winrate_plot <-
  ggplot(team_table, aes(x = reorder(team, -winrate), y = winrate)) + 
  geom_col(fill = "#ff4500") +
  ggtitle("March Madness Teams by Winrate") +
  labs(x = "Team", y = "Winrate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

underseeded_plot <-
  team_table %>%
  mutate("seed_val" = seed * 4) %>%
  mutate("underseeded" = seed_val - rank) %>%
  ggplot(aes(x = reorder(team, -underseeded), y = underseeded)) + 
  geom_col(fill = "#ff4500") +
  ggtitle("March Madness Teams by Underseededness") +
  labs(x = "Team", y = "# of Places Underseeded") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

offense_defense <- melt(team_table[,c('team','offense_rank','defense_rank')],id.vars = 1)
offense_defense_plot <-
  ggplot(offense_defense, aes(x = team, y = 200 - value)) + 
  geom_bar(aes(fill = variable), stat = "identity", position = "dodge") +
  ggtitle("March Madness Teams by Offense and Defense") +
  labs(x = "Team", y = "Rank (inverted + 200)") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

unbalanced_plot <-
  team_table %>%
  mutate("unbalance" = offense_rank - defense_rank) %>%
  ggplot(aes(x = reorder(team, unbalance), y = unbalance)) +
  geom_col(fill = "#ff4500") +
  ggtitle("March Madness Teams by Unbalancedness (teams on the left have better 
          offense; teams on the right have better defense)") +
  labs(x = "Team", y = "Unbalancedness (diff between offense and defense rank)") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
