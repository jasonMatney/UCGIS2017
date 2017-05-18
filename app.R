options(rgl.useNULL=TRUE)
library(shiny)
library(shinyRGL)
library(rgl)
library("rlas")
library(rgl)
library(colorspace)
#setwd("/Users/jason/Desktop/UCGIS2017/project/UIUC")
#list.files()
#temp = list.files(pattern="*.las")
#las.files = lapply(temp, readlasdata)
lidar <- readlasdata("10121248.las")
# # 3d plot.
nbcol = 100
color = rev(rainbow(nbcol, start = 0/6, end = 4/6))
n <- 200
zcol  = with(lidar, cut(Z, nbcol))
# open3d()
# for (i in 1:6) {
#   zcol  = with(las.files[[1]], cut(Z, nbcol))
#   with(las.files[[i]], plot3d(X,Y,Z, col=color[zcol]))
#   movie3d(spin3d(axis = c(0,0,1), rpm = 10), duration=6)
#   next3d()
# }

X <- lidar$X
Y <- lidar$Y
Z <- lidar$Z

# Define the UI
ui <- fluidPage(
  
  # Application title
  headerPanel("10121248.las"),
  
  # Sidebar with a slider input for number of points
  sidebarPanel(
    sliderInput("pts", 
                "Number of points:", 
                min = 50000, 
                max = 100000, 
                value = 250)
  ),
  HTML("<hr />"),
  helpText(HTML("ShinyWebGL")),
  # Show the generated 3d scatterplot
  mainPanel(
    webGLOutput("sctPlot")
  ))

# Define the server code
server <- function(input, output) {
  output$sctPlot <- renderWebGL({
    plot3d(X[1:input$pts],
           Y[1:input$pts],
           Z[1:input$pts],
           xlab="X",
           ylab="Y",
           zlab="Z",
           col=color[zcol],
           axes=FALSE)
   #axes3d('x', pos = c(NA, 0, 0))
  })
}

# Return a Shiny app object
shinyApp(ui = ui, server = server)
