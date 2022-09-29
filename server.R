#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(dplyr) 
library(tidyverse)
library(ggplot2)
df = fread("State Score Summaries.csv")
df$Group = str_sub(df$Group,5,-1)
colnames(df) = str_replace(colnames(df), "nmean", "mean")

# Define server logic required to draw a histogram
shinyServer <- function(input, output) {
  output$df_selected = renderTable({
    df %>% filter(State == input$state) %>% 
              dplyr::select(Group, n, 
              all_of(c(paste0(str_replace_all(input$score, " ", "."),"_mean"),
              paste0(str_replace_all(input$score, " ", "."),"_sd"))))
  })
  }



