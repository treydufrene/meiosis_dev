clear;close all;clc

gammad = [0;pi/2;0;pi/2;pi/2;pi/2];

[oe, phie, qc] = meiosisFK(gammad)
gamma = meiosisIK(oe, phie, qc)
% meiosis_draw(gamma)

% gamma