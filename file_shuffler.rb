def shuffle_file(file_name)
  contents = File.readlines(file_name)
  contents.shuffle!

  File.open("#{file_name}-shuffled.txt", 'w') do |file|
    file.print(contents.join(""))
  end
end

def file_shuffler
  file_name
  until file_name && File.exist?(file_name)
    puts "What file shall be shuffled?"
    file_name = gets.chomp
    unless File.exist?(file_name)
      puts "That's not a valid file."
    end
  end

  shuffle_file(file_name)
end

file_shuffler
