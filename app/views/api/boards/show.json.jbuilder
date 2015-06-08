
json.extract! @board, :id, :title, :user_id
json.lists @board.lists do |json, list|
  json.extract! list, :id, :title, :ord
  json.cards list.cards, :id, :title, :ord, :list_id
end
json.members @board.members, :id
