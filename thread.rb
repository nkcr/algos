#! /usr/bin/ruby

# Purpose
# -------
# just playing around with threads

# This is a producer consummer case
# Taken from http://engineering.mydrivesolutions.com/posts/ruby_thread_sync/
class EndOfOp ; end
queue = Queue.new
producer = Thread.new {
  5.times do |i|
    queue << i
    sleep 1
  end
  p 'Producer exiting'
  queue << EndOfOp.new
}
consumer = Thread.new {
  while obj = queue.pop
    break if obj.instance_of? EndOfOp
    p "Popped #{obj}"
  end
  p 'Consumer exiting'
}
producer.join
consumer.join
