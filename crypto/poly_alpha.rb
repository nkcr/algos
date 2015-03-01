#! /usr/bin/ruby

# Purpose
# -------
# polyalphabetic substitutions

module PolyAlpha
	extend self

	# Random polyalpha substitution
	# params :
	# - string (String) string to cypher
	# return :
	# - (String) the crypted string
	def random_poly(string)
		alphabet = ('a'..'z').to_a
		key = alphabet.shuffle.join
		a = string.tr(alphabet.join,key)
		# test :
		# p a.tr(key,alphabet.join)
		# a
	end
	# @test
	##p random_poly("jesuisalleraucinemacetaitsupercool")

end