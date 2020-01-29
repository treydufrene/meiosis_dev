#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""messy script to total up encoder ppr"""

import meiosis_encoder as ME
import RPi.GPIO as GPIO 

total = 0
counting = True
turnOver = 0

def countA(self):
    global total
    total = total + 1

def reset(self):
    global total
    total = 0
    global counting
    global turnOver
    turnOver = turnOver + 1
    if turnOver == 2:
        counting = False

def main():
    global total
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(17, GPIO.IN)
    GPIO.setup(18, GPIO.IN)
    
    GPIO.add_event_detect(17, GPIO.BOTH)
    GPIO.add_event_callback(17, countA)

    GPIO.add_event_detect(18, GPIO.RISING)
    GPIO.add_event_callback(18, reset)
    
    while counting:
        print(total)
        
    GPIO.cleanup()

if __name__=="__main__":
    main()



