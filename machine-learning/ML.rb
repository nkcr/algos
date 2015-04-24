#!/usr/bin/ruby
# Author : Kocher Noémien

module ML
	require 'nyaplot'
	require 'matrix'
	extend self

	@tol = 0.0001
	@tau = ((5**(0.5)-1)/2)


	# Newton
	# ------
	# x0 				- poitn coordinate of near where it will be evaluated
	# tol 			- relative tolerance
	# block 		- block receiving function parameters, x
	# 					block must return hash { f:f(x) and d:f'(x) }
	def newton(x0, tol = @tol, &block)
		p "Newton method. Find a zero of the function."
		@block = block
		x1 = x0 - f(x0) / fp(x0)
		while (x1-x0).abs > tol*x1.abs
		#20.times do
			x0 = x1
			x1 = x0 - f(x0)/fp(x0)
			p "x1 = #{x1} f(x1): #{f(x1)}"
		end
		return x1
	end

	# Newton raphson
	# --------------
	# x0, y0		- point coordinate of near where it will be evaluated
	# tol 			- relative rolerance
	# block 		- block receiving function parameters, x,y
	# 						block must return hash { fx:fx(x0,y0), fy:fy(x0,y0), gx:gx(x0,y0), gy:gy(x0,y0), ff:f(x), gg:g(x) }
	def newton_raphson(x0, y0, tol = @tol, &block)
		p "Newton raphson method. Find the intersection of two function near a point."
		x0y0 = Matrix[ [x0],[y0] ]
		x1y1 = compute_raphson(x0, y0, &block)
		dist = (x1y1 - x0y0).row_vectors[0].norm
		p dist
		while (dist > tol)
		#10.times do
			x0y0 = x1y1
			x1y1 = compute_raphson(x0y0[0,0],x0y0[1,0], &block)
			dist = (x1y1 - x0y0).row_vectors[0].norm
			p x1y1
		end
	end

	# Golden section
	# --------------
	# Params :
	# 	a, c 		- interval [a;c]
	# 	tol 		- relative tolerance
	# 	block 	- block receiving function parameter, x
	# 					 	block must return hash { f:f(x) }
	def golden_section(a, c, tol = @tol, &block)
		p "Golden section method. Find the local minimum of a funtion between an interval."
		@block = block
		x1 = a + (1-@tau)*(c-a)
		f1 = f(x1)
		x2 = a + @tau*(c-a)
		f2 = f(x2)
		while((a-c).abs > tol)
		#10.times do
			if f1 > f2
				a = x1
				x1 = x2
				f1 = f2
				x2 = a + @tau*(c-a)
				f2 = f(x2)
				p "a = #{a} c = #{c} p = #{x2} f(p) = #{f2}"
			else
				c = x2
				x2 = x1
				f2 = f1
				x1 = a + (1-@tau)*(c-a)
				f1 = f(x1)
				p "a = #{a} c = #{c} p = #{x1} f(p) = #{f1}"
			end
		end
	end

	# Perceptron
	# ----------
	def perceptron(xc, yc, sp)
		plot_data(xc,yc) # give graph of data given in data.html
		i = 0
		w = Vector[0.0,0.0]
		b = 0.0

			while i < xc.length
				p = Vector[xc[i],yc[i]]
				puts "i = #{i} w = #{w} b = #{b} p = #{p} sp = #{sp[i]}"
				if sp[i] * ( (w.covector*p).norm + b ) <= 0
					w = w + (sp[i]*p)
					b = b + sp[i]
					i = 0
				else
					i += 1
				end
			end

			p "W = #{w} and b = #{b}"

	end

	# internal methods
	# ----------------

	def fx(x,y) @block.call(x,y)[:fx].to_f end
	def fy(x,y) @block.call(x,y)[:fy].to_f end
	def gx(x,y) @block.call(x,y)[:gx].to_f end
	def gy(x,y) @block.call(x,y)[:gy].to_f end
	def gg(x,y) @block.call(x,y)[:gg].to_f end
	def ff(x,y) @block.call(x,y)[:ff].to_f end
	def compute_raphson(x0, y0, &block)
		@block = block
		jacob = Matrix[ [fx(x0,y0), fy(x0,y0)], [gx(x0,y0), gy(x0,y0)] ]
		big_f = Matrix[ [ff(x0,y0)], [gg(x0,y0)] ]
		coord = Matrix[ [x0], [y0] ]
		x1y1 = coord - jacob.inv * big_f	
	end
	def f(x) @block.call(x)[:f].to_f end
	def fp(x) @block.call(x)[:d].to_f end
	
	def plot_data(xc, yc)
		df = Nyaplot::DataFrame.new({x: xc,y: yc})
		plot = Nyaplot::Plot.new
		plot.add_with_df(df, :scatter, :x, :y)
		plot.export_html("data.html")
	end

end


# Usage examples
# --------------

# sol = ML.newton(20, 0.0001) do |x|
# 	{
# 		d: 6*x - 160, f: 3*x**2 - 160*x + 1700
# 	}
# end

# sol = ML.newton_raphson(1,-1) do |x,y|
# 	{
# 		fx: 2*x,
# 		fy: 8*y,
# 		gx: -28*x,
# 		gy: 18,
# 		ff: x**2+4*y**2-9,
# 		gg: 18*y-14*x**2+45
# 	}
# end

# sel = ML.golden_section(1.5,2.5) do |x|
# 	{
# 		f: x**6 - 6*x**4 - 3*x + 1
# 	}
# end

ML.perceptron(
	[20,15,16,5,16,2],
	[8,20,10,15,6,20],
	[1,1,-1,-1,-1,-1]
)

# p (Vector[2,2].covector*Vector[1,1]).norm + 3



# Line chart
# x = []; y = []; theta = 0.6; a=1
# while theta < 224*Math::PI do
#   x.push(a*Math::cos(theta)/theta)
#   y.push(a*Math::sin(theta)/theta)
#   theta += 0.1
# end
# plot1 = Nyaplot::Plot.new
# plot1.add(:line, x, y)
# plot1.export_html("line.html")