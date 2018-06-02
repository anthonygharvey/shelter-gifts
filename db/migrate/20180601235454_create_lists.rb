class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.integer :shelter_id
      t.integer :item_id
      t.string  :name
      t.string  :description
      t.string  :url

      t.timestamps
    end
  end
end
