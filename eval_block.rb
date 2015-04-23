def eval_block(*args, &prc)
  prc ||= proc {puts "NO BLOCK GIVEN"}
  prc.call(*args)
end

eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end
# Washington, Kerry won 23 votes.
# => nil

p( eval_block(1,2,3,4,5) do |*args|
  args.inject(:+)
end)
# => 15

eval_block(1, 2, 3)
# => "NO BLOCK GIVEN"
