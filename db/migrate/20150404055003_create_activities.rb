class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id, index: true
      t.string :description

      t.timestamps null: false
    end

    add_foreign_key :activities, :users
  end
end
