<<<<<<< HEAD
server <- function(input, output) {
  
  #laod libraries
  # if (!require("pacman")) install.packages("pacman")
  # pacman::p_load(shiny, shinydashboard, curl, caret, tidyverse, plotly, dplyr, readxl, caret, caTools, mlbench, e1071, rsconnect, DT)
  
  if (!require("shiny")) install.packages("shiny")
  if (!require("shinydashboard")) install.packages("shinydashboard")
  if (!require("curl")) install.packages("curl")
  if (!require("caret")) install.packages("caret")
  if (!require("tidyverse")) install.packages("tidyverse")
  if (!require("plotly")) install.packages("plotly")
  if (!require("dplyr")) install.packages("dplyr")
  if (!require("readxl")) install.packages("readxl")
  if (!require("caret")) install.packages("caret")
  if (!require("caTools")) install.packages("caTools")
  if (!require("mlbench")) install.packages("mlbench")
  if (!require("rsconnect")) install.packages("rsconnect")
  if (!require("e1071")) install.packages("e1071")
  if (!require("ranger")) install.packages("ranger")
  if (!require("DT")) install.packages("DT")
  
  
  
  
  require(shiny)
  require(shinydashboard)
  require(curl)
  require(caret)
  require(tidyverse)
  require(plotly)
  require(dplyr)
  require(readxl)
  require(caret)
  require(caTools)
  require(mlbench)
  require(rsconnect)
  require(e1071)
  require(ranger)
  require(DT)
  
  
  # load data
  
  supermodel <- readRDS("./modelTable.rds")
  supercluster <- readRDS("./scoredTable.rds")
  
  
  #initialization
  
  # moderate_cluster <- 7
  # ambitious_cluster <- 6
  # safe_cluster <- 8
  
  # *Important Pre-model Reference
  # vals_factors <-  "avg_gre_q+avg_gre_v+avg_gpa"
  # initialize Input DF
  
  applicant_input_information <- reactiveValues()
  applicant_input_information$df <- data.frame(avg_gre_q = numeric(0), 
                                               avg_gre_v = numeric(0),
                                               avg_gpa = numeric(0),
                                               stringsAsFactors = FALSE)
  
  # schoolRecommendations <- reactiveValues()
  # schoolRecommendations <- data.frame(`Moderate Schools` = character(),
  #     `Safe Schools` = character(),
  #     `Ambitious Schools` = character(),
  #     stringsAsFactors = FALSE
  #     )
  
  
  
  # Create reactive data frame
  # With the function reactive(), define moderate_cluster: a reactive expression that is a data frame with the selected variables (input$selected_var).
  
  model<- reactive({
    req(input$targetDiscipline)
    model <- eval(parse(text = paste0("supermodel$",input$targetDiscipline)))
    return(model)
  })
  
  scored_table <- reactive({
    req(input$targetDiscipline)
    scored_table <- eval(parse(text = paste0("supercluster$",input$targetDiscipline)))
    return(scored_table)
  })
  
  # Predict 
  # moderate_cluster <- as.integer(predict(model, applicant_input_information))
  schoolRecommendations <- reactive({
    req(input$gre_q, input$gre_v, input$gpa, input$targetDiscipline)
    model <- eval(parse(text = paste0("supermodel$",input$targetDiscipline)))
    scored_table <- eval(parse(text = paste0("supercluster$",input$targetDiscipline)))
    
    applicant_input_information$df <- data.frame(stringsAsFactors = FALSE,
                                                 avg_gre_q = as.numeric(input$gre_q),
                                                 avg_gre_v = as.numeric(input$gre_v),
                                                 avg_gpa = as.numeric(input$gpa)
    )
    moderate_cluster <- as.integer(predict(model, applicant_input_information$df))
    ambitious_cluster <- moderate_cluster -1 
    safe_cluster <- moderate_cluster+1
    
    
    #Calculate Student Score
    testCol <- 30*dnorm(applicant_input_information$df$avg_gre_q, mean = scored_table$avg_gre_q, sd = 5) + 10*dnorm(applicant_input_information$df$avg_gre_v, mean = scored_table$avg_gre_v, sd = 12) + 30*dnorm(applicant_input_information$df$avg_gpa, mean = scored_table$avg_gpa, sd = 0.4)
    scored_table$Student_Score <- testCol 
    
    # ("Moderate Schools")
    moderateSchools <- scored_table %>% filter(as.factor(moderate_cluster) == rankCluster) %>% arrange(desc(Student_Score)) %>% select(University, Student_Score)
    moderateSchoolRecommendations <- top_n(x = moderateSchools, n =3)
    #Safe
    safeSchools <- scored_table %>% filter(as.factor(safe_cluster) == rankCluster) %>% arrange(desc(Student_Score)) %>% select(University, Student_Score) 
    safeSchoolRecommendations <- top_n(x = safeSchools, n =3)
    #Ambitious
    ambitiousSchools <- scored_table %>% filter(as.factor(ambitious_cluster) == rankCluster) %>% arrange(desc(Student_Score)) %>% select(University, Student_Score)
    ambitiousSchoolRecommendations <- top_n(x = ambitiousSchools, n =3)
    
    
    # return(moderateSchoolRecommendations)
    schoolRecommendations <- as_tibble(cbind("Moderate Schools" = moderateSchoolRecommendations$University,
                                             "Safe Schools" = safeSchoolRecommendations$University,
                                             "Ambitious Schools" = ambitiousSchoolRecommendations$University))
    
    return(schoolRecommendations)
  })
  
  
  
  # Output Functions
  output$scatterplotly <- renderPlotly({
    plot_ly(data=scored_table(), x = ~Program_Score, y= ~avg_gre_q,
            type= 'scatter', mode = 'markers', color = ~rankCluster,
            text = ~University,
            hoverinfo = 'text',
            showlegend = F)
  })
  
  output$applicantInputInformation <- renderText(input$gre_q)
  output$target_Discipline <- renderText(input$targetDiscipline)
  
  
  output$recommendedSchoolsTable <- renderDataTable({
    DT::datatable(data = schoolRecommendations())
  })
  
  
=======
server <- function(input, output) {
  
  #laod libraries
  # if (!require("pacman")) install.packages("pacman")
  # pacman::p_load(shiny, shinydashboard, curl, caret, tidyverse, plotly, dplyr, readxl, caret, caTools, mlbench, e1071, rsconnect, DT)
  
  if (!require("shiny")) install.packages("shiny")
  if (!require("shinydashboard")) install.packages("shinydashboard")
  if (!require("curl")) install.packages("curl")
  if (!require("caret")) install.packages("caret")
  if (!require("tidyverse")) install.packages("tidyverse")
  if (!require("plotly")) install.packages("plotly")
  if (!require("dplyr")) install.packages("dplyr")
  if (!require("readxl")) install.packages("readxl")
  if (!require("caret")) install.packages("caret")
  if (!require("caTools")) install.packages("caTools")
  if (!require("mlbench")) install.packages("mlbench")
  if (!require("rsconnect")) install.packages("rsconnect")
  if (!require("e1071")) install.packages("e1071")
  if (!require("ranger")) install.packages("ranger")
  if (!require("DT")) install.packages("DT")
  
  
  
  
  require(shiny)
  require(shinydashboard)
  require(curl)
  require(caret)
  require(tidyverse)
  require(plotly)
  require(dplyr)
  require(readxl)
  require(caret)
  require(caTools)
  require(mlbench)
  require(rsconnect)
  require(e1071)
  require(ranger)
  require(DT)
  
  
  # load data
  
  supermodel <- readRDS("./modelTable.rds")
  supercluster <- readRDS("./scoredTable.rds")
  
  
  #initialization
  
  # moderate_cluster <- 7
  # ambitious_cluster <- 6
  # safe_cluster <- 8
  
  # *Important Pre-model Reference
  # vals_factors <-  "avg_gre_q+avg_gre_v+avg_gpa"
  # initialize Input DF
  
  applicant_input_information <- reactiveValues()
  applicant_input_information$df <- data.frame(avg_gre_q = numeric(0), 
                                               avg_gre_v = numeric(0),
                                               avg_gpa = numeric(0),
                                               stringsAsFactors = FALSE)
  
  # schoolRecommendations <- reactiveValues()
  # schoolRecommendations <- data.frame(`Moderate Schools` = character(),
  #     `Safe Schools` = character(),
  #     `Ambitious Schools` = character(),
  #     stringsAsFactors = FALSE
  #     )
  
  
  
  # Create reactive data frame
  # With the function reactive(), define moderate_cluster: a reactive expression that is a data frame with the selected variables (input$selected_var).
  
  model<- reactive({
    req(input$targetDiscipline)
    model <- eval(parse(text = paste0("supermodel$",input$targetDiscipline)))
    return(model)
  })
  
  scored_table <- reactive({
    req(input$targetDiscipline)
    scored_table <- eval(parse(text = paste0("supercluster$",input$targetDiscipline)))
    return(scored_table)
  })
  
  # Predict 
  # moderate_cluster <- as.integer(predict(model, applicant_input_information))
  schoolRecommendations <- reactive({
    req(input$gre_q, input$gre_v, input$gpa, input$targetDiscipline)
    model <- eval(parse(text = paste0("supermodel$",input$targetDiscipline)))
    scored_table <- eval(parse(text = paste0("supercluster$",input$targetDiscipline)))
    
    applicant_input_information$df <- data.frame(stringsAsFactors = FALSE,
                                                 avg_gre_q = as.numeric(input$gre_q),
                                                 avg_gre_v = as.numeric(input$gre_v),
                                                 avg_gpa = as.numeric(input$gpa)
    )
    moderate_cluster <- as.integer(predict(model, applicant_input_information$df))
    ambitious_cluster <- moderate_cluster -1 
    safe_cluster <- moderate_cluster+1
    
    
    #Calculate Student Score
    testCol <- 30*dnorm(applicant_input_information$df$avg_gre_q, mean = scored_table$avg_gre_q, sd = 5) + 10*dnorm(applicant_input_information$df$avg_gre_v, mean = scored_table$avg_gre_v, sd = 12) + 30*dnorm(applicant_input_information$df$avg_gpa, mean = scored_table$avg_gpa, sd = 0.4)
    scored_table$Student_Score <- testCol 
    
    # ("Moderate Schools")
    moderateSchools <- scored_table %>% filter(as.factor(moderate_cluster) == rankCluster) %>% arrange(desc(Student_Score)) %>% select(University, Student_Score)
    moderateSchoolRecommendations <- top_n(x = moderateSchools, n =3)
    #Safe
    safeSchools <- scored_table %>% filter(as.factor(safe_cluster) == rankCluster) %>% arrange(desc(Student_Score)) %>% select(University, Student_Score) 
    safeSchoolRecommendations <- top_n(x = safeSchools, n =3)
    #Ambitious
    ambitiousSchools <- scored_table %>% filter(as.factor(ambitious_cluster) == rankCluster) %>% arrange(desc(Student_Score)) %>% select(University, Student_Score)
    ambitiousSchoolRecommendations <- top_n(x = ambitiousSchools, n =3)
    
    
    # return(moderateSchoolRecommendations)
    schoolRecommendations <- as_tibble(cbind("Moderate Schools" = moderateSchoolRecommendations$University,
                                             "Safe Schools" = safeSchoolRecommendations$University,
                                             "Ambitious Schools" = ambitiousSchoolRecommendations$University))
    
    return(schoolRecommendations)
  })
  
  
  
  # Output Functions
  output$scatterplotly <- renderPlotly({
    plot_ly(data=scored_table(), x = ~Program_Score, y= ~avg_gre_q,
            type= 'scatter', mode = 'markers', color = ~rankCluster,
            text = ~University,
            hoverinfo = 'text',
            showlegend = F)
  })
  
  output$applicantInputInformation <- renderText(input$gre_q)
  output$target_Discipline <- renderText(input$targetDiscipline)
  
  
  output$recommendedSchoolsTable <- renderDataTable({
    DT::datatable(data = schoolRecommendations())
  })
  
  
>>>>>>> 454dc41ccb26114504e261e228862ee57ff9c169
}