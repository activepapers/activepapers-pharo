# The ActivePapers Pharo edition

The Pharo edition of [ActivePapers](https://www.activepapers.org/) focuses on the documentation and user interface aspects of communicating computational science. It is based on the [Glamorous Toolkit](https://gtoolkit.com/), an innovative development environment for [Pharo](http://pharo.org/).

This package is work in progress. It is complete enough to produce computational documents, and it contains a realistic example (class `InfluenzaLikeIllnessInFrance`). However, there is not much protection against messing up such a document using incorrectly used or incompletely implemented editing operations. Also, persistence of the datasets in an ActivePaper is not yet implemented.

You can install ActivePapers either into a plain Pharo 8 image, or into a [pre-built GToolkit image](https://gtoolkit.com/install/). The latter is strongly recommended, as installation on top of plain Pharo requires downloading all of GToolkit first, and that can take a lot of time. In either case, install ActivePapers by running the following code snippet in a playground:
```
Metacello new
    baseline: 'ActivePapers';
    repository: 'github://activepapers/activepapers-pharo/src';
    onConflictUseLoaded;
    load.
```

After installation, there will be an "ActivePapers" entry in the world menu (in the Morphic universe). It gives access to the package's documentation and to a catalog of all the ActivePapers available in the image (initially the examples).
