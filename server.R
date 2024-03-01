library(shiny)
library(ggplot2)

# Define custom ggplot theme
my_theme <- function() {
  theme_bw() +  # You can start with an existing theme and customize it
    theme(
      axis.title = element_text(face = "bold",size=rel(1.2)),
      plot.title = element_text(face = "bold", size = 16),
      panel.grid.major = element_blank(),  # Remove major grid lines
      panel.grid.minor = element_blank(),  # Remove minor grid lines
      axis.ticks.length=unit(-0.15, "cm"),  # Add inward facing ticks
    )
}


server <- function(input, output, session) {
  
  # Read CSV file
  data <- reactive({
    read.csv(input$dataset, header = TRUE)
  })
  
  # Plot the CMD
  output$plot <- renderPlot({
    ggplot(data(), aes(gi, imag)) + 
      # geom_point()+
      geom_bin2d(binwidth = c(0.1, 0.1))+
      
      geom_polygon(data = data.frame(x = c(0.93, 1.4 , 2.25, 1.55), y = c(25.533, 24.183, 24.183, 25.533)),
                   aes(x = x, y = y, alpha = 0,colour="red"))+
      scale_fill_continuous(type = "viridis") +
      coord_cartesian(ylim=c(26.8, 22),xlim=c(-1.5, 3)) +
      my_theme()+ #Apply the custom theme
      theme(legend.position='none')+
      theme(aspect.ratio=1.5)+
      labs(y= expression(i["0"]), x = expression((g-i)["0"]))
  }, res = 96)
  
  # Plot the spatial map 
  output$plot2 <- renderPlot({
    ggplot(sel_data(), aes(xi, eta)) + geom_point(size=0.5) +
      my_theme()+ #Apply the custom theme
      scale_x_reverse()+
      theme(aspect.ratio=1)+
    labs(y= expression(eta~(deg)), x = expression(xi~(deg)))
  }, res = 96) 
  
  # Select points from drawn polygon on the CMD
  sel_data <- reactive( {
    if (!is.null(input$plot_brush)) {
      return(brushedPoints(data(), input$plot_brush))
    }
    else{
      return(data())
    }
    
    
  })
  
  
}