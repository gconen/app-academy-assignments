WINNER_HASH = {
  paper: "rock",
  rock: "scissors",
  scissors: "paper"
}

RPS = %w(Rock Paper Scissors)

def rps(player_choice)
  comp_choice = RPS.sample
  print comp_choice + ", "
  puts determine_result(player_choice, comp_choice)
end

def number_to_choice(choice)
  NUMBER_TO_RPS[choice]
end


def determine_result(player, computer)
  player_choice = player.downcase
  computer_choice = computer.downcase
  if player_choice == computer_choice
    "Draw."
  elsif WINNER_HASH[player_choice.to_sym] == computer_choice
    "Win."
  else
    "Lose."
  end
end

rps("Scissors")
