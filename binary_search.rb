#! /usr/bin/ruby

require 'benchmark'

# that one loops forever if not found
def bs1 (array, find)
	left = 0
	right = array.length # length makes all
	mid = right / 2
	while(find < array[mid] || find > array[mid])
		if(find < array[mid])
			right = mid
		else
			left = mid
		end
		mid = (right-left) / 2 + left
	end
	return mid
end


# that one loops forever if not found
def bs2 (array, find)
	left = 0
	right = array.length-1
	while(left <= right)
		mid = (right-left) / 2 + left
		if(find < array[mid])
			right = mid-1
		elsif(find > array[mid])
			left = mid+1
		else
			return mid
		end
	end
	return mid
end



n = 10
size = 9999999
array = []
(0..size).each {|i| array[i]=i}

Benchmark.bm do |x|
  x.report("BS1:") { n.times do ; array.each{|i| bs1(array,i)} ; end }
  x.report("BS2:") { n.times do ; array.each{|i| bs2(array,i)} ; end }
end