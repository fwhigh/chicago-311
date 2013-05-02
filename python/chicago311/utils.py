import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm

def percentile(N, percent, key=lambda x:x):
    """
    Find the percentile of a list of values.

    @parameter N - is a list of values. Note N MUST BE already sorted.
    @parameter percent - a float value from 0.0 to 1.0.
    @parameter key - optional key function to compute value from each element of N.

    @return - the percentile of the values
    """
    #if not N:
    #    return None
    k = (len(N)-1) * percent
    f = np.floor(k)
    c = np.ceil(k)
    if f == c:
        return key(N[int(k)])
    d0 = key(N[int(f)]) * (c-k)
    d1 = key(N[int(c)]) * (k-f)
    return d0+d1


def scatterplot(data, data_name, p0 = None):
    """Makes a scatterplot matrix:
    Inputs:
        data - a list of data [dataX, dataY,dataZ,...]; 
               all elements must have same length 
        data_name - a list of descriptions of the data;
                    len(data) should be equal to len(data_name)
    Output:
        fig - matplotlib.figure.Figure Object
    """
    N = len(data) 
    fig = plt.figure() 
    for i in range(N):
        for j in range(N): 
            if i >= j:
                ax = fig.add_subplot(N,N,i*N+j+1) 
                if j == 0 and i != 0: 
                    ax.set_ylabel(data_name[i],size='9')
                if i == N-1 and j != N-1: 
                    ax.set_xlabel(data_name[j],size='9')
                if i == j: 
                    plt.xlim([np.min(data[i]), np.max(data[i])])
                    ax.hist(data[i], 30,facecolor="DodgerBlue",histtype='step',fill=True) 
                    limits = ax.axis()
                    if p0 is not None:
                        ax.plot([p0[i],p0[i]], limits[2:], '-', color='FireBrick', linewidth=3)
                    plt.title(data_name[i],size='9')
                else: 
                    plt.ylim([np.min(data[i]), np.max(data[i])])
                    plt.xlim([np.min(data[j]), np.max(data[j])])
                    H, xedges, yedges = np.histogram2d(data[j], data[i],
                                                       bins=(np.linspace(np.min(data[j]), np.max(data[j]), 30),
                                                             np.linspace(np.min(data[i]), np.max(data[i]), 30)))

                    extent = [xedges[0], xedges[-1], yedges[0], yedges[-1]]
                    im = plt.imshow(H, 
                                    extent=extent, 
                                    origin='lower',
                                    interpolation='nearest',
                                    cmap=cm.Blues,
                                    aspect='auto')
                    if p0 is not None:
                        ax.scatter(p0[j],p0[i],c='FireBrick',marker='D')

    return fig
