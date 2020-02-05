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

ser.setRes(0,4)
ser.setRes(1,4)
ser.setMultiturn(0, True)
ser.setMultiturn(1, True)

def twoLinkIK(x,y):
    l1 = 265.0 
    l2 = 165.0
    D = (x**2 + y**2 - l1**2 - l2**2)/(2*l1*l2)
    theta2 = atan2(sqrt(1.0 - D**2),D)
    theta1 = atan2(y,x) - atan2(l2*sin(theta2),l1+l2*cos(theta2))
    return [degrees(theta1),degrees(theta2)]

try:
    print("Entering Loop, press Ctrl-C to escape!")
    time.sleep(1)
    gamma = twoLinkIK(0.0,430.0)
    print(gamma)
    ser.setJA([0,1], gamma)
    while ser.moving(1) or ser.moving(0):
        pass
    time.sleep(1)
    print(ser.getPos(0))
    print(ser.getPos(1))
    #time.sleep(1)
    ser.setJA([0,1],[0,0])
    while ser.moving(1) or ser.moving(0):
        pass
    time.sleep(1)
    print(ser.getPos(0))
    print(ser.getPos(1))

except KeyboardInterrupt:
    print("\nInterrupted!")

print("Disabling Servo Interface...")
ser.close()
