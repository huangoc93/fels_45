class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, index: {unique: true}, null: false
      t.string :description
      t.string :avatar
      
      t.timestamps null: false
    end
  end
end
