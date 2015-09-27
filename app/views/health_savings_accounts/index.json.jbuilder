json.array!(@health_savings_accounts) do |health_savings_account|
  json.extract! health_savings_account, :id
  json.url health_savings_account_url(health_savings_account, format: :json)
end
