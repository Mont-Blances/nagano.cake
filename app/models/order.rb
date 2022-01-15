class Order < ApplicationRecord
  enum payment_method:{credit: 0,bank:1}
  enum order_status:{wait: 0, confirmation: 1, making: 2, preparation: 3, finish: 4}
end
