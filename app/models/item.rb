class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
    with_options presence: true do
    validates :name
    validates :item_introduction
    validates :price

  end
end
