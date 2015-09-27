json.array!(@rewards_cards) do |rewards_card|
  json.extract! rewards_card, :id
  json.url rewards_card_url(rewards_card, format: :json)
end
