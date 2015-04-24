#! /usr/bin/ruby

require 'Matrix'

# Purpose
# -------
# Draw a bezier curve

# Draw something
# Params :
# - vectors (Vector[*][4]) array containing array of four vector
def draw(vectors)
  Shoes.app do
    vectors.each do |points|
      (0..1).step(0.005).each do |t|
        result = (1-t)**3*points[0] + 3*t*(1-t)**2*points[1] + 3*t**2*(1-t)*points[2] + t**3*points[3]
        oval(result[0]+100, result[1]+100, 1)
      end
    end
  end
end

point1 = [Vector[500,0],Vector[-4,5],Vector[1,2.5],Vector[2.5,0]]
point2 = [Vector[500,0],Vector[-8,90],Vector[-1.5,3.5],Vector[2.5,0]]

draw([point1,point2])
