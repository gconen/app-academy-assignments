def make_change(value, coins)
  return [value] if coins.include?(value)

  possibles = []
  coins.each do |coin|
    next if coin > value
    remaining = value - coin
    remaining_coins = make_change(remaining, coins)
    next if remaining_coins.nil?
    remaining_coins.unshift(coin)
    possibles << remaining_coins
  end

  return possibles.min_by { |change| change.count }
end
