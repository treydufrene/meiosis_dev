#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""messy two link manipulator testing"""

import meiosis_encoder as ME
import RPi.GPIO as GPIO 
import meiosis_servo as MS
import time
from math import *

ser = MS.Servo()
ser.initialize()

#ser.setRes(0,4)
#ser.setRes(1,4)
#ser.setMultiturn(0, True)
#ser.setMultiturn(1, True)

IDs = [0,1]
xoff = 0
yoff = 0

def twoLinkIK(x,y):
    l1 = 265.0 
    l2 = 165.0
    D = (x**2 + y**2 - l1**2 - l2**2)/(2*l1*l2)
    theta2 = atan2(sqrt(1.0 - D**2),D)
    theta1 = atan2(y,x) - atan2(l2*sin(theta2),l1+l2*cos(theta2))
    print(degrees(theta1),degrees(theta2))
    return [degrees(theta1),degrees(theta2)]

def zeroArm():
    print("Init:")
    print(ser.getPos(0),ser.getPos(1))
    print("servo 0 offset: ")
    print(ser.setOffset(0,ser.getPos(0)))
    print("servo 1 offset: ")
    print(ser.setOffset(1,ser.getPos(1)))
    print("New:")
    print(ser.getPos(0),ser.getPos(1))

def moveArm(gamma):
    #global IDs
    ser.setJA(IDs, gamma)
    while (ser.anyMoving(IDs)):
        pass
    return True

def pick(x,y):
    #global xoff, yoff
    moveArm(twoLinkIK(x-xoff,y-yoff))

def place(x,y):
    moveArm(twoLinkIK(x,y))

try:
    print("Entering Loop, press Ctrl-C to escape!")
    pos = ser.getPos(0)*ser.readRes(0)
    try:
        while True:
            raw_input()
            ser.setPos(0,pos)
            pos += 50

    except KeyboardInterrupt:
        print("interrupted")
    
    
    '''
    print(ser.getPos(0))
    ser.setPos(0,10000)
    while ser.moving(0):
        pass
    print(ser.getPos(0))
    #pick(250,50)
    #place(-250,50)
'''
except KeyboardInterrupt:
    print("\nInterrupted!")

print("Disabling Servo Interface...")
ser.close()
