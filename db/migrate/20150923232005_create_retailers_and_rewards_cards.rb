class CreateRetailersAndRewardsCards < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.references :rewards_cards, index: true
      t.string :name

      t.timestamps null: false
    end

    create_table :rewards_cards do |t|
      t.belongs_to :user, index: true
      t.belongs_to :retailer, index: true
      t.string :rewards_number

      t.timestamps null: false
    end
  end
end
