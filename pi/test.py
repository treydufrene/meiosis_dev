#!/usr/bin/env python
# -*- coding: utf-8 -*-

import meiosis_servo as MS
import meiosis_encoder as ME

Enc = ME.Encoder()
enc = Enc.initEnc('GPIO17')

ser = MS.Servo()
ser.initialize()
#ser.goTo(1,500)

while 1:
    print(ser.getPos(1))
    print(Enc.inc(enc))

ser.close()
#Enc.inc(enc)



