class CreateLessonQuizzes < ActiveRecord::Migration
  def change
    create_table :lesson_quizzes do |t|
      t.integer :lesson_id, index: true
      t.integer :quiz_id, index: true
      t.boolean :correct

      t.timestamps null: false
    end

    add_index :lesson_quizzes, [:lesson_id, :quiz_id], unique: true
    add_foreign_key :lesson_quizzes, :lessons
    add_foreign_key :lesson_quizzes, :quizzes
  end
end
