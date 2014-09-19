class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :user_id, :deck_id
      t.integer :correct_count, :incorrect_count, default: 0

      t.timestamps
    end
  end
end
