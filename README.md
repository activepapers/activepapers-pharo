# The ActivePapers Pharo edition

The Pharo edition of [ActivePapers](https://www.activepapers.org/) focuses on the documentation and user interface aspects of communicating computational science. It is based on the [Glamorous Toolkit](https://gtoolkit.com/), an innovative development environment for [Pharo](http://pharo.org/).

This package is work in progress. It is complete enough to produce computational documents, and it contains a realistic example (class `InfluenzaLikeIllnessInFrance`). However, there is not much protection against messing up such a document using incorrectly used or incompletely implemented editing operations. Also, persistence of the datasets in an ActivePaper is not yet implemented.

To install in Pharo 7, execute the following lines in a playground:
```
EpMonitor current disable.
[ 
Metacello new
    baseline: 'ActivePapers';
    repository: 'github://activepapers/activepapers-pharo/src';
    onConflictUseLoaded;
    load.
] ensure: [ EpMonitor current enable ].
```
Note that this will also install the Glamorous Toolkit, which is a rather large package. Installation can thus take anything from 15 to 30 minutes.

After installation, there will be an "ActivePapers" entry in the world menu. It gives access to the package's documentation and to a catalog of all the ActivePapers available in the image (initially the examples).
