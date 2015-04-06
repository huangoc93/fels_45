class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, index: {unique: true}, null: false
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :name
      t.string :avatar
      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end
