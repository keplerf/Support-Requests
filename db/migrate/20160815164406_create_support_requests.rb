class CreateSupportRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :support_requests do |t|
      t.string :name
      t.string :email
      t.integer :department, default: 0
      t.text :message
      t.boolean :complete, null: false, default: false

      t.timestamps
    end
  end
end
