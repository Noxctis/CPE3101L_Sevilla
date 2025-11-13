//Do not edit this function.
//This is the function for a unit step
double u(t)
{

  if (t >= 0)
    return 1.0;
  else
    return 0.0;
}


//Edit this function as needed but keep the function prototype
double x(double t)

{
    if (t < 0.0) {                 // x(t) = 0 for t < 0
        return 0.0;
    } else if (t <= 1.0) {         // 0 <= t <= 1: ramp up from 0 to 3
        return 3.0 * t;            // slope = 3
    } else if (t <= 2.0) {         // 1 <= t <= 2: ramp down from 3 to 0
        return -3.0 * t + 6.0;     // slope = -3, intercept = 6
    } else if (t < 3.0) {          // 2 <= t < 3: zero
        return 0.0;
    } else if (t <= 4.0) {         // 3 <= t <= 4: constant -1 (step down)
        return -1.0;
    } else {                       // t > 4: back to zero
        return 0.0;
    }
}



//Edit this function as needed but keep the function prototype
double y(double t)

{
    if (t < -0.5) {                // s = 2t+1 < 0
        return 0.0;
    } else if (t <= 0.0) {         // -0.5 <= t < 0  (0 <= s < 1)
        return 6.0 * t + 3.0;
    } else if (t <= 0.5) {         // 0 <= t < 0.5   (1 <= s < 2)
        return -6.0 * t + 3.0;
    } else if (t < 1.0) {          // 0.5 <= t < 1    (2 <= s < 3)
        return 0.0;
    } else if (t <= 1.5) {         // 1 <= t < 1.5   (3 <= s < 4)
        return -1.0;
    } else {                       // t > 1.5         (s > 4)
        return 0.0;
    }
}


//Edit this function as needed but keep the function prototype
double z(double t)
{
return (6.0*t + 3.0) * (u(t + 0.5) - u(t))        // -0.5 <= t < 0
         + (-6.0*t + 3.0) * (u(t) - u(t - 0.5))       // 0 <= t < 0.5
         - (u(t - 1.0) - u(t - 1.5));                 // 1 <= t < 1.5

}

//Edit this function as needed but keep the function prototype
double r(double t)

{
    if (t <= 0.0) {                     // integral from -inf to t is 0
        return 0.0;
    } else if (t <= 1.0) {              // 0 <= t <= 1
        return 1.5 * t * t;
    } else if (t <= 2.0) {              // 1 <= t <= 2
        return -1.5 * t * t + 6.0 * t - 3.0;
    } else if (t < 3.0) {               // 2 <= t < 3
        return 3.0;
    } else if (t <= 4.0) {              // 3 <= t <= 4
        return 6.0 - t;
    } else {                            // t >= 4
        return 2.0;
    }
}









