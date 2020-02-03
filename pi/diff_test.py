#!/usr/bin/env python
# -*- coding: utf-8 -*-
#changes
"""messy script to test differential"""
#github test

import meiosis_encoder as ME
import RPi.GPIO as GPIO
import meiosis_servo as MS
import time

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
    global angle

    GPIO.setmode(GPIO.BCM)
    GPIO.setup(17, GPIO.IN)
    GPIO.setup(18, GPIO.IN)

    GPIO.add_event_detect(17, GPIO.BOTH)
    GPIO.add_event_callback(17, encoderCallback)
    GPIO.add_event_detect(18, GPIO.BOTH)
    GPIO.add_event_callback(18, encoderCallback)

    try:
        print("Entering Loop, press Ctrl-C to escape!")
        time.sleep(2)
        while True:
            rev = float(360)/float(10000) * angle
            print("Encoder Position:", rev)
            print('Zeroing Servos')
            ser.goTo(0,0)
            ser.goTo(1,0)
            time.sleep(5)
            print("The servos are here:")
            print(ser.getPos(0))
            print(ser.getPos(1))
            print("Resetting encoder")
            angle = 0
            rev = float(360)/float(10000) * angle
            print(rev)
            print('Setting Velocities')
            ser.setVel(0,100)
            ser.setVel(1,100)
            print('Going to 2000')
            ser.goTo(0,2000)
            ser.goTo(1,2000)
            time.sleep(5)
            print("The servos are here:")
            print((float(ser.getPos(0))/float(4096)) * 360)
            print((float(ser.getPos(0))/float(4096)) * 360)
            print("The encoder is here:")
            rev = float(360)/float(10000) * angle
            print(rev)
            time.sleep(10)


    except KeyboardInterrupt:
        print("\nInterrupted!")

    print("Cleaning GPIO...")
    GPIO.cleanup()
    print("Disabling Servo Interface...")
    ser.close()
if __name__=="__main__":
    main()
