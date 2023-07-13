#'@author nehaque@mcw.edu
#'
#'@description: This will generate plots which are save in figures dir and 
#'prediction model which are saved in model dir.
#'@usage: define the study ="RAG1" or study = "RAG2" and run the script. 

# Define the variable
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
  load(file.path(Project_Path, Project_name, 'data/RAG1_data7.RData' ))
  ncomp <- 18 # number of partial least square components
}else if(study == 'RAG2'){
  load(file.path(Project_Path, Project_name, 'data/RAG2_data9.RData' ))
  ncomp <- 6 # number of partial least square components
}

ll <- -15
ul <- 140
corr_text_pos_x = 35
Rsqr_text_pos_x = 35

corr_text_pos_y = 130
Rsqr_text_pos_y = 118

RmseOnPlot <- T
rmse_text_x <- 35
rmse_text_y <- 108


height= 3
width= 3

cex= 0.5
lwd=0.8
cex.lab=0.5
cex.axis=0.5
cex.main=0.5
cex.sub=0.3

##################################################################################
outfilename <- paste0(study, "_", "TrainTest_Plot.pdf")
outfile <- file.path(Project_Path, Project_name, "figures", outfilename)
pdf(outfile, width = 4, height = 4, title = paste0(study, "_TrainTest_Plot"))

# Multiple linear regression model 
mlr_model <- lm(ExpActivity ~ ., data=df_train)

plotTraindf <- data.frame("ExpActivity" = df_train$ExpActivity, 
                          "PredActivity"=unname(mlr_model$fitted.values))

cor.valTrn <- cor(plotTraindf$ExpActivity, plotTraindf$PredActivity)
trainPredlm <- lm(ExpActivity~PredActivity, data=plotTraindf)
rsqrtrain <- summary(trainPredlm)[[8]]

predict_RMSE <- mean((plotTraindf$ExpActivity-unname(mlr_model$fitted.values))^2) %>% 
  sqrt()
par(mar=c(4,4,2,1), oma=c(0,0,0,0))
plot(x = plotTraindf$ExpActivity, y = unname(mlr_model$fitted.values), 
     main = sprintf("Prediction of %s training data\n using MLR model\n", study), 
     cex.main = cex.main,
     xlim=c(-15, 140), ylim=c(-15, 140),
     xaxt = "n",
     yaxt = "n", 
     cex= cex, lwd=lwd, cex.lab=cex.lab, cex.axis=cex.axis, 
     xlab = "Activity Experimental", ylab="Activity Predicted")
abline(lm.fit(x=as.matrix(plotTraindf$ExpActivity),
              y=as.matrix(plotTraindf$PredActivity)), col="blue", lwd=2)

abline(h=0, v=0, lty = 2)
text(sprintf("Corr = %s", round(cor.valTrn, digits = 3)), 
     x = corr_text_pos_x, y = corr_text_pos_y, cex = cex)
text(bquote(R^2 ~" = "~ .(round(rsqrtrain, digits = 3))), 
     x = Rsqr_text_pos_x, y = Rsqr_text_pos_y, cex = cex)
text(sprintf("RMSE = %s", round(predict_RMSE, digit=3)), 
     x=rmse_text_x, y=rmse_text_y, cex = cex)
axis(side = 1, at = c(0, 25, 50, 75, 100, 125), cex.axis=cex.axis)
axis(side = 2, at = c(0, 25, 50, 75, 100, 125), cex.axis=cex.axis)

# predict the test MLR
tstPredicted <- predict(mlr_model, newdata = df_test , interval="predict") %>% 
  data.frame(.)
ExpPred <- data.frame("P_vars"=df_test_vars, "ExpActivity"=df_test$ExpActivity, 
                      "PredActivity" = tstPredicted$fit)
ExpPredlm <- lm(ExpActivity~PredActivity, data=ExpPred)
rsqrMl <- summary(ExpPredlm)[[8]]
cor.valMl <- cor(ExpPred$PredActivity, ExpPred$ExpActivity)

predict_RMSE <- mean((ExpPred$ExpActivity - ExpPred$PredActivity)^2) %>% sqrt()
plot(x = ExpPred$ExpActivity, y = ExpPred$PredActivity, 
     main = sprintf("Prediction of %s test data\n using MLR model\n", study), 
     cex.main = cex.main, 
     xlim=c(ll, ul), ylim=c(ll, ul), 
     xaxt = "n",
     yaxt = "n",
     cex= cex, lwd=lwd, cex.lab=cex.lab, cex.axis=cex.axis, 
     xlab = "Activity Experimental", ylab="Activity Predicted")
abline(lm.fit(x=as.matrix(ExpPred$ExpActivity),
              y=as.matrix(ExpPred$PredActivity)), col="blue", lwd=2)

abline(h=0, v=0, lty = 2)
text(sprintf("Corr = %s", round(cor.valMl, digits = 3)), 
     x = corr_text_pos_x, y = corr_text_pos_y, cex = cex)
text(bquote(R^2 ~" = "~ .(round(rsqrMl, digits = 3))), 
     x = Rsqr_text_pos_x, y = Rsqr_text_pos_y, cex = cex)
