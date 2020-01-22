#include <math.h>
#include <stdio.h>


struct q{
	double gamma[6];
	int errorCheck;
};

struct q MeiosisIK(double pos[3], double R[9]);

int main(int argc, float* argv[])) {
	pos = argv[1];
	R = argv[2];
	// double pos[3] = { 20,20,1 };
	// double R[9] = {1,0,0,0,1,0,0,0,1};
	// struct q q2;
	// int i = 0;

	// q2 = MeiosisIK(pos, R);

	// for (i = 0; i < 6; i++) {
		// printf("%lf \n", q2.gamma[i]);
	// }

}

struct q MeiosisIK(double pos[3], double R[9]) {

	struct q q2;

	const double eOff = 5.25;
	const double L1 = 22.08;
	const double L2 = 25;
	const double L3 = 28;

	double xc = pos[0] - R[1]*eOff;
	double yc = pos[1] - R[4]*eOff;
	double zc = pos[2] - R[7]*eOff;
	double t1;
	double t2;
	double t3;
	double t4;
	double t5;
	double t6;
	double D;
	double T21;
	double T22;
	double T23;
	double T12;
	double T32;

	// Add check for workspace
	//	if ((xc^2 + yc^2) > ) {
	//		errorCheck = ...
	//	}

	// Inverse Position
	t1 = atan2(yc,xc);
	D = (xc*xc + yc*yc + (zc - L1)*(zc - L1) - L2*L2 - L3*L3)/(2*L2*L3);
	t3 = atan2(-sqrt(1-D*D),D);
	t2 = atan2(zc - L1,sqrt(xc*xc + yc*yc)) - atan2(L3*sin(t3),L2 + L3*cos(t3));

	// Inverse Orientation
	T21 = R[0]*(sin(t1)*sin(t2)*sin(t3) - cos(t2)*cos(t3)*sin(t1)) + R[6]*(cos(t2)*sin(t3) + cos(t3)*sin(t2)) - R[3]*(cos(t1)*sin(t2)*sin(t3) - cos(t1)*cos(t2)*cos(t3));
	T22 = R[1]*(sin(t1)*sin(t2)*sin(t3) - cos(t2)*cos(t3)*sin(t1)) + R[7]*(cos(t2)*sin(t3) + cos(t3)*sin(t2)) - R[4]*(cos(t1)*sin(t2)*sin(t3) - cos(t1)*cos(t2)*cos(t3));
	T23 = R[2]*(sin(t1)*sin(t2)*sin(t3) - cos(t2)*cos(t3)*sin(t1)) + R[8]*(cos(t2)*sin(t3) + cos(t3)*sin(t2)) - R[5]*(cos(t1)*sin(t2)*sin(t3) - cos(t1)*cos(t2)*cos(t3));
	T12 = R[1]*cos(t1) + R[4]*sin(t1);
	T32 = R[1]*(cos(t2)*sin(t1)*sin(t3) + cos(t3)*sin(t1)*sin(t2)) + R[7]*(cos(t2)*cos(t3) - sin(t2)*sin(t3)) - R[4]*(cos(t1)*cos(t2)*sin(t3) + cos(t1)*cos(t3)*sin(t2));

	t5 = atan2(T21,-T23);
	t4 = atan2(T12,T32);
	t6 = atan2(T12/sin(t5),T22);

	q2.gamma[0] = t1;
    q2.gamma[1] = t2;
    q2.gamma[2] = t3;
    q2.gamma[3] = t4;
    q2.gamma[4] = t5;
    q2.gamma[5] = t6;

	q2.errorCheck = 0;

	return q2;

}
