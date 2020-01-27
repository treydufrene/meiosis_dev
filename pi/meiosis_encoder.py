#!/usr/bin/env python
# -*- coding: utf-8 -*-

from gpiozero import DigitalInputDevice as DID
import gpiozero as gpio

class Encoder:
    def __init__(self):
        self.data = []
        self.counting = False
        self.total = 0

    def initEnc(self, encPin):
        return DID(encPin)

    def inc(self, encDev):
        counting = True
        total = self.total
        while(counting):
            encDev.wait_for_active()
            total = total + 1
            print(total)
            encDev.wait_for_inactive()

    def reset(self):
        self.counting = False
        self.total = 0


''' 

a = DID('GPIO17')
z = DID('GPIO18')
total = 0
counting = True
def reset():
    counting = False
z.when_activated = reset()
while(1):
    while(counting):
        a.wait_for_active()
        total = total + 1
        a.wait_for_inactive()
    total = 0
    counting = True


#z.when_deactivated = count()
#print(total)
'''

'''
prev = 0
total = 0

while(1):
    if a.value != prev:
        total = total + 1
        prev = a.value
    print(total)
'''
