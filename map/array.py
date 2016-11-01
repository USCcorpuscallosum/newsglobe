import cv2
import numpy as np
import sys   
from numpy import mean
from matplotlib import pyplot as plt
src = cv2.imread("world_map.png");

y,x,channel = src.shape
print y , x

#144, 250
pixel = 144
array = np.zeros((pixel,pixel*2),np.uint8)
step = y / pixel

print step
print step * pixel
row = pixel
col = pixel * 2
#change the size of the original img
img = cv2.resize\
          (src,(step * col, step * row),interpolation=cv2.INTER_CUBIC)
print img.shape
# 255 128 0
judge = step*step*0.15
for i in range(row):
    for j in range(col):
        court = 0
        for m in range(step):
            for n in range(step):
                y = i * step + m
                x = j * step + n
                if img[y,x,0] == 255 and\
                   img[y,x,1] == 128 and\
                   img[y,x,2] == 0:
                    court = court + 1
        if court > judge:
            array[i,j] = 0
        else:
            array[i,j] = 1

    
print array
length = 5
result = np.zeros((pixel*length,pixel*2*length,3), np.uint8)
for i in range(pixel):
    for j in range(pixel*2):
        if array[i,j] == 1:
            cv2.rectangle(result, (j*length,i*length), (j*length + length-1, i*length + length-1), (0, 255, 255), -1)  
        else:
            cv2.rectangle(result, (j*length,i*length), (j*length + length-1, i*length + length-1), (255, 0 ,0), -1)
cv2.imshow("world map",result)
np.savetxt("world_map.txt",array,fmt='%1d');

cv2.waitKey(0)

