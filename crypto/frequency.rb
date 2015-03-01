#! /usr/bin/ruby

# Purpose
# -------
# calculate a letter frequency

module Frequency
	extend self

	# Calculates the relativ frequency of a letter in a sentence
	# it is done by dividing the number of occurence by the number of letter
	# params :
	# - string (String) the sentence
	# - char (String) the letter
	# return :
	# - the frequency
	def frequency(string,char)
		string.count(char) / string.length.to_f
	end
	# @test
	##p frequency("hello","l")

	# calculates k Friedman coef of 2 sentences of same length
	# if the second string is longer it's okay, takes the length of the first string
	# params :
	# - string1 (String) the first sentence
	# - string2 (String) the second sentence
	# return :
	# - the coeff
	def friedman(string1,string2)
		j = 0.0
		string1.chars.each_with_index do |char1,i|
			j += ((char1 == string2[i])? 1 : 0)
		end
		j / (string1.length)
	end
	# @test
	##p friedman("abcd","abcg")

	# calculates Kullback coef of a given string
	# it is done by making friedman of each sentence shifted, divided by the length
	# params :
	# - string (String) the string
	# return :
	# - the coef
	def kullback(string)
		j = 0.0
		(0..string.length-1).each do |i|
			j += friedman(string,string[i..-1] + string[0..i-1])
		end
		j / string.length
	end
	# @test
	##p kullback("le vif zéphir jubile sur les kumquats du clown gracieux")

end