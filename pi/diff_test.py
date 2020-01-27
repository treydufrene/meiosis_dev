#!/usr/bin/env python
# -*- coding: utf-8 -*-

import meiosis_servo as MS
import meiosis_encoder as ME
import time 

#Enc = ME.Encoder()
#enc = Enc.initEnc('GPIO17')
ser = MS.Servo()
ser.initialize()

ser.goTo(0,600)
#ser.setVel(0, 500)
#time.sleep(2)
#ser.close()

#Enc.inc(enc)

