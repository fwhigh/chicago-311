#!/usr/bin/env python
"""
Modeling response times.

"""

#from __future__ import print_function
from optparse import OptionParser
import chicago311.utils as utils
import chicago311.init as c
from chicago311.queuedata import queueData
import numpy as np
import emcee
import scipy.special as sps
import time
import matplotlib.pyplot as plt
from datetime import datetime,timedelta
import code
import statsmodels.api as sm

### get commandline options
parser = OptionParser()
parser.set_defaults(mock=False,
                    filename=c.datadir+'/raw/311_Service_Requests_-_Graffiti_Removal.csv',
                    figext='pdf',
                    npts=1e2)
parser.add_option("-f", "--file", dest="filename",
                  help="CSV file containing start and stop time data", 
                  metavar="FILE")
parser.add_option("-m", "--mock", dest="mock",
                  help="generate mock data?", 
                  action="store_true")
parser.add_option("-n", "--npts", dest="npts",
                  help="Number of data points to use, deafult 1e2. Set to -1 to include all real data", 
                  type='float',
                  metavar="N")
parser.add_option("-e", "--figext", dest="figext",
                  help="Extension type of figure, default pdf", 
                  metavar="EXT")
(options, args) = parser.parse_args()
# validate commandline options
if options.mock and options.npts <= 1:
    raise RuntimeError('Must have npts > 1 when generating mock data')


### get the data
dat = queueData(mock=options.mock,
                filename=options.filename,
                npts=options.npts)
dat.get()

### do mcmc
# We'll sample a 2 parameter Gamma distribution
ndim = 2

# Here are the Monte Carlo steps
MCtype = 'aies' # Affine-invariant ensemble sampler
#MCtype = 'mh' # Metropolis-Hastings
nsteps=1e4
nburnin=nsteps/10*2
nwalkers = 10 # Only used with AIES

cov  = 0.5-np.random.rand(ndim**2).reshape((ndim, ndim))
cov  = np.triu(cov)
cov += cov.T - np.diag(cov.diagonal())
cov  = np.dot(cov,cov)

#code.interact(local=locals())
#exit(0)

# Define probability distribution to sample.
def lnprob(p):
    shape = p[0]
    rate = p[1]
    lnlike = float('nan')
    if (shape >= 1e-15 and rate >= 1e-15):
        lnlike = np.sum(np.log(dat.wait_time**(shape-1)*
                               (np.exp(-dat.wait_time*rate) /
                                (sps.gamma(shape)*
                                 (1/rate)**shape))))
    return lnlike

# Choose an initial set of positions for the walkers.
if MCtype == 'aies':
    p0 = [np.random.rand(ndim) for i in xrange(nwalkers)]
elif MCtype == 'mh':
    p0 = np.random.rand(ndim)

# Initialize the sampler with the chosen specs.
if MCtype == 'aies':
    sampler = emcee.EnsembleSampler(nwalkers, ndim, lnprob, threads=4)
elif MCtype == 'mh':
    sampler = emcee.MHSampler(cov, ndim, lnprob)
else:
    raise RuntimeError('MCtype must be aies or mh')

# Run steps as a burn-in.
start = time.clock()
pos, prob, state = sampler.run_mcmc(p0, nburnin)

# Reset the chain to remove the burn-in samples.
sampler.reset()

# Starting from the final position in the burn-in chain, sample for 1000
# steps.
sampler.run_mcmc(pos, nsteps, rstate0=state)
elapsed = (time.clock() - start)
print("elapsed time",elapsed,"seconds")

# Print out the mean acceptance fraction. In general, acceptance_fraction
# has an entry for each walker so, in this case, it is an N-dimensional
# vector.
print("Mean acceptance fraction:", np.mean(sampler.acceptance_fraction))

# If you have installed acor (http://github.com/dfm/acor), you can estimate
# the autocorrelation time for the chain. The autocorrelation time is also
# a vector with 10 entries (one for each dimension of parameter space).
try:
    print("Autocorrelation time:", sampler.acor)
except ImportError:
    print("You can install acor: http://github.com/dfm/acor")

# Finally, you can plot the projected histograms of the samples using
# matplotlib as follows (as long as you have it installed).
#plt.hist(sampler.flatchain[:,0], 100)
#plt.show()



### make some figures

# scatterplot of posterior probabilities
if dat.mock:
    p0=[dat.shape, dat.rate]
else:
    p0=None
fig = utils.scatterplot([sampler.flatchain[:,0], sampler.flatchain[:,1]], 
                        ['shape', 'rate (1/min)'], 
                        p0=p0)
fig.savefig(c.plotdir+'/graffiti_completion_time_scatterplot.'+options.figext)



# probability density of data and median distribution model
fig2 = plt.figure() 
count, bins, ignored = plt.hist(dat.wait_time,
                                50,
                                normed=True,
                                facecolor="#E69F00",
                                log=True,
                                histtype='step',
                                fill=False)
limits = plt.axis()
t = np.arange(0, limits[1], 0.01)
if dat.mock:
    y_true = t**(dat.shape-1)*(np.exp(-t*dat.rate) /
                              (sps.gamma(dat.shape)*
                               (1/dat.rate)**dat.shape))
shape_est = np.median(sampler.flatchain[:,0])
rate_est = np.median(sampler.flatchain[:,1])
y_est = t**(shape_est-1)*(np.exp(-t*rate_est) /
                            (sps.gamma(shape_est)*
                             (1/rate_est)**shape_est))
p2, = plt.plot(t, y_est, linewidth=2, color='DodgerBlue')
if dat.mock:
    p1, = plt.plot(t, y_true, linewidth=6, color='FireBrick')
    plt.legend([p1, p2], ["Pure exponential distribution", "Fitted distribution"])
else:
    plt.legend([p2], ["Fitted distribution"])
plt.xlim([0,np.max(dat.wait_time)])
plt.ylabel('Probability (arb. units)',size='12')
plt.xlabel('Response time (days)',size='12')
plt.semilogy()
fig2.savefig(c.plotdir+'/graffiti_completion_time_hist.'+options.figext)



# empirical cumulative distribution function
xlim = [0,400]
xtextpos = 300
fig3 = plt.figure()
ecdf = sm.distributions.ECDF(dat.wait_time)
x_ecdf = np.linspace(min(dat.wait_time), max(dat.wait_time))
y_ecdf = ecdf(x_ecdf)
plt.plot(x_ecdf,y_ecdf*100,'-',color='blue',linewidth=3)
plt.xlim(xlim)
plt.ylim([0,100])
plt.ylabel('Cumulative fraction (%)',size='12')
plt.xlabel('Response time (days)',size='12')
quantiles = [1,5,10,25,50,75,90,95,99]
positions = np.asarray(range(len(quantiles)))/float(len(quantiles)-1)*30+50
plt.text(xtextpos, 85, "Percentile", fontsize=12, horizontalalignment='right')
plt.text(xtextpos, 85, "    Time (days)", fontsize=12, horizontalalignment='left')
x_sort=np.sort(dat.wait_time)
for i in range(len(quantiles)):
    q=quantiles[i]
    p = utils.percentile(x_sort,q/100.)
    plt.text(xtextpos,positions[i], "%2i" % q, fontsize=12, horizontalalignment='right')
    plt.text(xtextpos,positions[i], "    %2i" % p, fontsize=12, horizontalalignment='left')
fig3.savefig(c.plotdir+'/graffiti_completion_time_ecdf.'+options.figext)
