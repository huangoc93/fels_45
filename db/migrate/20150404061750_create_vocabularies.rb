class CreateVocabularies < ActiveRecord::Migration
  def change
    create_table :vocabularies do |t|
      t.string :spell, index: {unique: true}, null: false
      t.integer :category_id, index: true

      t.timestamps null: false
    end

    add_foreign_key :vocabularies, :categories
  end
end
