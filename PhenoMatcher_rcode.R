library(tidyverse)
library(parallel)
library(biomaRt)
library(magrittr)

select = dplyr::select


####functions###
load("data/dz_gene_db_ref_hpo.Rdata")
load('data/MICA_mat.RData')
load("data/all_hpo_term.Rdata")
compare_term_sets = function(annotated_set, disease_set){
  
  if (length(disease_set) == 0) {return(0)}
  
  sub_mica_1 = MICA_mat[annotated_set, disease_set, drop = FALSE]
  resnik_1 = mean(apply(sub_mica_1, 1, max))
  
  sub_mica_2 = MICA_mat[disease_set, annotated_set, drop = FALSE]
  resnik_2 = mean(apply(sub_mica_2, 1, max))
  
  round(mean(c(resnik_1, resnik_2)),digits = 3)
}


test_HPO <- function(x){
  HPO_na <- setdiff(x, all_hpo_term)
  HPO_valid <- intersect(x, all_hpo_term)
  return(list(HPO_na,HPO_valid))
}
