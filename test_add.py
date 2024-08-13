import numpy as np
import cuda_plugin

print('hello')

a=cuda_plugin.add(3,4)
print(a)


a=np.mat([2,3,4])
b=np.mat([2,3,4])
c=cuda_plugin.vectorAdd1(a,b)
print(c)

