library(shiny)
library(samplingbook)
library(rclipboard)

ui <- fluidPage(rclipboardSetup(),
  titlePanel("Comprehensive Sample Size Calculator"),
  tabsetPanel(tabPanel("Single Mean",
  numericInput("ME","Margin of error",0.05),numericInput("SD","Standard Deviation",0.681),
  numericInput("POP","Population",6868),numericInput("CI","Confidence Intervals",0.95),
  actionButton("Cal","Calculate"),textOutput("result"),uiOutput("copy")
),tabPanel("Soon!")))

server <- function(input, output, session) {
  res <- eventReactive(input$Cal,{
    sample.size.mean(input$ME,input$SD,input$POP,input$CI)[["n"]]
  })
  
  output$result <- renderText({
  paste("Sample size is ",res())
})
  output$copy <- renderUI({
    rclipButton("any","",res(),icon = icon("clipboard"))
  })
}

shinyApp(ui = ui, server = server)