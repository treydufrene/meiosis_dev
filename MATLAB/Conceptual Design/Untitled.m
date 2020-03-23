clear
close 
clc

syms t4 t5 t6

R1 = rotz(t4)*rotx(-sym(pi)/2)*rotz(t5)*rotx(sym(pi)/2)*rotz(t6)

R2 = rotz(t4)*roty(t5)*rotz(t6)
