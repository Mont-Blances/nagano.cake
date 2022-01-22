class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  validates :quantity, numericality: {greater_than_or_equal_to:1,less_than_or_equal_to:10, message: '1回の注文は10個までです。' }
  def sum_taxin_price # 実際に作成したサイトは税金も算出していたのでメソッドを記載していました
  (item.price*quantity*1.1).round
  end
end
