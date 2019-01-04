# PhenoMatcher
<b>What is PhenoMatcher</b>
<br>PhenoMatcher is developed as part of the exome reanalysis pipeline for the paper <i>Post-reporting reanalysis of exome sequencing data – molecular diagnostic and clinical genomic outcomes</i>, by Liu <i>et al</i>. The code used in this program is a re-implementation and extension of the algorithm from a previous publication by James <i>et al</i>, <i>A visual and curatorial approach to clinical variant prioritization and disease gene discovery in genome-wide diagnostics.</i> (2016) Genome Med. 8:13. The algorithm was used in the publication by Posey and Harel <i>et al</i>, <i>Resolution of disease phenotypes sesulting from multilocus genomic variation</i> (2017) N Engl J Med 376: 21-31.
                    <br>
                    <br>PhenoMatcher takes human phenotype ontology (HPO) term sets as inputs, and calculates semantic similarity scores 
                    between the input term sets and all disease genes reported in OMIM https://www.omim.org/.

<b>How to interpret the results</b>
<br>PhenoMatcher annotates each disease-associated gene with:
                 <br>1. entrez_gene_symbol: gene symbols of Entrez genes
                 <br>2. disease_id_max: the OMIM disease identifier corresponding to the disease gene. When the same gene is associated with multiple diseases, the best matching disease ID is shown. 
                 <br>3. PhenoMatcher_score_max: semantic similarity score between the input HPO term set and the disease term set. When the same gene is associated with multiple diseases, the highest matching score is shown.
                 <br>4. dz_ID_all: similar to # 2, with all disease identifiers listed
                 <br>5. scores: similar to # 3, with all matching scores listed
                 <br>6. ID: patient identification
                 <br>7. Patient_HPO: input HPO terms

<b>Additional documentation</b>
<br>The source codes and documentation can be found in the GitHub link: 
              https://github.com/liu-lab/exome_reanalysis
              
<b>Contact us</b>
<br>Please contact us at songxiaofei1002@gmail.com;cshaw@baylorgenetics.com;pengfeil@bcm.edu
