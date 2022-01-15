class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.string :postcord
      t.string :address
      t.string :destination
      t.integer :postage, default: 800
      t.integer :billing_amount, default: 0
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end
