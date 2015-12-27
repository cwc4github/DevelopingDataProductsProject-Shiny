shinyUI(pageWithSidebar(
  headerPanel("Interactive Plot of the Father.son Data from the UsingR Package"),
  sidebarPanel(
    checkboxGroupInput('clm', "Add line(s)",
                       c("Linear Regression" = 1,
                         "Your Line" = 2)),
    
    "The following slides works only when the 'Your Line' box is checked" ,
    sliderInput('beta0', "Intercept at father's height = 67.5:",
                value = 68.58835, min = 55, max = 80, step = 0.01),
    sliderInput('beta1', 'Slope Value:',value = 0.5141, min = -10, max = 10, step = 0.01)
  ),
  mainPanel(
    plotOutput('myHist'),
    h4("How to use:"),
    paste("You may add/remove the linear regression and/or your own line(s) by", 
          "checking/unchecking the options at the side panel.", 
          "After adding, the line(s) will shown in the plot with its R squared value.",
          "The regression and your lines are colored in red and green, respectively.",
          "The values of intercept and slope of your line can be adjusted by the slide bars",
          "in the side panel.",
          "However, they only work when the 'Your Line' box is checked.",
          "A note that the intercept value corresponds to the son's height",
          "as father's height is 67.5 inches."),
    h4("Note:"),
    paste("It is worthwhile to note that a R squared value can be negative without", 
          "violating any rules of math because it is not a squared of anything",
          "A negative value of R squared simply means it is a wrong model to interpret the data")
    
  )
))