if (RmseOnPlot) text(sprintf("RMSE = %s", round(predict_RMSE, digit=3)), 
                     x=rmse_text_x, y=rmse_text_y, cex = cex)
axis(side = 1, at = c(0, 25, 50, 75, 100, 125), cex.axis=cex.axis)
axis(side = 2, at = c(0, 25, 50, 75, 100, 125), cex.axis=cex.axis)
################################################################################
################################################################################


#partial least square regression model 
plsr_model <- plsr(ExpActivity ~ ., ncomp = ncomp, data = df_train, 
                   validation = "LOO")


plotTraindf <- data.frame("ExpActivity" = df_train$ExpActivity, 
                          "PredActivity"=plsr_model$fitted.values[,,ncomp])
cor.valTrn <- cor(plotTraindf$ExpActivity, plotTraindf$PredActivity)
trainPredlm <- lm(ExpActivity~PredActivity, data=plotTraindf)
rsqrtrain <- summary(trainPredlm)[[8]]


predict_RMSE <- mean((plotTraindf$ExpActivity - plotTraindf$PredActivity)^2) %>% 
  sqrt()
plot(x = plotTraindf$ExpActivity, y = plotTraindf$PredActivity, 
     main = sprintf("Prediction of %s Train data\n using PLSR model\n", study), 
     cex.main = cex.main,
     xlim=c(-15, 140), ylim=c(-15, 140), 
     xaxt = "n",
     yaxt = "n",
     cex= cex, lwd=lwd, cex.lab=cex.lab, cex.axis=cex.axis, 
     xlab = "Activity Experimental", ylab="Activity Predicted")
abline(lm.fit(x=as.matrix(plotTraindf$ExpActivity),
              y=as.matrix(plotTraindf$PredActivity)), col="blue", lwd=2)

abline(h=0, v=0, lty = 2)
text(sprintf("Corr = %s", round(cor.valTrn, digits = 3)), 
     x = corr_text_pos_x, y = corr_text_pos_y, cex = cex)
text(bquote(R^2 ~" = "~ .(round(rsqrtrain, digits = 3))), 
     x = Rsqr_text_pos_x, y = Rsqr_text_pos_y, cex = cex)
if (RmseOnPlot)text(sprintf("RMSE = %s", round(predict_RMSE, digit=3)), 
                    x=rmse_text_x, y=rmse_text_y, cex = cex)
axis(side = 1, at = c(0, 25, 50, 75, 100, 125), cex.axis=cex.axis)
axis(side = 2, at = c(0, 25, 50, 75, 100, 125), cex.axis=cex.axis)

# predict the test PLSR
tstPredPLSR <- predict(plsr_model, newdata = df_test , interval="predict")
ExpPredPLSR <- data.frame("P_vars"=df_test_vars, 
                          "ExpActivity"=df_test$ExpActivity, 
                          "PredActivity" = tstPredPLSR[,,ncomp])
ExpPredlmPl <- lm(ExpActivity~PredActivity, data=ExpPredPLSR)
rsqrPl <- summary(ExpPredlmPl)[[8]]
cor.valPl <- cor(ExpPredPLSR$PredActivity, ExpPredPLSR$ExpActivity)


predict_RMSE <- mean((ExpPredPLSR$ExpActivity - ExpPredPLSR$PredActivity)^2) %>% 
  sqrt()
plot(x = ExpPredPLSR$ExpActivity, y = ExpPredPLSR$PredActivity, 
     main = sprintf("Prediction of %s test data\n using PLSR model\n", study), 
     cex.main = cex.main,
     xlim=c(ll, ul), ylim=c(ll, ul), 
     xaxt = "n",
     yaxt = "n",
     cex= cex, lwd=lwd, cex.lab=cex.lab, cex.axis=cex.axis, 
     xlab = "Activity Experimental", ylab="Activity Predicted")
abline(lm.fit(x=as.matrix(ExpPredPLSR$ExpActivity),
              y=as.matrix(ExpPredPLSR$PredActivity)), col="blue", lwd=2)
abline(h=0, v=0, lty = 2)
text(sprintf("Corr = %s", round(cor.valPl, digits = 3)), 
     x = corr_text_pos_x, y = corr_text_pos_y, cex = cex)
text(bquote(R^2 ~" = "~ .(round(rsqrPl, digits = 3))), 
     x = Rsqr_text_pos_x, y = Rsqr_text_pos_y, cex = cex)
if (RmseOnPlot)text(sprintf("RMSE = %s", round(predict_RMSE, digit=3)), 
                    x=rmse_text_x, y=rmse_text_y, cex = cex)
axis(side = 1, at = c(0, 25, 50, 75, 100, 125), cex.axis=cex.axis)
axis(side = 2, at = c(0, 25, 50, 75, 100, 125), cex.axis=cex.axis)

dev.off()
################################################################################
################################################################################

if(study == 'RAG1'){
  modelFile <- file.path(Project_Path, Project_name,'model', 'RAG1_MLRmodel7.rds')
  saveRDS(mlr_model, modelFile)
}else if(study == 'RAG2'){
  modelFile <- file.path(Project_Path, Project_name,'model', 'RAG2_MLRmodel9.rds')
  saveRDS(mlr_model, modelFile)
  }