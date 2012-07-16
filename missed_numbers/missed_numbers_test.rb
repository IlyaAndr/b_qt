# encoding: utf-8  

require_relative 'missed_numbers'

include InitialData

include NumbersFinder

describe "Number finder module" do
  
  it "has results of the methods to be equaled" do
    k, n = 9, 2
    (100000).times do
      arr = serial_array_with_missed_numbers k, n
      res1 =  simple arr, k
      res2 = linear arr, k
      res3 = dichotomic arr, k
      if res1 != res2 || res1 != res3 || res2 != res3
	p arr
	p res1
	p res2
	p res3
	raise "Not equaled!"
      end
    end
  end
  
end 
