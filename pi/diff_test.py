#!/usr/bin/env python
# -*- coding: utf-8 -*-
#changes
"""messy script to test differential"""

import meiosis_encoder as ME
import RPi.GPIO as GPIO 
import meiosis_servo as MS

ser = MS.Servo()
ser.initialize()

angle = 0

state = {"0010":1, "1011":1, "1101":1, "0100":1, "0001":-1, "0111":-1, "1110":-1, "1000":-1}
last = "00"

def encoderCallback(self):
    global angle, state, last
    current = str(GPIO.input(17)) + str(GPIO.input(18))
    key = last + current
    if key in state:
        direction = state[key]
        last = current
        angle += direction

def main():
    #pinA = 17
    #pinB = 18
    global angle

    GPIO.setmode(GPIO.BCM)
    GPIO.setup(17, GPIO.IN)
    GPIO.setup(18, GPIO.IN)
    
    GPIO.add_event_detect(17, GPIO.BOTH)
    GPIO.add_event_callback(17, encoderCallback)
    GPIO.add_event_detect(18, GPIO.BOTH)
    GPIO.add_event_callback(18, encoderCallback)
    
    while True:
        rev = float(360)/float(10000) * angle
        #print(rev)
        #print(angle)
        
    GPIO.cleanup()

if __name__=="__main__":
    main()


