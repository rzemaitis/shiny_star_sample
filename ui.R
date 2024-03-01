library(shiny)
library(markdown)

ui <- fluidPage(
  
  fluidRow(
    
    column(5,align="center",selectInput("dataset", "Select Dataset",
                         choices = c("F8D1" = "f8d1.csv", "M81" = "m81.csv"),
                         selected = "f8d1.csv"),
           h3("Colour-Magnitude Diagram"),
           plotOutput("plot", brush = "plot_brush"),
    ),
    column(7,align="center",
           h3("Star Map"),
           plotOutput("plot2"),
           p("← Draw a box over the orange polygon in the colour-magnitude diagram and see the galaxies appear!"),
           p("For more information, please read the description below."),
           
           )
  ),
  includeMarkdown("description.md")
  
)