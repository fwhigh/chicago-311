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

To run Python scripts, you must set the following environment variable.

	setenv CHICAGO311DATA <your-dropbox-home>/chicago-311-data

Then 

	cd python
	response_time_mcmc.py


Recreate Discovery Session
--------------------------

	source('Discovery.R')

Additional resources
--------------------

http://servicetracker.cityofchicago.org/

https://github.com/derekeder/311-explorer

http://www.smartchicagocollaborative.org/the-launch-of-open311-in-chicago/

http://www.311.fm/

http://311labs.org/experiments/dailybrief

http://open311status.herokuapp.com/

http://dailybrief.311labs.org/

http://open311.org/
