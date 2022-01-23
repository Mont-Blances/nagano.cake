class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  validates :name, presence: true
  validates :item_introduction, presence: true
  validates :price, presence: true
  validates :is_active, inclusion: [true, false]


  def taxin_price
    (self.price * 1.10).round
  end
end
