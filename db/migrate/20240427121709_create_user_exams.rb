class CreateUserExams < ActiveRecord::Migration[7.1]
  def change
    create_table :user_exams do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true
      t.references :college, null: false, foreign_key: true
      t.datetime :start_time

      t.timestamps
    end
  end
end
