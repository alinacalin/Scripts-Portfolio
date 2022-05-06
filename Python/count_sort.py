#!/bin/python
import os
import sys
import math

# O(n) sorting by counting using an occurance array (for numbers under 100).

def countingSort(arr):
    # Write your code here
    f = [0]*100;
    for e in arr:
        f[e]+=1
    return f

if __name__ == '__main__':
    n = int(input().strip())
    arr = list(map(int, input().rstrip().split()))
    result = countingSort(arr)

    print(result)
    for i in range(len(result)):
        if result[i]>0:
            for j in range(result[i]):
                print(i, end=" ")
    print("Finished")
