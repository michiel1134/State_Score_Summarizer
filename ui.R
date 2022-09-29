#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(tidyverse)
library(ggplot2)
df = fread("State Score Summaries.csv")
df$Group = str_sub(df$Group,5,-1)
colnames(df) = str_replace(colnames(df), "nmean", "mean")
shinyUI(fluidPage(

    # Application title
    titlePanel(h2("State Model Score by Key Demographics",  style = "color:blue;")),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("state",
                        h4("State", style = "color:blue;"),
                        choices = unique(df$State)),
            br(),
            selectInput("score",
                        h4("Scores", style = "color:blue;"),
                        choices = c("Intent to Enroll Score",
                                    "Community College Score",
                                    "University Score",
                                    "Vocational or Technical School Score",
                                    "Hybrid Education Score", 
                                    "All Online Education Score",
                                    "Intent to Seek New Job Score"),
                        ) 
        ),
        # Show a plot of the generated distribution
        mainPanel(
            tableOutput("df_selected")
        ))
))
