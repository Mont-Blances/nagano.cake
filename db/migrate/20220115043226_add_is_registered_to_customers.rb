class AddIsRegisteredToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :is_registered, :boolean, default: true
  end
end
