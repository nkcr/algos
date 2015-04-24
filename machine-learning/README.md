machine-learning
================

Recursives functions used in math machine learning course

####Newton method####

used to approximate the zero of a function  

    sol = ML.newton(0.1, 0.1) do |x|  
     {d: 2*x, f: x**2-3}  
    end  

####Newton-Raphson method####

used to approximate the intersection of 2 plans

    sol = ML.newton_raphson(1,-1) do |x,y|
    	{
    		fx: 2*x,
    		fy: 8*y,
    		gx: -28*x,
    		gy: 18,
    		ff: x**2+4*y**2-9,
    		gg: 18*y-14*x**2+45
    	}
    end

####Golden Section####

used to find the minimum in given interval  
params:

    a, c            - the interval  
    tol (optional)  - the relative tolerance  
    block           - the block, see example below  
    
    sel = ML.golden_section(1.5,2.5) do |x|
    	{
    		f: x**6 - 6*x**4 - 3*x + 1
    	}
    end
