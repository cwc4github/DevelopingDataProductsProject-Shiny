library(UsingR)
data(father.son)

reg <- lm(sheight ~ fheight, data=father.son)

shinyServer(
  function(input, output) {
    output$myHist <- renderPlot({
      maintitle <- "Data of Father and Son Heights"
      if (!is.null(input$clm)) {
        if (length(input$clm) == 2) {
          maintitle <- "Compare Linear Regression and Your Line on the Data of Father and Son Heights"
        } else if (input$clm[1] == 1) {
          maintitle <- "Data of Father and Son Heights with Linear Regression"
        } else if (input$clm[1] == 2) {
          maintitle <- "Data of Father and Son Heights with Your Line"
        }
      }

      youpredit <- input$beta0 + input$beta1 * (father.son$fheight - 67.5)
      sonmean <- mean(father.son$sheight)
      yourR2 <- 1 - sum( (father.son$sheight - youpredit)^2 ) / sum( (father.son$sheight - sonmean)^2 ) 
      abInte <- input$beta0 - input$beta1 * 67.5
      
      plot(father.son$fheight, father.son$sheight, xlab = "Father's height in inches", 
           ylab = "Son's height in inches", main = maintitle, col = "blue",
           xlim = c(55, 80), ylim = c(55, 80))
      if (!is.null(input$clm)) {
        if (length(input$clm) == 2) {
          abline(reg, col = "red", lwd = 2)
          abline(a = abInte, b = input$beta1, col = "green", lwd = 2, lty = 2)
          legend("topleft", c(paste("Lear fit with R^2 = ", round(summary(reg)$r.squared, 4)), 
                              paste("Your Line with R^2 = ", round(yourR2, 4))),
                 lty = c(1, 2), lwd=c(2, 2), col=c("red", "green") )

        } else if (input$clm[1] == 1) {
          abline(reg, col = "red", lwd = 2)
          legend("topleft", c(paste("Lear fit with R^2 = ", round(summary(reg)$r.squared, 4))),
                 lty = c(1), lwd=c(2), col=c("red") )
        } else if (input$clm[1] == 2) {
          abline(a = abInte, b = input$beta1, col = "green", lwd = 2, lty = 2)
          legend("topleft", c(paste("Your Line with R^2 = ", round(yourR2, 4))),
                 lty = c(2), lwd=c(2), col=c("green") )
        }
      }


      
#      hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
#      mu <- input$mu
#      lines(c(mu, mu), c(0, 200),col="red",lwd=5)
#      mse <- mean((galton$child - mu)^2)
#      text(63, 150, paste("mu = ", mu))
#      text(63, 140, paste("MSE = ", round(mse, 2)))
    })
    
  }
)