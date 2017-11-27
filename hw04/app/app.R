library(shiny)
library(ggvis)
library(dplyr)

dat$Grades <- factor(dat$Grade, 
                    levels = c('A+', 'A', 'A-','B+','B', 
                               'B-','C+', 'C', 'C-', 'D', 'F'))
lines <- c("None", "Lm", "Loess")
col_names <- c("HW1", "HW2", "HW3", "HW4", "HW5", "HW6", "HW7","HW8", "HW9",
                  "ATT", "QZ1", "QZ2", "QZ3", "QZ4", "EX1","EX2", "Test1",
                  "Test2", "Lab", "Homework", "Quiz","Overall")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application Title
  titlePanel("Grade Visualizer"),
  
  # Sidebar with different widgets depending on the selected tab
  sidebarLayout(
    sidebarPanel(
      
      conditionalPanel(condition = "input.tabselected==1",
                      h3("Grades Distribution"), tableOutput("freq_chart")),
      
      conditionalPanel(condition = "input.tabselected==2",
                       selectizeInput('assignment', 'X-axis variable', vector, 
                                      'HW1'),
                       sliderInput('bins', 'Bin Width', min = 1, max = 10, value = 10)),
      
      conditionalPanel(condition = "input.tabselected == 3",
                       selectInput('x', 'X-axis variable', col_names, 'Test1'),
                       selectizeInput('y', 'Y-axis variable', col_names, 'Overall'),
                       sliderInput('opacity', 'Opacity', min = 0, max = 1, value = 0.5),
                       radioButtons('lines', 'Show line', lines, selected = "None"))
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Barchart", value=1,
                           ggvisOutput("barchart")),
                  tabPanel("Histogram", value=2,
                           ggvisOutput("histogram"),
                           h4("Summary Stats"),
                           verbatimTextOutput("summary")),
                  tabPanel("Scatterplot",value=3,
                           ggvisOutput("scatterplot"),
                           h4("Correlation"),
                           verbatimTextOutput("Correlation")),
                  id="tabselected")
    )
  )
)
# Define server logic required to draw a Histogram
server <- function(input, output) {
  #Barchart
  vis_barchart <-  ggvis(dat, ~factor(Grades), fill := "lightblue") %>% 
    add_axis("x", title = "Grade") %>%                              
    add_axis("y", title = "Frequency")                              
  vis_barchart %>% bind_shiny("barchart")
  output$table <- renderTable(Grades)
  
  
  
  
  #Histogram
  vis_histogram <-reactive({
    var2 <- prop("x",as.symbol(input$var2))
    dat %>% 
      ggvis(x = var2, fill :="orange",opacity :=0.4) %>%
      layer_histograms(stroke := 'white',
                       width = input$bins)
  })
  vis_histogram %>% bind_shiny("histogram")
  output$summary <- renderPrint({
    helper <- select(dat, input$var2)
    print_stats(summary_stats(col))
})
  
  #Scatterplot
  vis_scatterplot <- reactive ({
    var3 <- prop("x",as.symbol(input$var3))
    var4 <- prop("y",as.symbol(input$var4))
    if (input$lines == "Lm"){
      dat %>% 
        ggvis(x = var3, y = var4, fill := "000000", opacity := input$var5) %>% 
        layer_points() %>%
        layer_model_predictions(model = "lm", se = TRUE)
      
    }
    else if (input$var6 == "Loess")
    {
      dat %>% 
        ggvis(x = var3, y = var4, fill := "000000", opacity := input$var5) %>% 
        layer_points() %>%
        layer_model_predictions(model = "loess", se = TRUE)
    }
    else
    {
      dat %>% 
        ggvis(x = var3, y = var4, fill := "000000", opacity := input$var5) %>% 
        layer_points()
    }
  })
  
  vis_scatterplot %>% bind_shiny("scatterplot")
  output$Correlation <- renderText(
    cor(dat[,input$var3], dat[, input$var4])
    )
}
    

#Run the App
shinyApp(ui = ui, server = server)