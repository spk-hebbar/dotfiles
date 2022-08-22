#Robin Jarry's script to calculate hexmask

import sys

l  = len(sys.argv)
n = 0
for i in range(1, l):
    n |= 1 << int(sys.argv[i])
print(hex(n))
