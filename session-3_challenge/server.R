

server = function(input, output) {

  output$img_size = renderPrint({ paste0("Image size: ", input$slider1) })
  img_height = reactive({ input$slider1 })
  
  selectedImage = reactive({
    print(input$select)
    input$select #reactive value
  })

  output$image = renderUI({
    # img(src = selectedImage(), height = 500) #observer })
    if( !grepl("NA", selectedImage()) ) {
      img(src = selectedImage(), height = img_height()) #observer })
    }
  })

  output$value = renderPrint({ paste0("File: ", input$select) })

}


