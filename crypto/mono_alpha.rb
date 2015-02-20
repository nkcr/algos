#! /usr/bin/ruby

# Purpose
# -------
# monoalphabetic substitutions

# Shift by 3 the given string
# params :
# - shift (Integer) shift value
# - input_string (String) the string to be crypted
# return :
# - (String) the crypted string
def shift(shift, input_string)
	alphabet = ('a'..'z').to_a.join # alphabet string
	shift = shift % alphabet.length
	input_string.tr(alphabet,alphabet[shift..-1] + alphabet[0..shift-1])
end
# test
crypted = shift(3,"ce message est crypté")
decrypted = shift(-3, crypted)
p crypted + " | " + decrypted
# another version
def shift(shift, input_string)
	alphabet = ('a'..'z').to_a # alphabet string
	matching = Hash[alphabet.zip(alphabet.rotate(shift))]
	matching.values_at(*input_string.chars).join
end
# test
crypted = shift(3,"ce message est crypté")
decrypted = shift(-3, crypted)
p crypted + " | " + decrypted


# substitute based on a repeated key
# params :
# - key (String) the key (will be repeated if needed)
# - string (String) the string to be crypted
# return :
# - (String) the crypted string
def key_crypt(key,string)
	alphabet = ('a'..'z').to_a
	keys = key.chars
	indexes = Hash[alphabet.map.with_index.to_a]
	matrix = Hash.new
	(0..alphabet.length).each do |i|
		alphabet.each_with_index do |letter,j|
			matrix[[i,j]] = letter
		end
		alphabet.rotate!
	end
	a = string.chars.each_with_index.map { |c,i| matrix[ [indexes[keys[i%keys.length]],indexes[c]] ] }.join
end
# test
p key_crypt("dddddddaaaaaaa","ce message est crypté")



