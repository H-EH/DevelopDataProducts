library(shiny)
library(ggplot2)
## Simulation
simulate <- function(nInput, LInput, sInput, seedInput) {
   # variables
   set.seed(seedInput)
   # generate random data
   simulated_data <- matrix(rexp(sInput*nInput, rate=LInput), sInput, nInput)

   # generate averages of means of sample  
   meanValues <- rowMeans(simulated_data)

   # create a data frame of the simulated and theoraticalmean and variance values
   expdistribution <- data.frame(Mean=c(mean(rowMeans(simulated_data)), 1/LInput),
                              Variance=c(mean(apply(simulated_data, 1, var)), 1/LInput^2))
   rownames(expdistribution) <- c("Simulated", "Theoretical")

   # show the contents
   expdistribution
}

## Plot graph
plotSimGraph <- function(nInput, LInput, sInput, seedInput) {
   # variables
   set.seed(seedInput)
   # generate random data
   simulated_data <- matrix(rexp(sInput*nInput, rate=LInput), sInput, nInput)

   # generate averages of means of sample  
   meanValues <- rowMeans(simulated_data)

   # plot means distribution averages 
   hist(meanValues, breaks=50, prob=TRUE, 
        main="Averages Sample Means Distribution", xlab="") 
   # draw density of simulation averages
   lines(density(meanValues)) 
   # draw theoratical centre of normal distribution of 5% 
   abline(v=1/LInput, col="red") 
   # draw theoretical density of the averages of samples base on normal distribution 
   xfit <- seq(min(meanValues), max(meanValues), length=100) 
   yfit <- dnorm(xfit, mean=1/LInput, sd=(1/LInput/sqrt(nInput))) 
   lines(xfit, yfit, pch=22, col="red", lty=2) 
   # add legend 
   legend('bottomright', c("simulation", "theoretical"), lty=c(1,2), col=c("black", "red")) 
}
## End Simulation

shinyServer(function(input, output) {

## output for n, lambda and simulation values and graph plot
n <- reactive({as.numeric(input$nInput)})
output$nOutput <- renderText({n() })

L <- reactive({as.numeric(input$LInput)})
output$LOutput <- renderText({L() })

s <- reactive({as.numeric(input$sInput)})
output$sOutput <- renderText({s() })

seed <- reactive({as.numeric(input$seedInput)})
output$seedOutput <- renderText({seed() })

## simulation output
output$simResult <- renderPrint({simulate(input$nInput, input$LInput, input$sInput, input$seedInput)}) 
output$simGraph  <- renderPlot({plotSimGraph(input$nInput, input$LInput, input$sInput, input$seedInput)})
})

