class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
    with_options presence: true do
    validates :name
    validates :item_introduction
    validates :price

  end
end
