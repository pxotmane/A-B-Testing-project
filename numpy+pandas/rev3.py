import pandas as pd
import numpy as np
from pandas import Series, DataFrame

dts = pd.DataFrame(np.random.randn(4, 4), columns=list('abcd'), index=['Utah', 'Ohio', 'Texas', 'Oregon'])
stat = dts.describe()
print(stat)
