class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :list_id
      t.string  :name
      t.decimal :price, precision: 10, scale: 2
      t.string  :photo
      t.boolean :prime_status
      t.string  :comment
      t.integer :quantity
      t.string  :priority
      t.integer :has_amount
      t.string  :url

      t.timestamps
    end
  end
end
