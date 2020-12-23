# Antibiotic Resistance

#Table of Contents
About The Project
Programs
Getting Started
Prerequisites
Future Work
License
Contact
About The Project

COVID-in-Prisons Website

We analyzed the effect of COVID-19 in the Correctional Facility system of the United States. While analyzing data provided by the UCLA COVID-19 Behind Bars Project we created several interactive Shiny apps in R to allow other users to explore the visualizations.

Built With
R programming
Shiny R
Carrd.co
Getting Started
To explore the visualizations navigate to: https://covid-in-prisons.shinyapps.io/COVID-in-Prisons/

Prerequisites
If you are interested in cloning the repository and exploring the data further you will need to make sure you install several packages.

install.packages("shiny")
install.packages("shinydashboard")
install.packages("maps")
install.packages("dplyr")
install.packages("stringr")
install.packages("ggplot2")
The main shiny dashboard application is under "final-dashboard" title "app.r". This file can be opened in Rstudio and run from the client as is.
Maps is not needed for running, but it was used to get the initial data. Dplyr and stringr are used for data manipulation. Shiny, shinydashboard, and ggplot2 are used for visualizations.
The Exploration.Rmd is a markdown file where we did our initial exploration of the data.

Future Work
Gather comprehensive data on all facility populations to use population based rates.
Perform regression analysis to see if state prison cases are different from general population cases.
Gather data over time for releases in facilities to see effectiveness of releasing inmates and preventing the spread of COVID-19.
Gather data for public vs. private prisons to see if our trends follow throughout the U.S.
License
Distributed under the MIT License. See LICENSE for more information.

Contact
Jakob Orel - jorel22@cornellcollege.edu
Danielle Amonica - damonica21@cornellcollege.edu
Kenna Ebert - kebert22@cornellcollege.edu
Jonathan Shilyansky - jshilyansky23@cornellcollege.edu

Project Link: https://github.com/jakoborel/COVID-in-Prisons