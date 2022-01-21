class OrderDetail < ApplicationRecord
  enum production_status:{before: 0,wait:1,make:2,finish:3}

belongs_to :order
belongs_to :item

end
