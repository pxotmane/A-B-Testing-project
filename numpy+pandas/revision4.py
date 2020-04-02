import numpy as np
import pandas as pd
from pandas import Series, DataFrame
frame = pd.DataFrame(np.random.randn(4, 3), columns = list('ebd'), index=['alpha', 'delta', 'teta', 'gamma'])
f = lambda x: max(x) - min(x)
applyf = frame.apply(f, axis = 'columns')
#def f1(x):
    #return pd.Series([max(x), min(x)], index=['max', 'min'])
#AppF = frame.apply(f1, axis = 'columns')
formatF = lambda x: '%.2f' % x
AppF2 = frame.applymap(formatF)
Sort = AppF2.sort_index(axis= 1)
print(applyf)
