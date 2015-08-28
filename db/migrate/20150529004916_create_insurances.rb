class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.belongs_to :user, index: true
      t.string :first_name
      t.string :last_name
      t.string :enrolee_id
      t.string :group_number
      t.integer :insurer_id

      t.timestamps null: false
    end
  end
end
