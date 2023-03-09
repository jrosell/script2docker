
# Preparations ----


rlang::check_installed("here")
rlang::check_installed("readr")
rlang::check_installed("dplyr")
rlang::check_installed("ggplot2")
rlang::check_installed("forcats")
library(readr)
library(dplyr)
library(ggplot2)
library(forcats)
print(sessionInfo())

if (!dir.exists(here::here("data"))) dir.create(here::here("data"))
if (!dir.exists(here::here("output"))) dir.create(here::here("output"))


# Download ----

utils::download.file("https://www.briandunning.com/sample-data/us-500.zip", destfile = here::here("data", "us-500.zip"))
utils::unzip("data/us-500.zip", exdir = here::here("data"))
file.remove(here::here("data", "us-500.zip"))


# Create the plot ----

df <- read_csv(here::here("data", "us-500.csv"), show_col_types = FALSE)

plot_data <- df %>%
    group_by(state) %>%
    count()

write_csv(plot_data, here::here("output", "plot_data.csv"))
print("Plot data saved")

plot <- plot_data %>%
    ggplot() +
    geom_col(aes(fct_reorder(state, n),
        n,
        fill = n)) +
    coord_flip() +
    labs(
        title = "Number of people by state",
        subtitle = "From US-500 dataset",
        x = "State",
        y = "Number of people"
    ) +
    theme_bw()

ggsave(here::here("output", "myplot.png"), width = 10, height = 8, dpi = 100)
print("Plot visualization saved")
