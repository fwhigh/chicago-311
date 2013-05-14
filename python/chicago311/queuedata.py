import csv
import numpy as np
from datetime import datetime,timedelta
import code
import geojson

class queueData:
    """
       queueData class
       define mock or real data
    """

    def __init__(self, 
                 mock=True, 
                 filename=None,
                 npts=1e2,
                 shape = 1., # = alpha = k, number of random events
                 rate = 1e-1, # = lambda, mean rate of events per unit time
                 maxdays = 360 * 3):

        self.mock = mock
        self.filename = filename
        if not self.mock and self.filename is None:
            raise RuntimeError("must specify filename")
        self.npts = npts
        self.rate = rate
        self.shape = shape
        self.maxdays = maxdays
        self.wait_time = []
        self.lat = []
        self.lon = []

    def get(self):

        if self.mock:
            # get mock data
            self.wait_time = np.random.gamma(self.shape, 1/self.rate, self.npts)
        else:
            # get real data
            csv_npts = self.file_len(self.filename)
            with open(self.filename, 'rb') as csvfile:
                csvreader = csv.DictReader(csvfile)
                all_wait_time = np.tile(-99,csv_npts)
                all_lat = np.tile(-99.0,csv_npts)
                all_lon = np.tile(-99.0,csv_npts)
                i=0
                for row in csvreader:
                    if row['Status'] == 'Completed':
                        creation_date = datetime.strptime(row['Creation Date'], '%m/%d/%Y')
                        completion_date = datetime.strptime(row['Completion Date'], '%m/%d/%Y')
                        all_wait_time[i] = (completion_date - creation_date).days
                        if row['Latitude'] != '':
                            all_lat[i] = row['Latitude']
                        if row['Longitude'] != '':
                            all_lon[i] = row['Longitude']
                    i=i+1
            subi = (all_wait_time > 0) & (all_wait_time < self.maxdays) & (all_lat != -99) & (all_lon != -99)
            self.wait_time=all_wait_time[subi]
            self.lat=all_lat[subi]
            self.lon=all_lon[subi]
            if self.npts > 1:
                rani = np.random.random_integers(0,high=len(self.wait_time)-1,size=self.npts)
                self.wait_time=self.wait_time[rani]
                self.lat=self.lat[rani]
                self.lon=self.lon[rani]
            if self.npts > 1 and self.npts != len(self.wait_time):
                raise RuntimeError("something wrong")

            self.shape = None
            #mean = None
            self.rate = None

    def gammaMean(self):
        return 10.*self.shape # mean duration for k events to happen


    def file_len(self,fname):
        with open(fname) as f:
            for i, l in enumerate(f):
                pass
        return i + 1

    def write_geojson(self,
                      filename):
        all_p=[]
        for i in np.arange(len(self.lat)):
            p = geojson.Feature(properties={'time': "%s" % (self.wait_time[i])},
                                geometry=geojson.Point([self.lon[i], self.lat[i]]))
            all_p.append(p)
        json=geojson.FeatureCollection(features=all_p)
        with open(filename, 'w') as f:
            f.write(geojson.dumps(json))
        code.interact(local=locals())
        exit(0)
