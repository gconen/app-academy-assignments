json.extract! pokemon, :id, :attack, :defense, :image_url, :moves, :name, :poke_type
json.toys do
  json.array! pokemon.toys, partial: 'toys/toy', as: :toy if display_toys
end
