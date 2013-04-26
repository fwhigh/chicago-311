chicago-311
===========

Chicago 311 data science

Getting started
---------------

Data needed for this project is served with Dropbox.

https://www.dropbox.com/sh/4ruxc1fq1qeifdz/6MAvngnhTb

Once you've pulled the github repo, add the following line to your local .Renviron (can be the one in your home directory, which is always parsed, or one in the local directory you will be running R from):

	CHICAGO311ROOT=<your-repo-home>/chicago-311
	CHICAGO311DATA=<your-dropbox-home>/chicago-311-data

Now in R, run the following lines to load functions, cache the main data tables, and run some tests.

	source('init.R')
	run_all_tests()
