# evoStream - Evolutionary Stream Clustering Utilizing Idle Times

This is the implementation of an evolutionary stream clustering algorithm as proposed in our article in the Journal of Big Data Research.
The online component uses a simplified version of `DBSTREAM` to generate micro-clusters.
The micro-clusters are then incrementally reclustered using an evloutionary algorithm.
Evolutionary algorithms create slight variations by combining and randomly modifying existing solutions.
By iteratively selecting better solutions, an evolutionary pressure is created which improves the clustering over time.
Since the evolutionary algorithm is incremental, it is possible to apply it between observations, e.g. in the idle time of the stream.
Whenever there is idle time, we can call the `recluster` function of the reference class to improve the macro-clusters (see example).
The evolutionary algorithm can also be applied as a traditional reclustering step, or a combination of both.
In addition, this implementation also allows to evaluate a fixed number of generations after each observation.

## Installation

An implementation of the proposed algorithm is available in the development version of the popular R-package [stream](https://github.com/mhahsler/stream).
The algorithm is implemented in C++ with interfaces to R for easier prototyping.
The latest release of the library on CRAN does not yet include evoStream but will do so with the next release. 
For users not wanting to switch to the development version, the algorithm is also available as an extension package to stream.
The easiest way to install the extension package is by using devtools:

```R
devtools::install_git("https://wiwi-gitlab.uni-muenster.de/m_carn01/evoStream")
```


## Usage

```R
library(stream)
## library(evoStream)

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


## Related Implementations

There is also a C++ port of this implementation without the glue code for R. It is available here: [https://wiwi-gitlab.uni-muenster.de/m_carn01/evoStream_C](https://wiwi-gitlab.uni-muenster.de/m_carn01/evoStream_C)