#!/usr/bin/env ruby

class Calculator
  attr_reader :stack

  def initialize
    @stack = []
  end

  OPERATIONS = [:+, :-, :*, :/, :**]

  def process_input(input)
    if Calculator.is_i?(input)
      stack << input.to_i
    elsif Calculator.is_f?(input)
      stack << Float(input)
    elsif OPERATIONS.include?(input.to_sym)
      do_operation(input.to_sym)
    else
      puts "Invalid input"
    end
  end

  def get_input
    puts "Enter input"
    input = gets.chomp
    if input.downcase.strip == "exit"
      return "exit"
    end
    input_arr = input.split(" ")
    input_arr.each {|entry| process_input(entry)}
  end

  def do_operation(operation)
    if stack.length < 2
      puts "Error: not enough numbers in the stack"
      return
    end
    x, y = stack.pop, stack.pop
    result = x.send operation, y
    stack << result
  end

  def self.is_f?(string)
    string =~ /\A-?\d*\.\d+\Z/
  end

  def self.is_i?(string)
    string =~ /\A-?\d+\.?\Z/
  end

  def run
    loop do
      p stack
      if get_input == "exit"
        return
      end
    end
  end

end

if $PROGRAM_NAME == __FILE__
  calc = Calculator.new
  calc.run
end



# p Calculator.is_i?("")
# p Calculator.is_i?("134")
# p Calculator.is_i?("1d4")
# p Calculator.is_i?("2.1")
# p Calculator.is_i?("2.")
# p Calculator.is_f?("")
# p Calculator.is_f?("134")
# p Calculator.is_f?("1d4")
# p Calculator.is_f?("2.1")
# p Calculator.is_f?("2.0")
# p Calculator.is_f?(".1")
# p Calculator.is_f?("2.")
