require 'benchmark'

require_relative 'user_finder'

person_factory = PersonFactory.new male_min: 0, male_max: 1, age_min: 0, age_max: 100, height_min: 0, height_max: 300, index_min: 0, index_max: 1000000, cash_min: 0.0, cash_max: 1000000.0

person_finder = PersonFinder.new person_factory.random_criteria

puts "person_finder"
puts person_finder

people = []
n = 100000
n.times {people << person_factory.random_person}

Benchmark.bmbm do |x|
  x.report("Find") { person_finder.find people }
end

