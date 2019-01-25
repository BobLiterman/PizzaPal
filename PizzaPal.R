library(shiny)

#Pizza pricing and topping data from https://www.kingstonpizza.com/our-menu accessed on 01/25/2019

sizes <- c('Small','Small (Gluten-Free)','Large','Extra Large','Sheet')
areas <- c('79','79','154','254','187')
basePrices <- c(6.99,9.24,10.99,15.99,15.99)
toppingCost <- c(1.25,1.25,2,3,3)

priceTable <- data.frame(Size=as.character(sizes),
                         Area=as.integer(areas),
                         BasePrice=as.numeric(basePrices),
                         ToppingCost=as.numeric(toppingCost))

addOns <- c('Thick Crust','Extra Cheese','Pepperoni',
            'Black Olives','Sausage','Green Peppers',
            'Meatball','Hot Peppers','Onion','Garlic',
            'Eggplant','Tomato','Mushroom','Spinach',
            'Broccoli','Anchovy','Jalapeno','Chicken',
            'Pineapple','Artichoke','Bacon','Ham',
            'Ricotta','Gorgonzola','Provolone','Alfredo',
            'Feta','Pesto','Roasted Red Peppers','Grilled Chicken')

addOnVar <- c('thickCrust','extraCheese','pepperoni',
            'blackOlives','sausage','greenPeppers',
            'meatball','hotPeppers','onion','garlic',
            'eggplant','tomato','mushroom','spinach',
            'broccoli','anchovy','jalapeno','chicken',
            'pineapple','artichoke','bacon','ham',
            'ricotta','gorgonzola','provolone','alfredo',
            'feta','pesto','roastedRedPeppers','grilledChicken')

toppingOrder <- data.frame(Number=as.integer(1:30),Topping=as.character(addOns),ToppingAbrev = as.character(addOnVar))

choices <- c("Won't Eat!","Okay","Really Like!")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Pizza Pal App"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(width=10,
      column(1,width=1,sliderInput("bins","Number of bins:",min = 1,max = 50,value = 30)),
      column("Most Popular",width=2,offset=1,
             selectInput('pepperoni','Pepperoni', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('mushroom','Mushroom', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('onion','Onion', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('sausage','Sausage', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('bacon','Bacon',choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('extraCheese','Extra Cheese', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('blackOlives','Black Olives', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('greenPeppers','Green Peppers', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('pineapple','Pineapple',choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('spinach','Spinach', choices = choices,selectize = FALSE,selected="Won't Eat!")),
      column("Veggies and Fruits",width=2,offset=1,
             selectInput('hotPeppers','Hot Peppers', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('garlic','Garlic', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('tomato','Tomato', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('broccoli','Broccoli', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('artichoke','Artichoke',choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('roastedRedPeppers','Roasted Red Peppers', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('jalapeno','Jalapeno',choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('pesto','Pesto', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('eggplant','Eggplant', choices = choices,selectize = FALSE,selected="Won't Eat!")),
      column("Other",offset=1,width=2,
             selectInput('meatball','Meatball', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('anchovy','Anchovies', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('chicken','Chicken',choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('ham','Ham', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('ricotta','Ricotta', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('gorgonzola', 'Gorgonzola',choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('provolone', 'Provolone',choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('alfredo','Alfredo', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('feta', 'Feta',choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('thickCrust','Thick Crust', choices = choices,selectize = FALSE,selected="Won't Eat!"),
             selectInput('grilledChicken','Grilled Chicken', choices = choices,selectize = FALSE,selected="Won't Eat!"))),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)
# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

