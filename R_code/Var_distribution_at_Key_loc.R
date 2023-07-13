#'@author nehaque@mcw.edu
#'
#'@description: This scripts plot the distribution of variants at key location 
#'in the RAG1/RAG2 complex
#'
#'@usage: Simply running the scripts generates the plot of distribution.


################################# No edit required below #######################

# Define path to the project folder
Project_Path <- "~/projects/rag_prc" #  Change the Project_Path to where you save
#  the download
Project_name <- "RAGactivityPred"

#load library
source(file.path(Project_Path, Project_name, "R_code", 'Requirements.R'))

par(mar=(c(5.1, 4.1, 4.1, 2.1)))
pdf(file= file.path(Project_Path, Project_name, "figures", "Heatmap_analysis_RAG12_exp_pred.pdf"), 
    width = 4,height = 4)

#rag1 experimental
rag1exp <- data.frame(NearDNA = c(18/1.05, 5/1.05, 2/1.05, 3/1.05), 
                      OnSurf=c(26/1.05, 11/1.05, 3/1.05, 5/1.05), 
                      IFace=c(8/1.05, 1/1.05, 0, 0))
rownames(rag1exp) <- c("AG1", "AG2", "AG3", "AG4")
round(rag1exp, 2)
round(rag1exp*1.05, 2)

write.csv(round(rag1exp, 2), 
          file= file.path(Project_Path, Project_name, "data", 
                          "Heatmap_analysis_RAG1_Experimental_Percent.csv"))


write.csv(round(rag1exp*1.05, 2),
          file= file.path(Project_Path, Project_name, "data", 
                          "Heatmap_analysis_RAG1_Experimental_Count.csv"))


near_total <- rag1exp$NearDNA
away_total <- 100 - sum(rag1exp$NearDNA)

barplot(as.matrix(rag1exp), beside = T, col = c("red4", "red", "royalblue4", "royalblue"),
        cex.main=0.8,
        #cex.lab=0.01, 
        cex.axis=0.6,
        cex.names=0.6,
        main = paste0("RAG1 Exp Distrib of variants at key loc"))

#rag1 predicted
rag1pred <- data.frame(NearDNA = c(40/5.32, 33/5.32, 8/5.32, 5/5.32), 
                       OnSurf=c(86/5.32, 92/5.32, 78/5.32, 93/5.32), 
                       IFace=c(17/5.32, 13/5.32, 5/5.32, 3/5.32))
rownames(rag1pred) <- c("AG1", "AG2", "AG3", "AG4")
round(rag1pred, 2)
round(rag1pred*5.32, 2)

write.csv(round(rag1pred, 2),
          file= file.path(Project_Path, Project_name, "data", 
                          "Heatmap_analysis_RAG1_Predicted_Percent.csv"))

write.csv(round(rag1pred*5.32, 2), 
          file= file.path(Project_Path, Project_name, "data", 
                          "Heatmap_analysis_RAG1_Predicted_Count.csv"))



barplot(as.matrix(rag1pred), beside = T, col = c("red4", "red", "royalblue4", "royalblue"), 
        cex.main=0.8,
        #cex.lab=0.01, 
        cex.axis=0.6,
        cex.names=0.6,
        main = paste0("RAG1 Pred Distrib of variants at key loc"))


#rag2 experimental
rag2exp <- data.frame(NearDNA = c(2/0.45, 0, 0, 0), 
                      OnSurf=c(8/0.45, 3/0.45, 1/.45, 3/0.45), 
                      IFace=c(6/0.45, 2/0.45, 0, 0))

rownames(rag2exp) <- c("AG1", "AG2", "AG3", "AG4")
round(rag2exp, 2)
round(rag2exp*.45, 2)

write.csv(round(rag2exp, 2), 
          file= file.path(Project_Path, Project_name, "data", 
                          "Heatmap_analysis_RAG2_Experimental_Percent.csv"))

write.csv(round(rag2exp*.45, 2), 
          file= file.path(Project_Path, Project_name, "data", 
                          "Heatmap_analysis_RAG2_Experimental_Count.csv"))

near_total <- sum(rag2exp$NearDNA)
away_total <- 100 - sum(rag2exp$NearDNA)

barplot(as.matrix(rag2exp), beside = T, col = c("red4", "red", "royalblue4", "royalblue"), 
        cex.main=0.8,
        #cex.lab=0.01, 
        cex.axis=0.6,
        cex.names=0.6, 
        #main = paste0("RAG2", "_", "experimental", "_", "Fraction of variants")
        main = "RAG2 Exp Distrib of variants at key loc")

#rag2 predited
rag2pred <- data.frame(NearDNA = c(1/1.79, 0, 0, 6/1.79), 
                       OnSurf=c(10/1.79, 17/1.79, 17/1.79, 72/1.79), 
                       IFace=c(5/1.79, 3/1.79, 2/1.79, 8/1.79))
rownames(rag2pred) <- c("AG1", "AG2", "AG3", "AG4")
round(rag2pred, 2)
round(rag2pred*1.79, 2)

write.csv(round(rag2pred, 2), 
          file= file.path(Project_Path, Project_name, "data", 
                          "Heatmap_analysis_RAG2_Predicted_Percent.csv"))

write.csv(round(rag2pred*1.79, 2), 
          file= file.path(Project_Path, Project_name, "data", 
                          "Heatmap_analysis_RAG2_Predicted_Count.csv"))

barplot(as.matrix(rag2pred), beside = T, col = c("red4", "red", "royalblue4", "royalblue"), 
        cex.main=0.8,
        #cex.lab=0.01, 
        cex.axis=0.6,
        cex.names=0.6,
        main = paste0("RAG2 Pred Distrib of variants at key loc"))

dev.off()