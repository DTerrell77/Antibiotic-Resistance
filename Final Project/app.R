## This is a Shiny web application created to show the amount of prescribed antibiotics
# per 1000 pop between 2011 and 2018 in the US 
#
# Authors: Dylan Terrell
# @keeperdjt77@att.net
# Cornell College, Mt.Vernon, IA

#Import Libraries 
library(shiny)
library(shinydashboard)
library(maps)
library(dplyr)
library(stringr)
library(ggplot2)

#Read in dataset
antibiotic_data <- read.csv("data/GeoAntibioYears.csv", as.is = TRUE)

# Define Map regions
west <- c("Washington", "Oregon", "California", "Nevada", "Idaho", "Utah", "Colorado", "Montana", "Wyoming", "Alaska", "Hawaii")
northeast <- c("Pennsylvania", "New York", "Delaware", "Maryland", "New Jersey", "Connecticut", "Rhode Island", "Massachusetts", "New Hampshire", "Vermont", "Maine")
southeast <- c("West Virginia", "Virginia", "North Carolina", "South Carolina", "Kentucky", "Florida", "Tennessee", "Arkansas", "Louisiana", "Alabama", "Mississippi", "Georgia")
midwest <- c("North Dakota", "South Dakota", "Nebraska", "Kansas", "Iowa", "Missouri", "Minnesota", "Wisconsin", "Michigan", "Illinois", "Indiana", "Ohio")
southwest <- c("Arizona", "New Mexico", "Texas", "Oklahoma")

# Create the UI for application to create the visualization
ui <- dashboardPage(skin = "purple",
                    dashboardHeader(title = "Antibiotic Resistance"),
                    dashboardSidebar(
                      # Create sidebar Menu for the visualization
                      sidebarMenu(
                        menuItem("Yearly Antibiotic Prescriptions/1000 Pop.", tabName = "antibioticPrescriptions")
                      )
                    ),              
                    
                    dashboardBody(
                      tabItems(
                        tabItem("antibioticPrescriptions",
                                fluidPage(
                                  
                                  # App title
                                  titlePanel("Yearly Antibiotic Class Prescriptions"),
                                  
                                  # Sidebar with a select input for choosing a year 
                                  sidebarLayout(
                                    sidebarPanel(
                                      # Select Year Variable
                                      selectInput("Year",
                                                  "Select Year: ",
                                                  choices = c(2011:2018)),
                                      # Select Antibiotic Class Variable
                                      selectInput("antibioticChoice",
                                                  "Select Antibiotic Class: ",
                                                  choices = c("Cephalosporins", "Fluoroquinolones", "Macrolides", "Penicillins")),
                                     
                                      # Select a region
                                      radioButtons("region",
                                                   "Region:",
                                                   choices = c("West", "Southwest", "Midwest", "Northeast", "Southeast", "Nationwide"),
                                                   selected = "Nationwide"),
                                      # Display text boxes
                                      textOutput("text1"),
                                      textOutput("text2"),
                                    
                                    ),
                                    
                                    # Show heatmaps
                                    mainPanel(
                                      plotOutput("heatMap"),
                                      
                                    )#mainPanel
                                  )#sidebarLayout
                                )#fluidPage
                        )#tabItem
                      )#tabItems
                    )#dashboardBody
)
#dashboardPage

#Define server logic required to draw a histogram
server <- function(input, output) {
  # Render the text for the textboxes on the pages
  output$text1 <- renderText("Updated:  9/4/2018")
  output$text2 <- renderText("Sources: Centers for Disease Control and Prevention-Antibiotic Use & Stewardship")

  
  #Heat map for yearly antibiotic class prescription/1000 Pop.
  output$heatMap <- renderPlot({
    # Read in "state" dataset
    MainStates <- map_data("state")
    
    #This condition displays the region that was selected by the user input
    #Ex: If the user input is west, then display the states that are in the west
    if(input$region == "West"){
      MainStates <- MainStates[which(MainStates$region %in% tolower(west)),]
    } else if(input$region == "Southwest"){
      MainStates <- MainStates[which(MainStates$region %in% tolower(southwest)),]
    } else if(input$region == "Midwest"){
      MainStates <- MainStates[which(MainStates$region %in% tolower(midwest)),]
    } else if(input$region == "Northeast"){
      MainStates <- MainStates[which(MainStates$region %in% tolower(northeast)),]
    } else if(input$region == "Southeast"){
      MainStates <- MainStates[which(MainStates$region %in% tolower(southeast)),]
    } 

  #Antibiotic Year Data
  #This condition displays the year that was selected by the user input
  #Ex: If the user selects 2015, then the condition will select 2015
  if(input$Year == 2011){
    YearData <- antibiotic_data[which(antibiotic_data$Year == 2011),]
  } else if(input$Year == 2012){
    YearData <- antibiotic_data[which(antibiotic_data$Year == 2012),]
  } else if(input$Year == 2013){
    YearData <- antibiotic_data[which(antibiotic_data$Year == 2013),]
  } else if(input$Year == 2014){
    YearData <- antibiotic_data[which(antibiotic_data$Year == 2014),]
  } else if(input$Year == 2015){
    YearData <- antibiotic_data[which(antibiotic_data$Year == 2015),]
  } else if(input$Year == 2016){
    YearData <- antibiotic_data[which(antibiotic_data$Year == 2016),]
  } else if(input$Year == 2017){
    YearData <- antibiotic_data[which(antibiotic_data$Year == 2017),]
  } else if(input$Year == 2018){
    YearData <- antibiotic_data[which(antibiotic_data$Year == 2018),]
    
  } 
  #Antibiotic Class Data
  #This condition allows the user to display the data for an Antibiotic Class only for 
  #the selected year
  #Ex: If the user selects Macrolides and the year is selected as 2016, then
  #it will only give data for Macrolides in 2016
  #Use "YearData$Antibiotic_Class" to retrieve data for all the Antibiotic classes in that year
  #that was selected
  if(input$antibioticChoice == "Cephalosporins"){
    finalData <- YearData[which(YearData$Antibiotic_Class == "Cephalosporins"),]
  } else if(input$antibioticChoice == "Fluoroquinolones"){
    finalData <- YearData[which(YearData$Antibiotic_Class == "Fluoroquinolones"),]
  } else if(input$antibioticChoice == "Macrolides"){
    finalData <- YearData[which(YearData$Antibiotic_Class == "Macrolides"),]
  } else if(input$antibioticChoice == "Penicillins"){
    finalData <- YearData[which(YearData$Antibiotic_Class == "Penicillins"),]
    
  }
  
  #Create a base map of the US using the "state" dataset
  g <- ggplot() + 
    geom_polygon(data=MainStates, aes(x=long, y=lat, group=group),
                 color="black", fill="red" )
  
  #Change all of the values in the region column to lowercase by using the 
  # tolower() command
  finalData$region <- tolower(finalData$region)
  
  #Merge the MainStates and finalData by "region"
  MergedAntibio_Data <- inner_join(MainStates, finalData, by = "region")
  
  #Create a US map of the MergedAntibio_Data and set fill to Prescriptions_per_1000_Population
  g <- ggplot()
  g <- g + geom_polygon( data=MergedAntibio_Data, 
                         aes(x=long, y=lat, group=group, fill = Prescriptions_per_1000_Population), 
                         color="white", size = 0.2) + 
   ggtitle("Antibiotic Prescriptions/1000 Pop.")
  g
  
  })

}
  
# Run the app 
shinyApp(ui = ui, server = server)





