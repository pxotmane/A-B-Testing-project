import pandas as pd
import numpy as np
from pandas import Series, DataFrame
sdata1 = {'Ohio': 35000, 'Texas': 71000, 'Oregon': 16000, 'Utah': 5000}
data1 = {'state': ['Ohio', 'Ohio', 'Ohio', 'Nevada', 'Nevada', 'Nevada'], 'year': [2000, 2001, 2002, 2001, 2002, 2003], 'pop': [1.5, 1.7, 3.6, 2.4, 2.9, 3.2]}
#states = ['California', 'Ohio', 'Oregon', 'Texas', 'Utah']
obj1 = pd.Series(sdata1)
obj1.name = 'population'
obj1.index.name = 'states'
dtf = pd.DataFrame(data1)

frame2 = pd.DataFrame(data1, columns=['year', 'state', 'pop', 'debt'], index=['one', 'two', 'three', 'four', 'five', 'six'])
#frame2['debt'] = 6.5
#frame2['debt'] = np.arange(6.)
#frame2['esthern'] = frame2['state'] == 'Ohio'

print(frame2.iloc[:, :3][frame2.pop  < 3])
