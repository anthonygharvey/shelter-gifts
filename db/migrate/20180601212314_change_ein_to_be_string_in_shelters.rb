class ChangeEinToBeStringInShelters < ActiveRecord::Migration[5.2]
  def change
    change_column :shelters, :ein, :string
  end
end
