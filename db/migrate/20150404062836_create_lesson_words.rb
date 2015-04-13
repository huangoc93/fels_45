class CreateLessonWords < ActiveRecord::Migration
  def change
    create_table :lesson_words do |t|
      t.integer :lesson_id, index: true
      t.integer :word_id, index: true
      t.boolean :correct

      t.timestamps null: false
    end

    add_index :lesson_words, [:lesson_id, :word_id], unique: true
    add_foreign_key :lesson_words, :lessons
    add_foreign_key :lesson_words, :words
  end
end
