import numpy as np
# import math as m
from math import *

class matrixOp:
    def rotx(theta):
        return np.matrix([[1,0,0],[0,cos(theta),-sin(theta)],[0,sin(theta),cos(theta)]])

    def roty(theta):
        return np.matrix([[cos(theta),0,sin(theta)],[0,1,0],[-sin(theta),0,cos(theta)]])

    def rotz(theta):
        return np.matrix([[cos(theta),-sin(theta),0],[sin(theta),cos(theta),0],[0,0,1]])

    def skew(r):
        return np.matrix([[0,-r[2],r[1]],[r[2],0,-r[0]],[r[1],r[0],0]])
