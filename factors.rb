def factors(num)
  (1..num).each { |factor| puts factor if num % factor == 0 }
end

factors(12)
puts "***************"
factors(23)
