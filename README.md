# Clustering-neuronal-properties
Hierarchical clustering of overlapping neuronal properties to identify distinct neuronal populations 
Hierarchical cluster analysis was performed using R (The R Project for Statistical Computing; www.r-project.org). Several electrical and/or morphological properties were normalized to compare on a common scale using equation:

(X-X_min)/(X_max-X_min )

where, X is the measured value for a specific feature of neuron, X_min and X_max are the minimal and maximal value for the feature across all neurons, respectively. Hierarchical clustering was performed with average linkage and Pearson correlation. Pearson correlation distance was calculated to determine dissimilarity between features of neurons and thus assign them to different groups.

Clustering was based on their similarity with respect to specified characteristics such that mutually exclusive subsets are formed. 
