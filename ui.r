if (!require("shiny")) install.packages("shiny")
if (!require("shinydashboard")) install.packages("shinydashboard")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("plotly")) install.packages("plotly")
if (!require("ggplot2")) install.packages("ggplot2")


require(shiny)
require(ggplot2)
require(shinydashboard)
require(tidyverse)
require(plotly)


# Define UI for application 
ui<- fluidPage(
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    #Inputs 
    sidebarPanel(
      
      fluidRow(
        sliderInput(inputId = "gre_q", 
                    label = "GRE Quant", 
                    min = 130, max = 170, 
                    value = 150,
                    round = TRUE),
        sliderInput("gre_v","GREVerbal",130,170,150,round = TRUE)
      ),
      fluidRow(     
        sliderInput("toefl","ToEFL",80,120,100, round = TRUE),
        sliderInput("gpa","GPA",min = 2.5, max = 4, value = 3, round = -1)
      ),
      fluidRow(
        #Select Variable for Incoming Discipline
        selectInput(inputId = "incomingDiscipline", 
                    label = "Incoming Discipline", 
                    choices = c("Aerospace & Aeronautical"="Aerospace_Aeronautical",
                                "Biomedical / Bioengineering"="Biomedical_Bioengineering",
                                "Chemical"="Chemical",
                                "Civil"="Civil",
                                "Computer"="Computer",
                                "Electrical / Electronic / Communication" = "Electrical_Electronic_Communication",
                                "Environmental / Health"="Environmental_Health",
                                "Industrial / Manufacturing"="Industrial_Manufacturing",
                                "Materials"="Materials",
                                "Mechanical"="Mechanical",
                                "Petroleum"="Petroleum",
                                "Nuclear"="Nuclear",
                                "Computer Science"="ComputerScience",
                                "Artificial Intelligence"="ArtificialIntelligence",
                                "Programming Language"="ProgrammingLanguage",
                                "Systems"="Systems",
                                "Theory"="Theory",
                                "Statistics"="Statistics"),
                    selected = "Computer"
        ),
        #Select Variable for Taget Discipline
        
        selectInput(inputId = "targetDiscipline",
                    label = "Target Discipline",
                    choices = c("Aerospace & Aeronautical"="Aerospace_Aeronautical",
                                "Biomedical / Bioengineering"="Biomedical_Bioengineering",
                                "Chemical"="Chemical",
                                "Civil"="Civil",
                                "Computer"="Computer",
                                "Electrical / Electronic / Communication"="Electrical_Electronic_Communication",
                                "Environmental / Health"="Environmental_Health",
                                "Industrial / Manufacturing"="Industrial_Manufacturing",
                                "Materials"="Materials",
                                "Mechanical"="Mechanical",
                                "Petroleum"="Petroleum",
                                "Nuclear"="Nuclear",
                                "Computer Science"="ComputerScience",
                                "Artificial Intelligence"="ArtificialIntelligence",
                                "Programming Language"="ProgrammingLanguage",
                                "Systems"="Systems",
                                "Theory"="Theory",
                                "Statistics"="Statistics"),
                    selected = "Computer"
        )
      ),
      fluidRow(
        box(submitButton(#id = "sync",
          text = "Synchronize" , 
          icon = icon("sync")))
      ),
      fluidRow(
        
        
      )
    ),
    
    
    #Output
    mainPanel(
      fluidRow(
        #Applicant Data
        textOutput(outputId = "applicantInputInformation" )
      ),
      fluidRow(
        #Applicant Data
        textOutput(outputId = "target_Discipline" )
      ),
      #targetDiscipline
      fluidRow(
        plotlyOutput("scatterplotly")
      ),
      fluidRow(
        DT::dataTableOutput(outputId = "recommendedSchoolsTable")
      ),
      fluidRow(
        tableOutput("safeSchools")
      ),
      fluidRow(
        tableOutput("ambitiousSchools")
      )
    )
    
  ))
