#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""messy script to test differential"""

import meiosis_encoder as ME
import RPi.GPIO as GPIO 
import sys

angle = 0
#counting = True

def countA(self):
    global angle
    if GPIO.input(17):
        angle = angle + 1
    else:
        angle = angle - 1

def countB(self):
    global angle
    if not GPIO.input(18):
        angle = angle + 1
    else:
        angle = angle - 1


'''
def reset(self):
    global total
    global counting
    global turnOver
    turnOver = turnOver + 1
    if turnOver == 2:
        counting = False
    else: 
        total = 0
'''

def main():
    #pinA = 17
    #pinB = 18
    global angle
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(17, GPIO.IN)
    GPIO.setup(18, GPIO.IN)
    
    GPIO.add_event_detect(17, GPIO.RISING)
    GPIO.add_event_callback(17, countA)
    GPIO.add_event_detect(18, GPIO.RISING)
    GPIO.add_event_callback(18, countB)
    
    while True:
        print(angle)
        
    GPIO.cleanup()

if __name__=="__main__":
    main()


