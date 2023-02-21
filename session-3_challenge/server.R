

server <- function(input, output) {

  output$img_size <- renderPrint({ paste0("Image size: ", input$slider1) })
  img_height <- reactive({ input$slider1 })
  
  selectedImage <- reactive({
    input$select #reactive value
  })

  output$image <- renderUI({
    # img(src = selectedImage(), height = 500) #observer })
    img(src = selectedImage(), height = img_height()) #observer })
  })

  output$value <- renderPrint({ paste0("file: ", input$select) })

}


