% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/EnvBV_blup.R
\name{EnvBV_blup}
\alias{EnvBV_blup}
\title{Compute the best linear unbiased prediction and the conditional variance
matrix of environment-specific breeding values}
\usage{
EnvBV_blup(Pheno, K, Omega_G, Omega_E)
}
\arguments{
\item{Pheno}{a data frame with three columns: "Y" for phenotypic values,
"Genotype" for genotype names and "Environment" for environment names.
All genotypes names must be included in the set or row and column names of
the "K" matrix. The number of environments must be at least two}

\item{K}{a square kinship or genomic relationship matrix for N genotypes
whose row and column names include those of the "Genotype" column of
the "Pheno" matrix}

\item{Omega_G}{a square matrix with genetic covariances between J environments
whose row and column names correspond to those of the "Environment" column of
the "Pheno" matrix}

\item{Omega_E}{a square matrix with error covariances between J environments
whose row and column names correspond to those of the "Environment" column of
the "Pheno" matrix}
}
\value{
a list of two elements: a "G_hat" matrix of best linear unbiased prediction
of environment-specific breeding values for the N genotypes (as rows) in J
environments (as columns), and a square conditional variance matrix "P"
of environment-specific breeding values of dimension NJxNJ where each row
block of size N correspond to an environment and the rows of each block
correspond to genotypes
}
\description{
This function calculates the best linear unbiased prediction
and the conditional variance matrix of environment-specific breeding values
}
\examples{
## Set seed for reproductibility
set.seed(123)

## Load "wheat" dataset from BGLR
data("wheat",package = "BGLR")

## Generate a design data frame for all genotypes in 5 environments
Design <- expand.grid(Genotype=rownames(wheat.A),Environment=paste0("Env",1:5))

## Set sparseness by discarding 80\% of the combinations
Design <- Design[-sample(nrow(Design),round(nrow(Design)*4/5)),]

## Simulate phenotypic data with default parameter values
DataSim <- Simulate_MET_data(Design=Design,K=wheat.A)

## Calculate the blup and the conditional variance matrix using simulated variance components
## this step can take several seconds
## note that variance can also be estimated (e.g. using BGLR)
BlupEnvBV <- EnvBV_blup(Pheno=DataSim$Pheno,K=wheat.A,Omega_G=DataSim$Omega_G,
                        Omega_E=DataSim$Omega_E)

## Display results
head(BlupEnvBV$G_hat)
BlupEnvBV$P[1:5,1:5]

}
