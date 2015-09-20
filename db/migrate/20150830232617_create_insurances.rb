class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.belongs_to :user, index: true
      t.string :enrollee_id
      t.string :group_number

      t.timestamps null: false
    end
  end
end
