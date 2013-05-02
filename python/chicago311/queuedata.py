import csv
import numpy as np
from datetime import datetime,timedelta

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

        if self.mock:
            # Input model parameters
            mean = 10.*self.shape # mean duration for k events to happen
            self.rate = self.shape/mean # = lambda
            self.wait_time = np.random.gamma(self.shape, 1/rate, self.npts)
        else:
            # get real data
            with open(self.filename, 'rb') as csvfile:
                csvreader = csv.DictReader(csvfile)
                csv_npts = 339476
                all_wait_time = np.tile(-99,csv_npts)
                i=0
                for row in csvreader:
                    if row['Status'] == 'Completed':
                        creation_date = datetime.strptime(row['Creation Date'], '%m/%d/%Y')
                        completion_date = datetime.strptime(row['Completion Date'], '%m/%d/%Y')
                #print(creation_date,completion_date)
                        all_wait_time[i] = (completion_date - creation_date).days
                #print(response_time)
                #print(row['Completion Date'] - row['Creation Date'])
                    i=i+1
            self.wait_time=all_wait_time[all_wait_time > 0]
            self.wait_time=self.wait_time[self.wait_time < self.maxdays]
            if self.npts > 1:
                self.wait_time=self.wait_time[np.random.random_integers(0,high=len(self.wait_time)-1,size=self.npts)]
            if self.npts != len(self.wait_time):
                raise RuntimeError("something wrong")

            self.shape = None
            mean = None
            self.rate = None


