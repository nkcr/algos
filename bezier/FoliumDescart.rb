#! /usr/bin/ruby
T0 = 0
DELTA = 0.001

def t(n)
	T0 + n*DELTA.to_f
end

def x(n)
	1000*( 3*t(n) ).to_f / ( 1+t(n)**3 ).to_f
end

def y(n)
	1000* ( 3*t(n)**2 ).to_f / ( 1+t(n)**3 ).to_f
end

Shoes.app {
	(0..1000).step(0.1).each do |i|
		oval(
			left:   x(i),
     	top:    y(i),
     	radius: 1)
	end
}