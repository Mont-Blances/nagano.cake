class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
 has_many :deliveries, dependent: :destroy
 has_many :cart_items, dependent: :destroy

  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true, format: { with: /\A[\p{katakana}\u{30fc}]+\z/, message: "全角カタカナのみで入力して下さい" }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\u{30fc}]+\z/, message: "全角カタカナのみで入力して下さい" }
  validates :postcode, numericality: {only_integer: true} #数値のみ
  validates :adress, presence: true
  validates :tel, numericality: {only_integer: true} #数値のみ
  validates :email, presence: true, uniqueness: true
  
  has_many :delivery, dependent: :destroy 
  has_many :order, dependent: :destroy
  
  def full_name
    self.family_name + " " + self.first_name
  end
 

end
