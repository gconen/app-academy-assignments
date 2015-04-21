def shuffle_file(filename)
  contents = File.readlines(filename)
  contents.shuffle!

  File.open("#{filename}-shuffled.txt", 'w') do |file|
    file.print(contents.join(""))
  end
end

shuffle_file("dictionary.txt")
