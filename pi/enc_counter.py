#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""messy script to total up encoder ppr"""

import meiosis_encoder as ME
import RPi.GPIO as GPIO 
import sys
sys.excepthook = lambda *args: None

total = 0
counting = True
turnOver = 0

def countA(self):
    global total
    total = total + 1

def reset(self):
    global total
    global counting
    global turnOver
    turnOver = turnOver + 1
    if turnOver == 2:
        counting = False
    else: 
        total = 0

def main():
    global total
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(17, GPIO.IN)
    GPIO.setup(27, GPIO.IN)
    GPIO.setup(18, GPIO.IN)
    
    GPIO.add_event_detect(17, GPIO.BOTH)
    GPIO.add_event_callback(17, countA)
    GPIO.add_event_detect(27, GPIO.BOTH)
    GPIO.add_event_callback(27, countA)

    GPIO.add_event_detect(18, GPIO.RISING)
    GPIO.add_event_callback(18, reset)
    
    while counting:
       pass

    print(total)
        
    GPIO.cleanup()

if __name__=="__main__":
    main()



