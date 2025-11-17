extern double dt;
extern double Inf;

//Do not edit this function.
//This is the function for a unit step
double u(t)
{

  if (t >= 0)
    return 1.0;
  else
    return 0.0;
}

//Do not edit this function.
//This is the function for a unit Impulse 
double d(t)
{

  if (t > -dt && t < dt) 
    return Inf;
  else
    return 0.0;
}


//Edit this function as needed but keep the function prototype
double x(double t)
{
  if (t <= 1.0)
    return 0.0;
  else if (t <= 2.0)
    return 5.0 - 4.0 * t;
  else if (t <= 3.0)
    return 2.0 * t - 7.0;
  else if (t <= 5.0)
    return 0.5 * t - 2.5;
  else if (t <= 6.0)
    return t - 6.0;
  else
    return 0.0;
}


//Edit this function as needed but keep the function prototype
double y(double t)
{
  if (t < -8.0)
    return 0.0;
  else if (t <= -7.0)
    return -t - 8.0;
  else if (t <= -5.0)
    return -0.5 * t - 3.5;
  else if (t <= -4.0)
    return -2.0 * t - 11.0;
  else if (t <= -3.0)
    return 13.0 + 4.0 * t;
  else
    return 0.0;
}

//Edit this function as needed but keep the function prototype
double z(double t)
{
  double segment1 = (-t - 8.0) * (u(t + 8.0) - u(t + 7.0));
  double segment2 = (-0.5 * t - 3.5) * (u(t + 7.0) - u(t + 5.0));
  double segment3 = (-2.0 * t - 11.0) * (u(t + 5.0) - u(t + 4.0));
  double segment4 = (13.0 + 4.0 * t) * (u(t + 4.0) - u(t + 3.0));

  return segment1 + segment2 + segment3 + segment4;
}

//Edit this function as needed but keep the function prototype
double r(double t)
{
  if (t < 1.0 - dt)
    return 0.0;
  else if (t < 1.0 + dt)
    return Inf;
  else if (t <= 2.0)
    return -4.0;
  else if (t <= 3.0)
    return 2.0;
  else if (t <= 5.0)
    return 0.5;
  else if (t <= 6.0)
    return 1.0;
  else
    return 0.0;
}





