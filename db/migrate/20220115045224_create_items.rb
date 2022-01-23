class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :is_active, default: true, null: false
      t.text :item_introduction
      t.integer :price
      t.string :image_id
      t.integer :genre_id
      t.timestamps
    end
  end
end
