class AddButtonTextAndButtonUrlToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :button_text, :string
    add_column :items, :button_url, :string
  end
end
