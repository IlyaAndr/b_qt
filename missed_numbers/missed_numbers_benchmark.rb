# encoding: utf-8  

require 'benchmark'

require_relative 'missed_numbers'

include InitialData

include NumbersFinder



class Numeric
  
  def number_with_delimiter delimiter=","
    to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
  end
  
end

[100000, 1000000, 10000000].each do |k|
  arr = serial_array_with_missed_numbers k, 2
  Benchmark.bmbm do |x|
    puts "\n\nArray size: #{k.number_with_delimiter}"
    x.report("Simple") { simple arr, k }
    x.report("Linear -- O(k)")  { linear arr, k }
    x.report("dichotomic -- O(Log(k))")  { dichotomic arr, k }
  end
end
 
