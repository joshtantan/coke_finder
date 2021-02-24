class CreateUpdates < ActiveRecord::Migration[6.1]
  def change
    create_table :updates do |t|
      t.integer :source_id
      t.string :user_handle
      t.float :sentiment
      t.integer :followers
      t.text :message

      t.timestamps
    end
  end
end
