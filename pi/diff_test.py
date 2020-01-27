#!/usr/bin/env python
# -*- coding: utf-8 -*-

import meiosis_servo as MS
import meiosis_encoder as ME

Enc = ME.Encoder()
enc = Enc.initEnc('GPIO17')
ser = MS.Servo()
ser.initialize()

#ser.goTo(1,500)
Enc.inc(enc)



ser.close()




