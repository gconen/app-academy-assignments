def stock_picker(prices)
  greatest_profit = nil
  best_days = []
  prices.each_with_index do |buy_price, buy_day|
    (buy_day + 1...prices.length).each do |sell_day|
      profit =  prices[sell_day] - buy_price
      if greatest_profit == nil || profit > greatest_profit
        greatest_profit = profit
        best_days = [buy_day, sell_day]
      end
    end
  end
  best_days
end

test_array = [1, 0, 1, 2, 3, 2]

p stock_picker(test_array)
