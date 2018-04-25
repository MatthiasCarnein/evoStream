# evoStream - Evolutionary Stream Clustering Utilizing Idle Times

This R package implements an evolutionary stream clustering algorithm. The corresponding publication is currently in review.
The algorithm uses a widely popuar two-phase clustering approach where the stream is first summarised in real time.
The result are many small preliminary clusters in the stream called 'micro-clusters'.
Our algorithm then incrementally reclusteres these micro-clusters using an evloutionary algorithm.
Evolutionary algorithms create slight variations by combining and randomly modifying existing solutions.
By iteratively selecting better solutions, an evolutionary pressure is created which improves the clustering over time.
Since the evolutionary algorithm is incremental, it is possible to apply between observations, e.g. in the idle time of the stream.
Alternatively it can be applied as a traditional reclustering step, or a combination of both.
This implementation allows to uses fixed number of generations after each observation and during reclustering.

## Installation

The easiest way to install the package is by using devtools:

```R
devtools::install_git("https://wiwi-gitlab.uni-muenster.de/stream/evoStream")
```


## Usage

The algorithm is implemented as an extension to the R-package [stream](https://github.com/mhahsler/stream). Once the publication has been accepted we plan to incorporate it into the package. its usage is therefore the same as in the stream package. An simple example is shown below:

```R
## create data stream
stream <- DSD_Gaussians(k = 3, d = 2)

## initialize evoStream
evoStream <- DSC_evoStream(r=0.05, k=3)

## update model
update(evoStream, stream, n = 1200)

## plot the result
plot(evoStream, stream, type = "both")

## get micro-clusters
get_centers(evoStream, type="micro")

## get macro-clusters
get_centers(evoStream, type="macro")
```
