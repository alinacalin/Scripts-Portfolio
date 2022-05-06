#!/bin/python3

import math
import os
import re
import sys


# read dimensions of the matrix
first_multiple_input = input().rstrip().split()
n = int(first_multiple_input[0])
m = int(first_multiple_input[1])

# read the matrix
matrix = []
for _ in range(n):
    matrix_item = input()
    matrix.append(matrix_item)

# chage lines with columns in the matrix 
res = [line[i] for i in range(m) for line in matrix]
res = ''.join(res)
# this is the equivalent of:
#res=""
#for i in range(m):
#    for j in range(n):
#        res+=str(matrix[j][i])
 
# decode string by replacing special characters and/or space between alphanumeric words with only one space.
x = re.sub(r"([a-zA-Z0-9]+)[!@#$%&\s]+(?=[a-zA-Z0-9]+)", r"\1 ", res)
# use a group that matches a word, then any special character at least once, then lookaround assertion for another word but without consuming it, 
# then and keep the first group and a space, leave the second word for a new matching attempt. 
print(x)
