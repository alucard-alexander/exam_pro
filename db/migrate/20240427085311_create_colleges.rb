class CreateColleges < ActiveRecord::Migration[7.1]
  def change
    create_table :colleges do |t|
      t.string :title

      t.timestamps
    end
    add_index :colleges, :title
  end
end
