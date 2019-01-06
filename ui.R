library(shiny)
library(shinydashboard)
library(DT)

dashboardPage(
  skin = "black",
  
  dashboardHeader(
    title = "PhenoMatcher"
  ),
  
  dashboardSidebar(
    
    sidebarMenu(
      menuItem("Query", tabName = "tool",
               icon = icon("search", lib="font-awesome")
      ),
      menuItem("About", tabName = "about",
               icon = icon("info-circle", lib="font-awesome")
      )
    )
  ),
  
  dashboardBody(
    
    tabItems(
      tabItem(tabName = "tool",
              fluidRow(
                column(width = 6, 
                       box(width = NULL, 
                           p("Search by HPO terms of your patient",style="color:dimgray;font-size: 15px"),
                           textAreaInput('ptHPO',NULL,value = "HP:0003302;HP:0002650;HP:0009830;HP:0000978",placeholder="Enter a list of HPO terms seperated by semicolons"),
                           p("Patient ID", style="color:dimgray;font-size: 15px"),
                           textInput('ptID',NULL,value = "sample1",placeholder="Enter the patient ID for sample identification"),
                           actionButton('go', 'Go'),
                           p("(This will take a few minutes)",style="color:dimgray;font-size: 13px")
                       )
                ),
                column(width = 6,br(),
                       textOutput('hposum'),
                       textOutput('validhpocount'),
                       textOutput('unvalidahpo'))
                
              ),
              
              
              fluidRow(
                column(width = 12,
                       box(width = NULL,
                           p("Output: gene prioritization by phenotypic similarity",style="color:dimgray;font-size: 15px"),
                           downloadButton("downloadData", "Download"),
                           br(""),
                           solidHeader = TRUE,
                           collapsible = TRUE,
                           div(style = 'overflow-x: scroll', DT::dataTableOutput('table1'))
                           
                           
                       )
                )
              )
      ),
      
      
      tabItem(tabName = "about",
              
              p("What is PhenoMatcher",  style="color:darkcyan"),
              HTML("<p>PhenoMatcher is developed as part of the exome reanalysis pipeline for the paper <i>Post-reporting reanalysis of 
                    exome sequencing data – molecular diagnostic and clinical genomic outcomes</i>, by Liu <i>et al</i>. The code used in this 
                    program is a re-implementation and extension of the algorithm from a previous publication by James <i>et al</i>, <i>A visual 
                    and curatorial approach to clinical variant prioritization and disease gene discovery in genome-wide diagnostics.</i> (2016) 
                    Genome Med. 8:13. The algorithm was used in the publication by Posey and Harel <i>et al</i>, <i>Resolution of disease 
                    phenotypes sesulting from multilocus genomic variation</i> (2017) N Engl J Med 376: 21-31.
                    <br>
                    <br>PhenoMatcher takes human phenotype ontology (HPO) term sets as inputs, and calculates semantic similarity scores 
                    between the input term sets and all disease genes reported in "),
              a(href="https://www.omim.org/", "OMIM."),
              p("How to interpret the results",style="color:darkcyan"),
              HTML("<p>PhenoMatcher annotates each disease-associated gene with:
                 <br>1. entrez_gene_symbol: gene symbols of Entrez genes
                 <br>2. disease_id_max: the OMIM disease identifier corresponding to the disease gene. When the same gene is associated with 
                        multiple diseases, the best matching disease ID is shown. 
                 <br>3. PhenoMatcher_score_max: semantic similarity score between the input HPO term set and the disease term set. When 
                        the same gene is associated with multiple diseases, the highest matching score is shown.
                 <br>4. dz_ID_all: similar to # 2, with all disease identifiers listed
                 <br>5. scores: similar to # 3, with all matching scores listed
                 <br>6. ID: patient identification
                 <br>7. Patient_HPO: input HPO terms"),
              p("Additional documentation",style="color:darkcyan"),
              HTML("<p>The source codes and documentation can be found in the GitHub link: "),
              a(href="https://github.com/liu-lab/exome_reanalysis", "https://github.com/liu-lab/exome_reanalysis."),
              p("Contact us", style="color:darkcyan"),
              p("Please contact us at songxiaofei1002@gmail.com;cshaw@baylorgenetics.com;pengfeil@bcm.edu")
              
      )
    )
  )
)    



