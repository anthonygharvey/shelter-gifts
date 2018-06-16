class AddVerifiedToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :verified, :boolean, default: false
  end
end
