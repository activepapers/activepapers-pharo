# The ActivePapers Pharo edition

The Pharo edition of [ActivePapers](https://www.activepapers.org/) focuses on the documentation and user interface aspects of communicating computational science. It is based on the [Glamorous Toolkit](https://gtoolkit.com/), an innovative development environment for [Pharo](http://pharo.org/).

This package is very much work in progress. At this time, it does not support computation at all (but this will come soon). All there is for now is support for creating Wikis in Pharo classes. Such Wikis will be used for documenting reproducible computations in the near future.

To install in Pharo 7, execute the following lines in a playground:
```
Metacello new
    baseline: 'ActivePapers';
    repository: 'github://activepapers/activepapers-pharo/src';
    load.
```
Note that this will also install the Glamorous Toolkit, which is a rather large package. Installation can thus take anything from 15 to 30 minutes.

After installation, open a GToolkit playground (from the GToolkit menu), enter `APDocumentation`, and inspect it. This will open the main page of the Wiki documenting the ActivePapers Pharo edition.
