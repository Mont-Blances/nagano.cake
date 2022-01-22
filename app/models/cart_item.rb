class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def sum_taxin_price # 実際に作成したサイトは税金も算出していたのでメソッドを記載していました
    (item.price*quantity*1.1).round
  end


end
