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
	min = Math.sqrt(n)
	i = 2
	while(i <= n)
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
p primer_numbers(4027)