class CreateApiRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :api_requests do |t|
      t.text :url
      t.integer :request_verb
      t.json :request_body
      t.integer :response_status
      t.json :response_body

      t.timestamps
    end
  end
end
