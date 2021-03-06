% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DSC_EA.R
\name{DSC_EA}
\alias{DSC_EA}
\title{Evolutionary Algorithm}
\usage{
DSC_EA(k, generations = 2000, crossoverRate = 0.8,
  mutationRate = 0.001, populationSize = 100)
}
\arguments{
\item{k}{number of macro-clusters}

\item{generations}{number of EA generations performed during reclustering}

\item{crossoverRate}{cross-over rate for the evolutionary algorithm}

\item{mutationRate}{mutation rate for the evolutionary algorithm}

\item{populationSize}{number of solutions that the evolutionary algorithm maintains}
}
\description{
Reclustering using an evolutionary algorithm.
This approach was designed for \code{evoStream} but can also be used for other micro-clustering algorithms.
The evolutionary algorithm uses existing clustering solutions and creates small variations of them by combining and randomly modfiying them.
The modified solutions can yield better partitions and thus can improve the clustering over time.
The evolutionary algorithm is incremental, which allows to improve existing macro-clusters instead of recomputing them every time.
}
\examples{
stream <- DSD_Memory(DSD_Gaussians(k = 3, d = 2), 1000)

## online algorithm
dbstream <- DSC_DBSTREAM(r=0.1)

## offline algorithm
EA <- DSC_EA(k=3, generations=1000)

## create pipeline and insert observations
two <- DSC_TwoStage(dbstream, EA)
update(two, stream, n=1000)

## plot resut
reset_stream(stream)
plot(two, stream, type="both")

## if we have time, evaluate additional generations. This can be called at any time, also between observations.
two$macro_dsc$RObj$recluster(2000)

## plot improved result
reset_stream(stream)
plot(two, stream, type="both")


## alternatively: do not create twostage but apply directly
reset_stream(stream)
update(dbstream, stream, n = 1000)
recluster(EA, dbstream)
reset_stream(stream)
plot(EA, stream)


}
\author{
Matthias Carnein \email{Matthias.Carnein@uni-muenster.de}
}
