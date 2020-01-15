#!/usr/bin/env python

from gpiozero import DigitalInputDevice as DID
import gpiozero as gpio

a = DID('GPIO17')
total = 0

while(1):
    a.wait_for_active()
    total = total + 1
    a.wait_for_inactive()
    print(total)

'''
prev = 0
total = 0

while(1):
    if a.value != prev:
        total = total + 1
        prev = a.value
    print(total)
'''
