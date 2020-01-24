import numpy as np
import math as m

def rotx(theta):
    return np.matrix([[1,0,0],[0,m.cos(theta),-m.sin(theta)],[0,m.sin(theta),m.cos(theta)]])

def roty(theta):
    return np.matrix([[m.cos(theta),0,m.sin(theta)],[0,1,0],[-m.sin(theta),0,m.cos(theta)]])

def rotz(theta):
    return np.matrix([[m.cos(theta),-m.sin(theta),0],[m.sin(theta),m.cos(theta),0],[0,0,1]])

def skew(r):
    return np.matrix([[0,-r[2],r[1]],[r[2],0,-r[0]],[r[1],r[0],0]])
