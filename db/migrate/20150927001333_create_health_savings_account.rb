class CreateHealthSavingsAccount < ActiveRecord::Migration
  def change
    create_table :health_savings_accounts do |t|
      t.belongs_to :user, index: true
      t.string :account_number, index: true
      t.string :routing_number
      t.string :account_name

      t.timestamps null: false
    end
  end
end
