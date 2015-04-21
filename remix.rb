def remix(drinks, deterministic = false)
  alcohols = drinks.collect {|drink| drink[0]}
  mixers = drinks.collect {|drink| drink[1]}
  if deterministic
    shifted = mixers.shift
    mixers << shifted
  else
    mixers.shuffle!
  end
  mix_drinks(alcohols, mixers)
end

def mix_drinks(alcohols, mixers)
  new_drinks = []
  alcohols.each_index do |drink_number|
    new_drinks << [alcohols[drink_number], mixers[drink_number]]
  end
  new_drinks
end


p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
], true)
