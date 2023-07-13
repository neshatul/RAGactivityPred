#'@author nehaque@mcw.edu
#'
#'@description: This script demonstrates the usage of prediction models generated 
#'by Model_devel.R to predict the enzymatic activity values of the RAG1/RAG2 
#'variants. Thee prediction values are saved in data dir.
#'
#'@usage: define the study ="RAG1" or study = "RAG2" and run the script. 



# We have two studies 'RAG1' and 'RAG2'
#study <- 'RAG1'
study <- 'RAG2'


################################# No edit required below #######################
# Define path to the project folder
Project_Path <- "~/projects/rag_prc" #  Change the Project_Path to where you save
#  the download
Project_name <- "RAGactivityPred"

#load library
source(file.path(Project_Path, Project_name, "R_code", 'Requirements.R'))

#Load data
if(study == 'RAG1'){
  mlr_model <- readRDS(file.path(Project_Path, Project_name, 'model/RAG1_MLRmodel7.rds' ))
  plsr_model <- readRDS(file.path(Project_Path, Project_name, 'model/RAG1_PLSRmodel7.rds' ))
  ncomp <- 18
  
  db_variants <- "RAG1_DB_Variants.csv" # scores of variants gathered from various
                                        # mutation databases
  
  #Read scores for variants from databases
  variants_db <- read.csv(file.path(Project_Path, Project_name, 'data', db_variants))
  
  
  db_variants_predicted1 <- "RAG1_DB_Variants_predicted_mlr.csv"
  db_variants_predicted2 <- "RAG1_DB_Variants_predicted_plsr.csv"
  
}else if(study == 'RAG2'){
  mlr_model <- readRDS(file.path(Project_Path, Project_name, 'model/RAG2_MLRmodel9.rds' ))
  plsr_model <- readRDS(file.path(Project_Path, Project_name, 'model/RAG2_PLSRmodel9.rds' ))
  ncomp <- 6
  
  db_variants <- "RAG2_DB_Variants.csv" # scores of variants gathered from various
                                        # mutation databases
  
  #Read scores for variants from databases
  variants_db <- read.csv(file.path(Project_Path, Project_name, 'data', db_variants))
  
  db_variants_predicted1 <- "RAG2_DB_Variants_predicted_mlr.csv"
  db_variants_predicted2 <- "RAG2_DB_Variants_predicted_plsr.csv"
}



#Predict activity for variants using MLR
d2pPred <- predict(mlr_model, newdata = variants_db, interval="predict") %>% data.frame(.)
d2pPredDf <- data.frame("P_vars"=variants_db$P_vars, "PredActivity"=round(d2pPred$fit, 3))
print(d2pPredDf)
write.table(d2pPredDf, file.path(file.path(Project_Path, Project_name, 'data', db_variants_predicted1)),
            sep = ",", quote = F, row.names = F)

#Predict activity for variants using PLSR
d2pPred <- predict(plsr_model, newdata = variants_db , interval="predict", ncomp = ncomp) %>% data.frame(.)
d2pPredDf <- data.frame("P_vars"=variants_db$P_vars, "PredActivity"=round(d2pPred[[1]], 3))
print(d2pPredDf)
write.table(d2pPredDf, file.path(file.path(Project_Path, Project_name, 'data', db_variants_predicted2)),
            sep = ",", quote = F, row.names = F)
