library(shiny)
source("PhenoMatcher_rcode.R")



shinyServer(function(input, output){

  PtHPO_DzHPO_compare <- eventReactive(input$go,{
    withProgress(message = 'Calculation in progress', value = 0.3, {
    ptdata<- input$ptHPO
    Pt_HPO_list = strsplit(ptdata,";")
    Pt_HPO_na = test_HPO(unlist(Pt_HPO_list))[1]
    Pt_HPO_valid = test_HPO(unlist(Pt_HPO_list))[2] 
    incProgress(0.4)
    PtHPO_DzHPO_compare <- dz_gene_db_ref_hpo %>%
      rowwise() %>%
      mutate(
        Pt_HPO_valid= Pt_HPO_valid,
        PhenoMatcher_score = compare_term_sets(hpo_id,Pt_HPO_valid )) %>%
      select(-hpo_id, -Pt_HPO_valid) %>%
      group_by(entrez_gene_symbol) %>%
      arrange(desc(PhenoMatcher_score)) %>%
      mutate(disease_id_max = dplyr::first(disease_id),
             PhenoMatcher_score_max = dplyr::first(PhenoMatcher_score),
             disease_name_max = dplyr::first(db_name)) %>%
      group_by( entrez_gene_symbol, disease_id_max, PhenoMatcher_score_max ) %>%
      dplyr::summarise(
        dz_ID_all = paste(disease_id, collapse  = ";"),
        scores = paste(PhenoMatcher_score, collapse  = ";")) %>%
      arrange(desc(PhenoMatcher_score_max)) %>%
      mutate(ID = input$ptID,
             Patient_HPO = input$ptHPO)
    
    })
    
    return( PtHPO_DzHPO_compare)
    
      })
    

  
  Pt_HPO_na <-eventReactive(input$go,{
    
    ptdata<- input$ptHPO
    
    Pt_HPO_list = strsplit(ptdata,";")
    Pt_HPO_na = paste(unlist(test_HPO(unlist(Pt_HPO_list))[1]),collapse  = ";")
    
    return( Pt_HPO_na)
    
  })
  
  hposum <-eventReactive(input$go,{
    
    ptdata<- input$ptHPO
    
    Pt_HPO_list = strsplit(ptdata,";")
    
    hposum<- length(Pt_HPO_list[[1]])
    return( hposum)
    
  })
  
  validhpocount <-eventReactive(input$go,{
    
    ptdata<- input$ptHPO
    
    Pt_HPO_list = strsplit(ptdata,";")
    Pt_HPO_valid = test_HPO(unlist(Pt_HPO_list))[2] 
    validhpocount<- length(Pt_HPO_valid[[1]])
    
    return( validhpocount)
    
  })
  
  
  
  output$table1<-DT::renderDataTable({
    DT::datatable(PtHPO_DzHPO_compare(),rownames = FALSE)%>%formatStyle(columns=colnames(PtHPO_DzHPO_compare()),background = 'white',color='black')
  })
  
  
  output$hposum<-  renderText({ 
    paste("You have entered ",hposum()," HPO terms," , sep="") 
  })
  
  output$validhpocount <- renderText({ 
    paste("including ",validhpocount()," valid HPO terms." , sep="") 
  })
  
  output$unvalidahpo <- renderText({ 
    if(Pt_HPO_na()>0){
      paste("Invalid HPO terms: ",Pt_HPO_na() , sep="") }
  })
  
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$ptID,"_PhenoMatcher_output.csv",sep = "")
    },
    content = function(file) {
      write.csv(PtHPO_DzHPO_compare(), file, row.names = FALSE)
    })
  
  
 
  
}
)

