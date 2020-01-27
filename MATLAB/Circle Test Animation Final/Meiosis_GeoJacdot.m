function Jdot = Meiosis_GeoJacdot(gamma,gammadot)

    t1 = gamma(1);
    t2 = gamma(2);
    t3 = gamma(3);
    t4 = gamma(4);
    t5 = gamma(5);
    t6 = gamma(6);
    
    t1dot = gammadot(1);
    t2dot = gammadot(2);
    t3dot = gammadot(3);
    t4dot = gammadot(4);
    t5dot = gammadot(5);
    t6dot = gammadot(6);

    Jdot = [ t2dot*cos(t2)*cos(t6)*sin(t3)*sin(t4) - t4dot*cos(t2)*cos(t3)*cos(t4)*cos(t6) + t2dot*cos(t3)*cos(t6)*sin(t2)*sin(t4) + t2dot*cos(t2)*cos(t3)*sin(t5)*sin(t6) + t3dot*cos(t2)*cos(t6)*sin(t3)*sin(t4) + t3dot*cos(t3)*cos(t6)*sin(t2)*sin(t4) + t3dot*cos(t2)*cos(t3)*sin(t5)*sin(t6) + t4dot*cos(t4)*cos(t6)*sin(t2)*sin(t3) + t5dot*cos(t2)*cos(t5)*sin(t3)*sin(t6) + t5dot*cos(t3)*cos(t5)*sin(t2)*sin(t6) + t6dot*cos(t2)*cos(t3)*sin(t4)*sin(t6) + t6dot*cos(t2)*cos(t6)*sin(t3)*sin(t5) + t6dot*cos(t3)*cos(t6)*sin(t2)*sin(t5) - t2dot*sin(t2)*sin(t3)*sin(t5)*sin(t6) - t3dot*sin(t2)*sin(t3)*sin(t5)*sin(t6) - t6dot*sin(t2)*sin(t3)*sin(t4)*sin(t6) - t6dot*cos(t2)*cos(t3)*cos(t4)*cos(t5)*cos(t6) + t2dot*cos(t2)*cos(t4)*cos(t5)*sin(t3)*sin(t6) + t2dot*cos(t3)*cos(t4)*cos(t5)*sin(t2)*sin(t6) + t3dot*cos(t2)*cos(t4)*cos(t5)*sin(t3)*sin(t6) + t3dot*cos(t3)*cos(t4)*cos(t5)*sin(t2)*sin(t6) + t4dot*cos(t2)*cos(t3)*cos(t5)*sin(t4)*sin(t6) + t5dot*cos(t2)*cos(t3)*cos(t4)*sin(t5)*sin(t6) + t6dot*cos(t4)*cos(t5)*cos(t6)*sin(t2)*sin(t3) - t4dot*cos(t5)*sin(t2)*sin(t3)*sin(t4)*sin(t6) - t5dot*cos(t4)*sin(t2)*sin(t3)*sin(t5)*sin(t6),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       t5dot*sin(t4)*sin(t5)*sin(t6) - t6dot*(cos(t4)*sin(t6) + cos(t5)*cos(t6)*sin(t4)) - t4dot*(cos(t6)*sin(t4) + cos(t4)*cos(t5)*sin(t6)),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                t5dot*sin(t4)*sin(t5)*sin(t6) - t6dot*(cos(t4)*sin(t6) + cos(t5)*cos(t6)*sin(t4)) - t4dot*(cos(t6)*sin(t4) + cos(t4)*cos(t5)*sin(t6)),                                                                                                                                                                                                                                                                                                                                                                                                                                                      t5dot*cos(t5)*sin(t6) + t6dot*cos(t6)*sin(t5),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               -t6dot*sin(t6), 0;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      - t2dot*(cos(t5)*sin(t2)*sin(t3) - cos(t2)*cos(t3)*cos(t5) + cos(t2)*cos(t4)*sin(t3)*sin(t5) + cos(t3)*cos(t4)*sin(t2)*sin(t5)) - t3dot*(cos(t5)*sin(t2)*sin(t3) - cos(t2)*cos(t3)*cos(t5) + cos(t2)*cos(t4)*sin(t3)*sin(t5) + cos(t3)*cos(t4)*sin(t2)*sin(t5)) - t5dot*(cos(t2)*sin(t3)*sin(t5) + cos(t3)*sin(t2)*sin(t5) - cos(t2)*cos(t3)*cos(t4)*cos(t5) + cos(t4)*cos(t5)*sin(t2)*sin(t3)) - t4dot*cos(t2 + t3)*sin(t4)*sin(t5),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               t4dot*cos(t4)*sin(t5) + t5dot*cos(t5)*sin(t4),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        t4dot*cos(t4)*sin(t5) + t5dot*cos(t5)*sin(t4),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     -t5dot*sin(t5),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            0, 0;
             t2dot*cos(t2)*sin(t3)*sin(t4)*sin(t6) - t3dot*cos(t2)*cos(t3)*cos(t6)*sin(t5) - t4dot*cos(t2)*cos(t3)*cos(t4)*sin(t6) - t5dot*cos(t2)*cos(t5)*cos(t6)*sin(t3) - t5dot*cos(t3)*cos(t5)*cos(t6)*sin(t2) - t6dot*cos(t2)*cos(t3)*cos(t6)*sin(t4) - t2dot*cos(t2)*cos(t3)*cos(t6)*sin(t5) + t2dot*cos(t3)*sin(t2)*sin(t4)*sin(t6) + t2dot*cos(t6)*sin(t2)*sin(t3)*sin(t5) + t3dot*cos(t2)*sin(t3)*sin(t4)*sin(t6) + t3dot*cos(t3)*sin(t2)*sin(t4)*sin(t6) + t3dot*cos(t6)*sin(t2)*sin(t3)*sin(t5) + t4dot*cos(t4)*sin(t2)*sin(t3)*sin(t6) + t6dot*cos(t6)*sin(t2)*sin(t3)*sin(t4) + t6dot*cos(t2)*sin(t3)*sin(t5)*sin(t6) + t6dot*cos(t3)*sin(t2)*sin(t5)*sin(t6) - t2dot*cos(t2)*cos(t4)*cos(t5)*cos(t6)*sin(t3) - t2dot*cos(t3)*cos(t4)*cos(t5)*cos(t6)*sin(t2) - t3dot*cos(t2)*cos(t4)*cos(t5)*cos(t6)*sin(t3) - t3dot*cos(t3)*cos(t4)*cos(t5)*cos(t6)*sin(t2) - t4dot*cos(t2)*cos(t3)*cos(t5)*cos(t6)*sin(t4) - t5dot*cos(t2)*cos(t3)*cos(t4)*cos(t6)*sin(t5) - t6dot*cos(t2)*cos(t3)*cos(t4)*cos(t5)*sin(t6) + t4dot*cos(t5)*cos(t6)*sin(t2)*sin(t3)*sin(t4) + t5dot*cos(t4)*cos(t6)*sin(t2)*sin(t3)*sin(t5) + t6dot*cos(t4)*cos(t5)*sin(t2)*sin(t3)*sin(t6),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       t6dot*(cos(t4)*cos(t6) - cos(t5)*sin(t4)*sin(t6)) - t4dot*(sin(t4)*sin(t6) - cos(t4)*cos(t5)*cos(t6)) - t5dot*cos(t6)*sin(t4)*sin(t5),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                t6dot*(cos(t4)*cos(t6) - cos(t5)*sin(t4)*sin(t6)) - t4dot*(sin(t4)*sin(t6) - cos(t4)*cos(t5)*cos(t6)) - t5dot*cos(t6)*sin(t4)*sin(t5),                                                                                                                                                                                                                                                                                                                                                                                                                                                      t6dot*sin(t5)*sin(t6) - t5dot*cos(t5)*cos(t6),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                t6dot*cos(t6), 0;
                                                                                                                                                  t5dot*((12*cos(t2 + t3)*cos(t1)*sin(t5))/125 - (12*cos(t5)*sin(t1)*sin(t4))/125 + (12*cos(t1)*cos(t2)*cos(t4)*cos(t5)*sin(t3))/125 + (12*cos(t1)*cos(t3)*cos(t4)*cos(t5)*sin(t2))/125) - t1dot*((12*cos(t1)*sin(t4)*sin(t5))/125 - (13*cos(t2)*sin(t1))/50 + (27*sin(t1)*sin(t2)*sin(t3))/100 - (12*cos(t2 + t3)*cos(t5)*sin(t1))/125 - (27*cos(t2)*cos(t3)*sin(t1))/100 + (12*cos(t2)*cos(t4)*sin(t1)*sin(t3)*sin(t5))/125 + (12*cos(t3)*cos(t4)*sin(t1)*sin(t2)*sin(t5))/125) + (t2dot*cos(t1)*(130*sin(t2) + 135*cos(t2)*sin(t3) + 135*cos(t3)*sin(t2) + 48*cos(t2)*cos(t5)*sin(t3) + 48*cos(t3)*cos(t5)*sin(t2) + 48*cos(t2)*cos(t3)*cos(t4)*sin(t5) - 48*cos(t4)*sin(t2)*sin(t3)*sin(t5)))/500 + (3*t3dot*cos(t1)*(45*cos(t2)*sin(t3) + 45*cos(t3)*sin(t2) + 16*cos(t2)*cos(t5)*sin(t3) + 16*cos(t3)*cos(t5)*sin(t2) + 16*cos(t2)*cos(t3)*cos(t4)*sin(t5) - 16*cos(t4)*sin(t2)*sin(t3)*sin(t5)))/500 - (12*t4dot*sin(t5)*(cos(t4)*sin(t1) + cos(t1)*cos(t2)*sin(t3)*sin(t4) + cos(t1)*cos(t3)*sin(t2)*sin(t4)))/125, (t1dot*cos(t1)*(130*sin(t2) + 135*cos(t2)*sin(t3) + 135*cos(t3)*sin(t2) + 48*cos(t2)*cos(t5)*sin(t3) + 48*cos(t3)*cos(t5)*sin(t2) + 48*cos(t2)*cos(t3)*cos(t4)*sin(t5) - 48*cos(t4)*sin(t2)*sin(t3)*sin(t5)))/500 - (t2dot*sin(t1)*(135*sin(t2)*sin(t3) - 135*cos(t2)*cos(t3) - 130*cos(t2) + 48*cos(t5)*sin(t2)*sin(t3) - 48*cos(t2)*cos(t3)*cos(t5) + 48*cos(t2)*cos(t4)*sin(t3)*sin(t5) + 48*cos(t3)*cos(t4)*sin(t2)*sin(t5)))/500 - (t5dot*sin(t1)*(48*cos(t2)*sin(t3)*sin(t5) + 48*cos(t3)*sin(t2)*sin(t5) - 48*cos(t2)*cos(t3)*cos(t4)*cos(t5) + 48*cos(t4)*cos(t5)*sin(t2)*sin(t3)))/500 - (t3dot*sin(t1)*(135*sin(t2)*sin(t3) - 135*cos(t2)*cos(t3) + 48*cos(t5)*sin(t2)*sin(t3) - 48*cos(t2)*cos(t3)*cos(t5) + 48*cos(t2)*cos(t4)*sin(t3)*sin(t5) + 48*cos(t3)*cos(t4)*sin(t2)*sin(t5)))/500 - (12*t4dot*cos(t2 + t3)*sin(t1)*sin(t4)*sin(t5))/125, (3*t1dot*cos(t1)*(45*cos(t2)*sin(t3) + 45*cos(t3)*sin(t2) + 16*cos(t2)*cos(t5)*sin(t3) + 16*cos(t3)*cos(t5)*sin(t2) + 16*cos(t2)*cos(t3)*cos(t4)*sin(t5) - 16*cos(t4)*sin(t2)*sin(t3)*sin(t5)))/500 - (12*t5dot*sin(t1)*(sin(t2 + t3)*sin(t5) - cos(t2 + t3)*cos(t4)*cos(t5)))/125 - (3*t2dot*sin(t1)*(45*sin(t2)*sin(t3) - 45*cos(t2)*cos(t3) + 16*cos(t5)*sin(t2)*sin(t3) - 16*cos(t2)*cos(t3)*cos(t5) + 16*cos(t2)*cos(t4)*sin(t3)*sin(t5) + 16*cos(t3)*cos(t4)*sin(t2)*sin(t5)))/500 - (3*t3dot*sin(t1)*(45*sin(t2)*sin(t3) - 45*cos(t2)*cos(t3) + 16*cos(t5)*sin(t2)*sin(t3) - 16*cos(t2)*cos(t3)*cos(t5) + 16*cos(t2)*cos(t4)*sin(t3)*sin(t5) + 16*cos(t3)*cos(t4)*sin(t2)*sin(t5)))/500 - (12*t4dot*cos(t2 + t3)*sin(t1)*sin(t4)*sin(t5))/125, (12*t5dot*cos(t5)*(cos(t1)*cos(t4) - sin(t4)*(cos(t2)*sin(t1)*sin(t3) + cos(t3)*sin(t1)*sin(t2))))/125 - (12*t1dot*sin(t5)*(cos(t4)*sin(t1) + sin(t4)*(cos(t1)*cos(t2)*sin(t3) + cos(t1)*cos(t3)*sin(t2))))/125 - (12*t4dot*sin(t5)*(cos(t1)*sin(t4) + cos(t4)*(cos(t2)*sin(t1)*sin(t3) + cos(t3)*sin(t1)*sin(t2))))/125 + (12*t2dot*sin(t4)*sin(t5)*(sin(t1)*sin(t2)*sin(t3) - cos(t2)*cos(t3)*sin(t1)))/125 + (12*t3dot*sin(t4)*sin(t5)*(sin(t1)*sin(t2)*sin(t3) - cos(t2)*cos(t3)*sin(t1)))/125, t1dot*((12*cos(t2 + t3)*cos(t1)*sin(t5))/125 - (12*cos(t5)*sin(t1)*sin(t4))/125 + (12*cos(t1)*cos(t2)*cos(t4)*cos(t5)*sin(t3))/125 + (12*cos(t1)*cos(t3)*cos(t4)*cos(t5)*sin(t2))/125) - t5dot*((12*cos(t1)*sin(t4)*sin(t5))/125 - (12*cos(t2 + t3)*cos(t5)*sin(t1))/125 + (12*cos(t2)*cos(t4)*sin(t1)*sin(t3)*sin(t5))/125 + (12*cos(t3)*cos(t4)*sin(t1)*sin(t2)*sin(t5))/125) - (12*t2dot*sin(t1)*(sin(t2 + t3)*sin(t5) - cos(t2 + t3)*cos(t4)*cos(t5)))/125 - (12*t3dot*sin(t1)*(sin(t2 + t3)*sin(t5) - cos(t2 + t3)*cos(t4)*cos(t5)))/125 - (12*t4dot*cos(t5)*(cos(t2)*sin(t1)*sin(t3)*sin(t4) - cos(t1)*cos(t4) + cos(t3)*sin(t1)*sin(t2)*sin(t4)))/125, 0;
                                                                                                                                                  t5dot*((12*cos(t2 + t3)*sin(t1)*sin(t5))/125 + (12*cos(t1)*cos(t5)*sin(t4))/125 + (12*cos(t2)*cos(t4)*cos(t5)*sin(t1)*sin(t3))/125 + (12*cos(t3)*cos(t4)*cos(t5)*sin(t1)*sin(t2))/125) - t1dot*((13*cos(t1)*cos(t2))/50 - (27*cos(t1)*sin(t2)*sin(t3))/100 + (12*sin(t1)*sin(t4)*sin(t5))/125 + (12*cos(t2 + t3)*cos(t1)*cos(t5))/125 + (27*cos(t1)*cos(t2)*cos(t3))/100 - (12*cos(t1)*cos(t2)*cos(t4)*sin(t3)*sin(t5))/125 - (12*cos(t1)*cos(t3)*cos(t4)*sin(t2)*sin(t5))/125) - (12*t4dot*sin(t5)*(cos(t2)*sin(t1)*sin(t3)*sin(t4) - cos(t1)*cos(t4) + cos(t3)*sin(t1)*sin(t2)*sin(t4)))/125 + (t2dot*sin(t1)*(130*sin(t2) + 135*cos(t2)*sin(t3) + 135*cos(t3)*sin(t2) + 48*cos(t2)*cos(t5)*sin(t3) + 48*cos(t3)*cos(t5)*sin(t2) + 48*cos(t2)*cos(t3)*cos(t4)*sin(t5) - 48*cos(t4)*sin(t2)*sin(t3)*sin(t5)))/500 + (3*t3dot*sin(t1)*(45*cos(t2)*sin(t3) + 45*cos(t3)*sin(t2) + 16*cos(t2)*cos(t5)*sin(t3) + 16*cos(t3)*cos(t5)*sin(t2) + 16*cos(t2)*cos(t3)*cos(t4)*sin(t5) - 16*cos(t4)*sin(t2)*sin(t3)*sin(t5)))/500, (t2dot*cos(t1)*(135*sin(t2)*sin(t3) - 135*cos(t2)*cos(t3) - 130*cos(t2) + 48*cos(t5)*sin(t2)*sin(t3) - 48*cos(t2)*cos(t3)*cos(t5) + 48*cos(t2)*cos(t4)*sin(t3)*sin(t5) + 48*cos(t3)*cos(t4)*sin(t2)*sin(t5)))/500 + (t1dot*sin(t1)*(130*sin(t2) + 135*cos(t2)*sin(t3) + 135*cos(t3)*sin(t2) + 48*cos(t2)*cos(t5)*sin(t3) + 48*cos(t3)*cos(t5)*sin(t2) + 48*cos(t2)*cos(t3)*cos(t4)*sin(t5) - 48*cos(t4)*sin(t2)*sin(t3)*sin(t5)))/500 + (t5dot*cos(t1)*(48*cos(t2)*sin(t3)*sin(t5) + 48*cos(t3)*sin(t2)*sin(t5) - 48*cos(t2)*cos(t3)*cos(t4)*cos(t5) + 48*cos(t4)*cos(t5)*sin(t2)*sin(t3)))/500 + (t3dot*cos(t1)*(135*sin(t2)*sin(t3) - 135*cos(t2)*cos(t3) + 48*cos(t5)*sin(t2)*sin(t3) - 48*cos(t2)*cos(t3)*cos(t5) + 48*cos(t2)*cos(t4)*sin(t3)*sin(t5) + 48*cos(t3)*cos(t4)*sin(t2)*sin(t5)))/500 + (12*t4dot*cos(t2 + t3)*cos(t1)*sin(t4)*sin(t5))/125, (12*t5dot*cos(t1)*(sin(t2 + t3)*sin(t5) - cos(t2 + t3)*cos(t4)*cos(t5)))/125 + (3*t2dot*cos(t1)*(45*sin(t2)*sin(t3) - 45*cos(t2)*cos(t3) + 16*cos(t5)*sin(t2)*sin(t3) - 16*cos(t2)*cos(t3)*cos(t5) + 16*cos(t2)*cos(t4)*sin(t3)*sin(t5) + 16*cos(t3)*cos(t4)*sin(t2)*sin(t5)))/500 + (3*t3dot*cos(t1)*(45*sin(t2)*sin(t3) - 45*cos(t2)*cos(t3) + 16*cos(t5)*sin(t2)*sin(t3) - 16*cos(t2)*cos(t3)*cos(t5) + 16*cos(t2)*cos(t4)*sin(t3)*sin(t5) + 16*cos(t3)*cos(t4)*sin(t2)*sin(t5)))/500 + (3*t1dot*sin(t1)*(45*cos(t2)*sin(t3) + 45*cos(t3)*sin(t2) + 16*cos(t2)*cos(t5)*sin(t3) + 16*cos(t3)*cos(t5)*sin(t2) + 16*cos(t2)*cos(t3)*cos(t4)*sin(t5) - 16*cos(t4)*sin(t2)*sin(t3)*sin(t5)))/500 + (12*t4dot*cos(t2 + t3)*cos(t1)*sin(t4)*sin(t5))/125, (12*t5dot*cos(t5)*(cos(t4)*sin(t1) + sin(t4)*(cos(t1)*cos(t2)*sin(t3) + cos(t1)*cos(t3)*sin(t2))))/125 - (12*t4dot*sin(t5)*(sin(t1)*sin(t4) - cos(t4)*(cos(t1)*cos(t2)*sin(t3) + cos(t1)*cos(t3)*sin(t2))))/125 + (12*t1dot*sin(t5)*(cos(t1)*cos(t4) - sin(t4)*(cos(t2)*sin(t1)*sin(t3) + cos(t3)*sin(t1)*sin(t2))))/125 - (12*t2dot*sin(t4)*sin(t5)*(cos(t1)*sin(t2)*sin(t3) - cos(t1)*cos(t2)*cos(t3)))/125 - (12*t3dot*sin(t4)*sin(t5)*(cos(t1)*sin(t2)*sin(t3) - cos(t1)*cos(t2)*cos(t3)))/125, t1dot*((12*cos(t2 + t3)*sin(t1)*sin(t5))/125 + (12*cos(t1)*cos(t5)*sin(t4))/125 + (12*cos(t2)*cos(t4)*cos(t5)*sin(t1)*sin(t3))/125 + (12*cos(t3)*cos(t4)*cos(t5)*sin(t1)*sin(t2))/125) - t5dot*((12*sin(t1)*sin(t4)*sin(t5))/125 + (12*cos(t2 + t3)*cos(t1)*cos(t5))/125 - (12*cos(t1)*cos(t2)*cos(t4)*sin(t3)*sin(t5))/125 - (12*cos(t1)*cos(t3)*cos(t4)*sin(t2)*sin(t5))/125) + (12*t2dot*cos(t1)*(sin(t2 + t3)*sin(t5) - cos(t2 + t3)*cos(t4)*cos(t5)))/125 + (12*t3dot*cos(t1)*(sin(t2 + t3)*sin(t5) - cos(t2 + t3)*cos(t4)*cos(t5)))/125 + (12*t4dot*cos(t5)*(cos(t4)*sin(t1) + cos(t1)*cos(t2)*sin(t3)*sin(t4) + cos(t1)*cos(t3)*sin(t2)*sin(t4)))/125, 0;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         0,                                                                                                                                                                                                                                                                                                                                                                                                                                                               (12*t4dot*sin(t2 + t3)*sin(t4)*sin(t5))/125 - t2dot*((27*sin(t2 + t3))/100 + (13*sin(t2))/50 - (6*sin(t4 - t5)*cos(t2 + t3))/125 + (6*cos(t2 + t3)*sin(t4 + t5))/125 + (12*sin(t2 + t3)*cos(t5))/125) - t5dot*((12*cos(t2 + t3)*sin(t5))/125 + (12*sin(t2 + t3)*cos(t4)*cos(t5))/125) - t3dot*((27*sin(t2 + t3))/100 + (12*sin(t2 + t3)*cos(t5))/125 + (12*cos(t2 + t3)*cos(t4)*sin(t5))/125),                                                                                                                                                                                                                                                                                                                                                                                                          (12*t4dot*sin(t2 + t3)*sin(t4)*sin(t5))/125 - t3dot*((27*sin(t2 + t3))/100 + (12*sin(t2 + t3)*cos(t5))/125 + (12*cos(t2 + t3)*cos(t4)*sin(t5))/125) - t5dot*((12*cos(t2 + t3)*sin(t5))/125 + (12*sin(t2 + t3)*cos(t4)*cos(t5))/125) - t2dot*((27*sin(t2 + t3))/100 + (12*sin(t2 + t3)*cos(t5))/125 + (12*cos(t2 + t3)*cos(t4)*sin(t5))/125),                                                                                                                                                                                                                                                                                                              (12*t2dot*sin(t2 + t3)*sin(t4)*sin(t5))/125 - (12*t5dot*cos(t2 + t3)*cos(t5)*sin(t4))/125 - (12*t4dot*cos(t2 + t3)*cos(t4)*sin(t5))/125 + (12*t3dot*sin(t2 + t3)*sin(t4)*sin(t5))/125,                                                                                                                                                                                                                                                                                                                                                                - t2dot*((12*cos(t2 + t3)*sin(t5))/125 + (12*sin(t2 + t3)*cos(t4)*cos(t5))/125) - t3dot*((12*cos(t2 + t3)*sin(t5))/125 + (12*sin(t2 + t3)*cos(t4)*cos(t5))/125) - t5dot*((12*sin(t2 + t3)*cos(t5))/125 + (12*cos(t2 + t3)*cos(t4)*sin(t5))/125) - (12*t4dot*cos(t2 + t3)*cos(t5)*sin(t4))/125, 0];

end