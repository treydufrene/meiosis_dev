#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""messy two link manipulator testing"""

import meiosis_encoder as ME
import RPi.GPIO as GPIO 
import meiosis_servo as MS
import time

ser = MS.Servo()
ser.initialize()

ser.setRes(1,4)
ser.setMultiturn(1, True)

try:
    print("Entering Loop, press Ctrl-C to escape!")
    time.sleep(1)
    ser.setPos(1,4000)
    print(ser.readRes(1))
    while ser.moving(1):
        pass
    print(ser.getPos(1))
    time.sleep(1)
    ser.setPos(1,0)
    while ser.moving(1):
        pass
    print(ser.getPos(1))

except KeyboardInterrupt:
    print("\nInterrupted!")

print("Disabling Servo Interface...")
ser.close()
