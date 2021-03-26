fluidPage(
  
  # Application title
  titlePanel("Device Surge"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "state", 
                  label   = "State:",
                  choices = sort(states$state_name),
                  selected = 'Illinois'),
      uiOutput('stateCounty'),
      selectInput(inputId = 'date',
                  label   = 'Date:',
                  choices = seq(ymd('2020-05-25'), ymd('2020-06-06'), by = 1)),
      selectInput(inputId = 'surgeLookback',
                  label   = 'Surge Lookback (Weeks):',
                  choices = 4:1)
    ),
    mainPanel(

      plotOutput(outputId = "countyMap")
      
    )
  )
)