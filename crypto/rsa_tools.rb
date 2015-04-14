#! /usr/bin/ruby

# Purpose
# -------
# Tools nedded to perform RSA calculous like primer number
# 

# Finds n first prime number with the Crible d'Eratosthène
# params
# - n (Integer) the first n prime number
# return
# - an array containning the numbers
def primer_numbers(n)
	res = (0..n).to_a
	min = Math.sqrt(n).to_i
	i = 2
	while(i <= min)
		if(res[i])
			cursor = i * 2;
			while cursor <= n
				res[cursor] = nil
				cursor = cursor + res[i]
			end
		end
		i += 1
	end
	res
end
# @test
##p primer_numbers(10_000_000)
##p primer_numbers(4027)

# Finds the rest of 'a' after division by 'b'
# params
# - a (Double) the number
# - b (Double) the divider
def rest(a,b)
end

# Finds the PGDC of 'a' & 'b'
# Using the Euclid Algorithme
# params
# - a (Double) first number
# - b (Double) second number
def pgdc(a,b)
	while(a != 0 && b !=0)
		if(a > b)
			a = a%b
		else
			b = b%a
		end
	end
	a==0? b : a
end
# @test
p pgdc(72,39)