
# install the following
#install.packages("gplots", dependencies = TRUE)
#install.packages("RColorBrewer", dependencies = TRUE)
#install.packages("sm", dependencies = TRUE)
#install.packages("corrplot", dependencies = TRUE)
#install.packages("wesanderson")

library(gplots)
library(RColorBrewer)
library(sm)
library(corrplot)
library(wesanderson)

#Load the data in .csv file format with different properties as column and different neurons as rows.
mydata <- read.csv("traced.csv")
number<-32 # total number of columns

# Normalization of the data in each column from 0 to 1.
# K-Nearest Neighbors (KNN) method.
normalize <- function(x) {
  #return ((x/(max(x)))) 
  return ((x - min(x)) / (max(x) - min(x))) 
}
mydata1 <- data.frame(mydata[1:1],(lapply(mydata[2:number],normalize))) 
fitness <- mydata1
property_names <- fitness[,1]
fitness_mat <- data.matrix(fitness[,2:number]) #[,c(2:5)])
rownames(fitness_mat) <- property_names
fit_cor <- cor(t(fitness_mat)) 

#output pdf file created in the workspace
pdf(height=20, width=20, pointsize=20, file="file_name.pdf")

#correlation plot (figure 1 in the pdf output)
corrplot(fit_cor, method="circle", type="upper", order="hclust", addrect=10) # tl.cex = 0.2, mar=c(1,1,1,1)
#View(fitness)
#View(fit_cor)
#corrplot(fitness_mat, method="circle", type="upper", order="hclust", addrect=10)

# Clustering based on dissimilarity
dissimilarity <- 1 - fit_cor
distance <- as.dist(dissimilarity)
hr <- hclust(distance)
mycl <- cutree(hr, k=2) # k is the number of clusters


# Clustering of neurons:figure 2 in the pdf output
clusterCols <- cm.colors(length(unique(mycl)))
# create vector of colors for side bar
myClusterSideBar <- clusterCols[mycl]
# colour for heatmap
new_color <- colorRampPalette(c("red", "white", "blue"))(13)

heatmap.2(fitness_mat, main="Hierarchical Cluster", Rowv=as.dendrogram(hr), Colv=NA, dendrogram="row", 
          col=new_color, density.info="none", trace="none", RowSideColors= myClusterSideBar, margins =c(12,9))

dev.off()