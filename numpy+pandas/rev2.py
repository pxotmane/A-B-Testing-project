import pandas as pd
import numpy as np
from pandas import Series, DataFrame
dts1 = pd.DataFrame(np.arange(16.).reshape(4, 4), columns = ['one', 'two', 'three', 'four'], index = ['a', 'b', 'c', 'd'])
#dts.columns.name = 'numbers'; dts.index.name = 'letters'
dts2  = pd.DataFrame(np.arange(12.).reshape(3, 4), columns = ['one', 'two', 'three', 'four'], index = ['a', 'b', 'c'])
s1 = dts1.iloc[0]
s2 = dts1['three']
#slice = dts.iloc[[1,2], [3,0,1]]#dts.iloc[:, :3][dts.three>5]
#dts1.add(dts2, fill_value=0)
print(dts1.sub(s2, axis = 'index'))
