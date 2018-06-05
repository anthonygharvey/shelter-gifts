class AddDefaultValueToItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :prime_status, :boolean, default: false
  end
end
