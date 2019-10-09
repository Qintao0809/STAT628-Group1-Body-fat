# This is the code of Body Fat Calculator created by Group 1 on Wedenesday Class

library(shiny)

# Define UI for application that calculator body fat
ui <- fluidPage(
  titlePanel("Body Fat Calculator"),
  sidebarPanel(
    selectInput("weight_unit", "Weight Unit:",
                c(pound = "lbs", kg = "kg")),
    numericInput("weight", "Weight:", value = 0),
    helpText("Please input a reasonable weight!"),
    selectInput("abdo_unit", "Abdomen Unit:",
                c(inch = "inch", cm = "cm")),
    numericInput("abdomen", label = "Abdomen:", value = 0),
    helpText("Please input a reasonable abdomen circumference!"),
    submitButton("Calculate")
  ),
  
  mainPanel(tabsetPanel(
    tabPanel("Your Body Fat",
             h4(textOutput("result")),
             tableOutput("standardtable")),
    tabPanel("A Self-image",
             h4(textOutput("description")),
             imageOutput("imageofbodyfat")),
    tabPanel("Rule of Thumb",
             h4(textOutput("formula1")),
             h4(textOutput("formula2"))),
    tabPanel("Contact us",
             h4("Contact us if there is a problem!"),
             h4("Fangfei Lin: fangfeilin123@gmail.com"),
             h4("Lu Chen: lchen487@wisc.edu"),
             h4("Yansong Mao: 763104241@qq.com"),
             h4("Qintao Ying: qying5@wisc.edu"))
  ))
)

server <- function(input, output){
  
  output$standardtable <- renderTable({
    data.frame(Percentage = c("2-5%","5-13%","13-17%","17-25%",">25%"),
               Description = c("Essential Fat", "Athletes","Fitness","Average","Obese"))
  })
  
  calculator <- reactive({
    if(input$weight_unit == "lbs"){
      weight <- input$weight
    } else {
      weight <- input$weight*2.2
    }
    if (input$abdo_unit == "inch"){
      abdo <- input$abdomen*2.54
    } else {
      abdo <- input$abdomen
    }
    result <- -0.12 * weight + 0.89 * abdo - 41.55
    return(c(weight, abdo, result))
  })
  
  bodyfat <- reactive({
    result <- calculator()[3]
    if(calculator()[1]<=0 || calculator()[1]>=1200){
      paste("Your weight is abnormal!")
    }
    else if(calculator()[2]<=0 || calculator()[2]>=300){
      paste("Your abdomen is abnormal!")
    }
    else if(result >= 25){
      paste("Body Fat Percentage: ", result, "%, Body State: Obese")
    }
    else if (result >= 17){
      paste("Body Fat Percentage: ", result, "%, Body State: Average")
    }
    else if (result >= 13){
      paste("Body Fat Percentage: ", result, "%, Body State: Fitness")
    }
    else if (result >= 5){
      paste("Body Fat Percentage: ", result, "%, Body State: Athletes")
    }
    else if(result >= 2){
      paste("Body Fat Percentage: ", result, "%, Body State: Essential Fat")
    } else {
      paste("Something wrong with your input because your body fat is smaller than 2%.")
    }
  })
  
  # Your Body Fat
  output$result <- renderText({
    bodyfat()
  })
  
  output$imageofbodyfat <- renderImage({
    if (calculator()[1]<=0 || calculator()[1]>=1200 || calculator()[2]<=0 || calculator()[2]>=300){
      picture <- normalizePath(file.path("/Users/qintaoying/Desktop/STAT 628/module_2/alien.jpg"))
    }
    else if(calculator()[3] >= 35){
      picture <- normalizePath(file.path("/Users/qintaoying/Desktop/STAT 628/module_2/35.png"))
    } 
    else if(calculator()[3] >= 30){
      picture <- normalizePath(file.path("/Users/qintaoying/Desktop/STAT 628/module_2/30.png"))
    } 
    else if(calculator()[3] >= 25){
      picture <- normalizePath(file.path("/Users/qintaoying/Desktop/STAT 628/module_2/25.png"))
    }
    else if(calculator()[3] >= 20){
      picture <- normalizePath(file.path("/Users/qintaoying/Desktop/STAT 628/module_2/20.png"))
    } 
    else if(calculator()[3] >= 15){
      picture <- normalizePath(file.path("/Users/qintaoying/Desktop/STAT 628/module_2/20.png"))
    }
    else if(calculator()[3] >= 10){
      picture <- normalizePath(file.path("/Users/qintaoying/Desktop/STAT 628/module_2/20.png"))
    } 
    else if(calculator()[3] >= 2){
      picture <- normalizePath(file.path("/Users/qintaoying/Desktop/STAT 628/module_2/20.png"))
    } else {
      picture <- normalizePath(file.path("/Users/qintaoying/Desktop/STAT 628/module_2/alien.jpg"))
    }
    
    list(src = picture, width = 200, height = 300)
  }, deleteFile = FALSE)

  finalformula1 <- reactive({
    paste("The formula we used in the web app is: ")
  })
  
  output$formula1 <- renderText({
    finalformula1()
  })
  
  finalformula2 <- reactive({
    paste("Body Fat(%) = ", 0.89, " * abdomen -", 0.12, " * weight - 41.55.")
  })
  
  output$formula2 <- renderText({
    finalformula2()
  })
  
  imageDescription <- reactive({
    paste("This is how you looks like:")
  })
  
  output$description <- renderText({
    imageDescription()
  })
}

# Run the application 
shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE))
