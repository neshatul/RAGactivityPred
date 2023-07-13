# Activity prediction model for RAG1/2 variants

## Structural scores implementation in variant effect prediction model

## Requirements
library(pls)

library(dplyr)

require(ComplexHeatmap)


## sessionInfo
R version 4.0.4 (2021-02-15)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: CentOS Linux 7 (Core)

Matrix products: default
BLAS/LAPACK: /hpc/apps/intel/mkl/2021.1.1/lib/intel64/libmkl_intel_lp64.so.1

locale:
 [1] LC_CTYPE=en_US.UTF-8 LC_NUMERIC=C         LC_TIME=C            LC_COLLATE=C         LC_MONETARY=C        LC_MESSAGES=C       
 [7] LC_PAPER=C           LC_NAME=C            LC_ADDRESS=C         LC_TELEPHONE=C       LC_MEASUREMENT=C     LC_IDENTIFICATION=C 

attached base packages:
[1] grid      stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] ComplexHeatmap_2.6.2 dplyr_1.1.2          pls_2.8-0           

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.6          compiler_4.0.4      pillar_1.9.0        RColorBrewer_1.1-3  tools_4.0.4         digest_0.6.27      
 [7] tibble_3.2.1        evaluate_0.18       lifecycle_1.0.3     clue_0.3-59         pkgconfig_2.0.3     png_0.1-7          
[13] rlang_1.1.1         cli_3.5.0           rstudioapi_0.13     parallel_4.0.4      xfun_0.25           cluster_2.1.0      
[19] knitr_1.31          generics_0.1.3      GlobalOptions_0.1.2 S4Vectors_0.28.1    vctrs_0.6.2         IRanges_2.24.1     
[25] tidyselect_1.2.0    stats4_4.0.4        glue_1.6.2          R6_2.5.1            GetoptLong_1.0.5    fansi_1.0.3        
[31] rmarkdown_2.10      magrittr_2.0.3      matrixStats_0.58.0  htmltools_0.5.1.1   BiocGenerics_0.36.0 rsconnect_0.8.16   
[37] shape_1.4.5         circlize_0.4.12     colorspace_2.0-3    utf8_1.2.2          crayon_1.5.2        rjson_0.2.20       
[43] Cairo_1.5-12.2


## Usage:
The repository contains following scripts which were used to develop the prediction model, results plotting and further analysis ploting.
RAGactivityPred/R_code/Model_devel.R - model development code.
RAGactivityPred/R_code/Variant_effect_prediction.R - Activity prediction using the model.
RAGactivityPred/R_code/Plot_Heatmap.R - Clustering experimental and predicted data for better visualization.
RAGactivityPred/R_code/Plot_Heatmap.R - Further interpretation of generated data.

Data generated using these scripts can be found in data and figures directoiry

# Contribution

Michael Zimmermann:mtzimmermann@mcw.edu; Neshatul Haque:nehaque@mcw.edu



