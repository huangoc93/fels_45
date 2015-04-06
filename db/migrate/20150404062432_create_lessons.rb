class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :user_id, index: true
      t.integer :category_id, index: true

      t.timestamps null: false
    end

    add_foreign_key :lessons, :users
    add_foreign_key :lessons, :categories
  end
end
