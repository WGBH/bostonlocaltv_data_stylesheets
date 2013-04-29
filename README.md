## XSL Stylesheets for Boston TV News Digital Library

These stylesheets are used to transform XML exported from from various databases to a common schema where they can then be ingested into the [Boston TV News Digital Library](http://bostonlocaltv.org).

Code is on github at [github.com/wgbh/bostonlocaltv](https://github.com/wgbh/bostonlocaltv).

This work was done amidst a maelstrom of "where's the data?" chaos, e.g.

* WHDH data in database file named without that moniker but with "BPL" instead;
* WCVB data in two database files, neither named to mention "WCVB," both with identical views and banners beginning "NHF:" but only one named so; 
* CCTV data in a database file named "Programs"
* some databases hosted properly, others on shared drive (hello corruption!)

Ergo, it's easily possible to produce the wrong data or version of it without referring to an authority list of some kind.  

See the [Collection Details](http://htmlpreview.github.io/?https://github.com/WGBH/bostonlocaltv_data_stylesheets/blob/master/collection_details.html) page for more details.
