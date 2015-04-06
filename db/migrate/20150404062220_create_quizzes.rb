class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :answer
      t.string :fake_answer_1
      t.string :fake_answer_2
      t.string :fake_answer_3
      t.integer :vocabulary_id, index: true

      t.timestamps null: false
    end

    add_foreign_key :quizzes, :vocabularies
  end
end
