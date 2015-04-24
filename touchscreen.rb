#! /usr/bin/ruby

# Purpose
# -------
# Provide method to calibrate a touchscreen

# Perform a three point calibration
# Params :
# x0,y0,...x2,y2 (number) coordinates of expected points
# a0,b0,...a2,b2 (numner) actual coordinates
def three_calibration(
      x0,y0,x1,y1,x2,y2,
      a0,b0,a1,b1,a2,b2
    )
  fraction = 1/(a0*b1-a0*b2-a1*b0+a1*b2+a2*b0-a2*b1).to_f
  a = fraction * (-x1*b0+x2*b0+x0*b1-x2*b1-x0*b2+x1*b2)
  b = fraction * (x1*a0-x2*a0-x0*a1+x2*a1+x0*a2-x1*a2)
  c = fraction * (-x2*a1*b0+x1*a2*b0+x2*a0*b1-x0*a2*b1-x1*a0*b2+x0*a1*b2)

  d = fraction * (-y1*b0+y2*b0+y0*b1-y2*b1-y0*b2+y1*b2)
  e = fraction * (y1*a0-y2*a0-y0*a1+y2*a1+y0*a2-y1*a2)
  f = fraction * (-y2*a1*b0+y1*a2*b0+y2*a0*b1-y0*a2*b1-y1*a0*b2+y0*a1*b2)
  return [a,b,c,d,e,f]
end

p three_calibration(65,350,200,195,195,550,650,2000,2800,1350,2640,3500)
