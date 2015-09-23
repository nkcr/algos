#! /usr/bin/ruby
require 'Nyaplot'

# Purpose
# -------
# Use the barycentric formula to interpolate

# This function takes points and return the corresponding function
# Params:
# - xpoints (array), list of x coordinates
# - ypoints (array), list of y coordinates
# Return:
# - func (lambda)
def barycentric(xpoints, ypoints)
  lambdas = []
  xpoints.each do |xi|
    accumulator = 1.0
    xpoints.each do |xj|
      accumulator *= xi - xj unless xi == xj
    end
    lambdas.push(1.0 / accumulator)
  end
  func = lambda do |x|
    xpoints.each_with_index do |m,i|
      return ypoints[i] if (m-x).abs < 0.00001
    end
    num, denum = 0.0, 0.0
    (0..xpoints.size-1).each do |i|
      # p "lambda : #{lambdas[i]}, x : #{x}, xpoints[i] : #{xpoints[i]}, y : #{ypoints[i]}"
      num += lambdas[i] / (x - xpoints[i]) * ypoints[i]
      denum += lambdas[i] / (x - xpoints[i])
    end
    return num / denum
  end
  return func
end

@n = 100 # number of points
# Return points so as to draw
# Params :
# - func (lambda), the function to use
# Return :
# - [a,b] (array of 2 array) 2 lists of
def draw(func)
  a, b = [], []
  (-1..1).step(2.to_f/@n).each do |i|
    a.push(i)
    b.push(func.call(i.to_f))
  end
  return[a,b]
end

def yfromx(xpoints, func)
  ypoints = []
  xpoints.each do |x|
    ypoints.push(func.call(x))
  end
  ypoints
end

plot = Nyaplot::Plot.new

func1 = Proc.new {|x| 1.to_f/(1+25*x*x)}
func2 = Proc.new {|x| Math.cos(((x+1.to_f)*Math::PI)/(2*(@n+1)))}

points = draw(func1)
plot.add(:line, points[0], points[1])

xpoints = yfromx(points[0], func2)
ypoints = yfromx(xpoints, func1)

approx = barycentric(xpoints,ypoints)
points2 = draw(approx)

sc = plot.add(:line, points2[0], points2[1])
sc.color('#ff0000')

plot.export_html
