## this R script depends on the global environment produced by Guannan_7659HW3.Rmd
## the permutation p function 
## summarise above procedures for gene1 as a function
#############################################
## this function only works for genes_matrix 8 columns control, 
## 8 columns treatment and the last column is individual t statistics
## 6384 genes in total 
#########################################
N <- choose(16, 8)

## using genes_matrix ai_com
combi_p <- function(gene){
  # first 8 columns of combinations
  gene_com = combinations(16, 8, gene[1:16], set = FALSE)
  
  # the 2nd 8 columns of combinations
  gene_paired_t = apply(gene_com, 1, function(gene_com){
    gene[1:16][gene[1:16] %nin% gene_com]
  })
  gene_paired = t(gene_paired_t)
  
  # combine to make the permutation matrix
  gene_matrix = cbind(gene_com, gene_paired)
  
  # permutation t statistic vector
  gene_t = sapply(1:6384, function(row){
    test = t.test(gene_matrix[row, 1:8], gene_matrix[row, 9:16], alternative = "two.sided")
    test$statistic
  })
  
  # individual t-statistic 
  t = gene[17] 
  
  ## calculate the p-value
  p_gene = sum(abs(gene_t) >= abs(t))/N
  return(p_gene)
}

## test run and system.time
matrix(apply(head(ai_com),1, combi_p), ncol = 1, byrow = TRUE)
system.time(matrix(apply(head(ai_com),1, combi_p), ncol = 1, byrow = TRUE))
## compare with individual p-value
indi_t$pvalue[1:6] 

## the full permutation 
p_per <- apply(ai_com, 1, combi_p)
p_per <- matrix(p_per, ncol = 1, byrow = TRUE)

## p values with genenames
p_per <- data.frame(ai$genenames, p_per)
colnames(p_per) <- c("genenames", "pvalue")
## get the p value 0.01
p_per_1 <- p_per %>% filter(pvalue <= 0.01)
write.csv(p_per_1, "permutationP.csv")
getwd()
dim(p_per_1)
View(p_per_1)





