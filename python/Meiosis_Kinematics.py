import numpy as np
import math as m
from meiosis_utils import matrixOp as mf


r1 = np.matrix([[0.00000],[0.00000],[0.12275]])
r2 = np.matrix([[0.00000],[0.00000],[0.00000]])
r3 = np.matrix([[0.00000],[0.26000],[0.00000]])
r4 = np.matrix([[0.00000],[0.20000],[0.00000]])
r5 = np.matrix([[0.00000],[0.07000],[0.00000]])
r6 = np.matrix([[0.00000],[0.09600],[0.00000]])

def FK(gamma):
    T1 = mf.rotz(gamma[0])
    T2 = T1*mf.rotx(gamma[1])
    T3 = T2*mf.rotx(gamma[2])
    T4 = T3*mf.roty(gamma[3])
    T5 = T4*mf.rotx(gamma[4])
    T6 = T5*mf.roty(gamma[5])

    Ir1 = r1
    Ir2 = Ir1 + T1*r2
    Ir3 = Ir2 + T2*r3
    Ir4 = Ir3 + T3*r4
    Ir5 = Ir4 + T4*r5
    Ir6 = Ir5 + T5*r6

    return Ir6

def IK(pos,R):
    pi = m.pi
    L1 = r1[2]
    L2 = r3[1]
    L3 = r4[1] + r5[1]
    npos = pos - R*r6
    xc = npos[0]
    yc = npos[1]
    zc = npos[2]

    #Inverse Position
    t1 = m.atan2(xc,yc) - pi/2
    if t1 < -pi:
        t1 = t1 + 2*pi
    if t1 > pi:
        t1 = t1 - 2*pi
    D = (xc**2 + yc**2 + (zc - L1)**2 - L2**2 - L3**2)/(2*L2*L3)
    t3 = m.atan2(-m.sqrt(1 - D**2),D)
    t2 = m.atan2(zc - L1, m.sqrt(xc**2 + yc**2) - atan2(L3*m.sin(t3), L2 + L3*cos(t3)))

    #Inverse Orientation
    T3 = mf.rotz(t1)@mf.rotx(t2)@my.rotx(t3)
    T = T.I*R
    t6 = m.atan2(T[1,0],-T[1,2])
    t4 = m.atan2(T[0,1],T[2,1])
    while t4 > pi/2:
        t4 -= pi
    while t4 < -pi/2:
        t4 += pi

    if t6 < 0:
        t6 += 2*pi

    if (m.sin(t4) > -10e-6) and (sin(t4) < 10e-6):
        t5 = m.atan2(T[2,1]/m.cos(t4),T[1,1])
    else:
        t5 = m.atan2(T[0,1]/m.sin(t4),T[1,1])

    return np.matrix([[t1],[t2],[t3],[t4],[t5],[t6]])
