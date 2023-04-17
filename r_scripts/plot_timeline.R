# Date: 2023-04-17
# Author: Gabriel Kamener
# Author email:gkamener@fiu.edu
# Organization:
# Florida Coastal Everglades LTER


# Load libraries
library(tidyverse)
library(ggrepel)
library(ggtext)

# Load data
input_data <- read_csv('data/eml_best_practices_intro_events.csv')

# Format data for plotting
prepare_for_plot <- input_data %>%
  mutate(Event_formatted = paste(Year, Event, sep = ": "))

# Create timeline plot
output <- ggplot(prepare_for_plot, aes(x = Year, y = 0, label = str_wrap(Event_formatted, width = 15))) +
  geom_point(size = 5, color = "blue") +
  geom_line(aes(group = 1), color = "blue", size = 1) +
  scale_x_continuous(limits = c(2002, 2024)) +
  theme_classic() +
  ggtitle("Timeline and Previous Revisions", ) +
  theme(plot.title = element_text(hjust = 0.5),
        axis.line.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.line.y = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.y = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        plot.margin = unit(c(1, 4, 1, 4), "cm")) +
  geom_text_repel(size = 4, hjust = 0.5, 
                  force = 0.5, # adjust the force to control the amount of repulsion
                  segment.color = "grey50",
                  direction = "y",
                  segment.alpha = 0.5,
                  vjust = ifelse(seq_along(input_data$Event) %% 2 == 0, 2, -2))

# Save plot to file
ggsave("plots/EML_event_timeline.png", width = 24.97, height = 15.21, unit = "cm", device = "png", limitsize = FALSE)