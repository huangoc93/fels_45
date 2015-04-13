class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name, index: {unique: true}, null: false
      t.integer :category_id, index: true

      t.timestamps null: false
    end

    add_foreign_key :words, :categories
  end
end
