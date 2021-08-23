class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def change
    add_column :customers, :is_active, :boolean, default: true, null: false
  end

  has_many :cart_items
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, :last_name, :kana_first_name, :kana_last_name,:residence, :phone_number, presence: true
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  validates :phone_number, numericality: { only_integer: true }
end
