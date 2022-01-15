class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.string :postcode
      t.string :address
      t.string :destination

      t.timestamps
    end
  end
end
