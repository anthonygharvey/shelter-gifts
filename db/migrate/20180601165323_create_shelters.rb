class CreateShelters < ActiveRecord::Migration[5.2]
  def change
    create_table :shelters do |t|
      t.integer :user_id
      t.string  :name
      t.string  :city
      t.string  :state
      t.integer :ein
      t.string  :shelter_type
      t.string  :description
      t.string  :website_url

      t.timestamps
    end
  end
end
