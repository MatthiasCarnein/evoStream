# evoStream - Evolutionary Stream Clustering Utilizing Idle Times

This is the implementation of an evolutionary stream clustering algorithm as proposed in our article in the Journal of Big Data Research.

> Carnein M. and Trautmann H. (2018), "evoStream - Evolutionary Stream Clustering Utilizing Idle Times", Big Data Research. 


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
#library(evoStream)

stream <- DSD_Memory(DSD_Gaussians(k = 3, d = 2), 1000)

## init evoStream
evoStream <- DSC_evoStream(r=0.05, k=3, incrementalGenerations=1, reclusterGenerations=1000)

## insert observations
update(evoStream, stream, n = 1000)

## micro clusters
get_centers(evoStream, type="micro")

## micro weights
get_weights(evoStream, type="micro")

## macro clusters
get_centers(evoStream, type="macro")

## macro weights
get_weights(evoStream, type="macro")

## plot result
reset_stream(stream)
plot(evoStream, stream, type = "both")

## if we have time, evaluate additional generations. This can be called at any time, also between observations.
## by default, 1 generation is evaluated after each observation and 1000 generations during reclustering (parameters)
evoStream$RObj$recluster(2000)

## plot improved result
reset_stream(stream)
plot(evoStream, stream, type="both")

## get assignment of micro to macro clusters
microToMacro(evoStream)

```


## Related Implementations

There is also a C++ port of this implementation without the glue code for R. It is available here: [https://wiwi-gitlab.uni-muenster.de/m_carn01/evoStream_C](https://wiwi-gitlab.uni-muenster.de/m_carn01/evoStream_C)

In addition, a Python port is available as a Python module here: [https://wiwi-gitlab.uni-muenster.de/m_carn01/evoStream_python](https://wiwi-gitlab.uni-muenster.de/m_carn01/evoStream_python)
