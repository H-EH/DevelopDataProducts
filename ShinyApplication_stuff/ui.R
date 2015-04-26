library(shiny)
library(datasets)
require(graphics)
shinyUI(fluidPage(
headerPanel( h4("Developing Data Product : Exponential Distribution Simulation") ),

# Setup the side bar panel for inputs and discription of the application
	sidebarPanel(
		h3('Simulation Inputs'),
		h6('This exercise investigates the distribution of averages of nth numbers sampled from the exponential 
		    distribution with lambda = L and x simulations. The simulation will use a fixed Seed to obtain 
			the distributed averages using lambda of L, generate the sample means distribution and compare it
			with the theoratical mean of the distribution.' ),
		p('Enter the details and click on the Submit button'),
		numericInput('nInput', label='nth number', 40, min=40, max=200),
		numericInput('LInput', label='lambda', 0.2, min=0.2, max=10),
		numericInput('sInput', label='number of simulations', 1000, min=100, max=2000),
		numericInput('seedInput', label='Seed number', 1234, min=100, max=5000),
        submitButton('Submit')
	), 
	
	# Main Panel for results
	mainPanel(
		h4("CLT simulation results", style="color:#ff6600"),
		h5("Parameters Entered :" ),
		h5("nth number :" ),
		verbatimTextOutput("nOutput"),
		h5("Lambda :" ),
		verbatimTextOutput("LOutput"),
		h5("Number of Simulations :" ),
		verbatimTextOutput("sOutput"),
  	    h5("Seed Set :" ),
		verbatimTextOutput("seedOutput"),
		h5("Simulated Result"),
		verbatimTextOutput("simResult"),
		h4("Plotting the graph"),
		plotOutput("simGraph")
	)
))
