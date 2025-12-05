#include <stdio.h>
#include <math.h>

const double dt = 0.001; // Step size
const double R = 0.4;    // Resistance in Ohms
const double C = 0.05;   // Capacitance in Farads

// Analytic Solution: Vc(t) = Vin * (1 - e^(-t/RC))
double Vc(double t)
{
    // Exact solution for unit step response
    return 1.0 * (1.0 - exp(-t / (R * C))); 
}

// Differential Equation: dVc/dt = (Vin - Vc) / RC
// x is current Voltage (Vc), u is Input Voltage (Vin)
double DE(double x, double u)
{
    // The slope corresponds to: (1/RC) * (Vin - Vc)
    return (u - x) / (R * C); 
}

// Euler's Method Implementation
// x(t + dt) = x(t) + dt * f(x, u)
double Euler(double (*f)(double, double), double x, double u)
{
    double slope = f(x, u);
    return x + (dt * slope);
}

int main(void)
{
    double t = 0, u = 1.0, x = 0.0; // u=1.0 is the Unit Step Input, x=0.0 is Vc(0)
    FILE *fp;
    
    fp = fopen("out.dat", "w");
    if (fp == NULL) {
        printf("File error\n");
        return -1;
    }

    fprintf(fp, "Time\t\t\tNumeric\t\t\tAnalytic\n");

    for (t = 0; t < 5.0; t += dt) { 
        fprintf(fp, "%e\t%e\t%e\n", t, x, Vc(t));
        x = Euler(DE, x, u);
    }
    
    fclose(fp);
    printf("Data generated in out.dat\n");
    return 0;
}