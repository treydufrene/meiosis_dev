#!/usr/bin/env python
# -*- coding: utf-8 -*-

from gpiozero import DigitalInputDevice as DID
import gpiozero as gpio

state = {"0010":1, "1011":1, "1101":1, "0100":1, "0001":-1, "0111":-1, "1110":-1, "1000":-1}
last = "00"

class Encoder:
    def __init__(self):
        self.data = []
        self.counting = False
        self.total = 0

    def initEnc(self, encPin):
        return DID(encPin)

    def encoderCallback(self):
        global angle, state, last
        current = str(GPIO.input(17)) + str(GPIO.input(18))
        key = last + current
        if key in state:
            direction = state[key]
            last = current
            angle += direction

