#'@author nehaque@mcw.edu
#'
#'@description: This script generates the heatmap by clustering all the activity 
#'values and other genomics and high level structural data to present better 
#'picture of the experimental data nad the predicted one.
#'
#'@usage: Define the study and title to generate the heatmap.

# Declare your variables
# 
study = "RAG1" # "RAG1" "RAG2"
title = "Experimental" #  "Experimental" "Predicted"

# Define path to the project folder
Project_Path <- "~/projects/rag_prc" #  Change the Project_Path to where you save
                                     #  the download
################################# No edit required below #######################
Project_name <- "RAGactivityPred"

#load library
source(file.path(Project_Path, Project_name, "R_code", 'Requirements.R'))

if(study == 'RAG1' & title == "Experimental"){
  load(file.path(Project_Path, Project_name, "data", "HeatMap_RAG1_exp.RData"))
}

if(study == 'RAG1' & title == "Predicted"){
  load(file.path(Project_Path, Project_name, "data", "HeatMap_RAG1_pred.RData"))
}

if(study == 'RAG2' & title == "Experimental"){
  load(file.path(Project_Path, Project_name, "data", "HeatMap_RAG2_exp.RData"))
}
if(study == 'RAG2' & title == "Predicted"){
  load(file.path(Project_Path, Project_name, "data", "HeatMap_RAG2_pred.RData"))
}

outfilename <- paste0(study, "_", title, "_heatmap.pdf")
outfile <- file.path(Project_Path, Project_name, "figures", outfilename)
pdf(outfile, width = 6, height = 10, title = paste0(study, "_", title))
# matching index of distance
mDist <- match(rownames(mat_population), rownames(scdf2))

row_ha1 = rowAnnotation(distDNA = scdf2$distDNA[mDist], col = list(distDNA = c("(-1,10.2]" = "gold4", "(10.2,20]" = "gold", "(20,30]"  = "darkorange3", "(30,200]" = "darkorange")))

row_ha2 = rowAnnotation(distSurf = scdf2$distSurf[mDist], col = list(distSurf = c("(-1,1]" = "maroon4", "(1,6]" = "maroon1", "(6,12]" = "darkorchid1")))



# matching index of domain
mDom <- match(rownames(mat_population), tagDF$Vars)
if (gene == "RAG2"){
  row_ha3 = rowAnnotation(distDom = tagDF$ResLoc3[mDom], 
                          col = list(distDom = c("RAG12_inter" = "red3", "RAG2" = "royalblue3")))
}
if(gene == "RAG1"){
  row_ha3 = rowAnnotation(distDom = tagDF$ResLoc3[mDom], 
                          col = list(distDom = c("RAG12_inter" = "red3", "RAG1" = "royalblue3")))
}


k <- 1
hp1 <-  Heatmap(mat_population[,k ], name=colnames(mat_population)[k],  cluster_columns = F,cluster_rows = F,
                show_row_names=F, 
                column_names_gp = gpar(fontsize = 12),
                column_names_side = "bottom", 
                col = legSourceCol,
                heatmap_legend_param = list(
                  title = colnames(mat_population)[k], 
                  labels = legSource
                ) 
)

k <- 2
hp2 <-  Heatmap(mat_population[beg:end,k ], name=colnames(mat_population)[k],  cluster_columns = F, cluster_rows = F,
                
                column_title = paste0(gene, "_", title, " ", length(mat_population[,1]), " vars"), 
                column_title_gp = gpar(fontsize = 10),
                show_row_names=F,
                column_names_gp = gpar(fontsize = 12),
                col = legdbCol, 
                column_names_side = "bottom", 
                heatmap_legend_param = list(
                  title = colnames(mat_population)[k], 
                  labels = legdb)
)
k <- 3
hp3 <-  Heatmap(mat_population[beg:end,k ], name=colnames(mat_population)[k], cluster_rows = F, cluster_columns = F,
                show_row_names=F,
                column_names_gp = gpar(fontsize = 12),
                col = legAFCol,
                column_names_side = "bottom",
                heatmap_legend_param = list(
                  title = colnames(mat_population)[k], 
                  labels = legAF
                )
)
k <- 4
hp4 <-  Heatmap(mat_population[beg:end,k ], name=colnames(mat_population)[k], cluster_columns = F, cluster_rows = F,
                show_row_names=F,
                column_names_gp = gpar(fontsize = 12),
                right_annotation = c(row_ha1, row_ha2, row_ha3),
                
                col <- legActivityCol,
                column_names_side = "bottom",
                heatmap_legend_param = list(
                  title = colnames(mat_population)[k], 
                  labels = legActivity
                )
)

draw(hp1+hp2+hp3+hp4, padding = unit(c(2, 2, 2, 12), "mm"))
dev.off()


