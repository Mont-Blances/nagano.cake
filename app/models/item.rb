class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_items
    with_options presence: true do
    validates :name
    validates :item_introduction
    validates :price

  end
end
