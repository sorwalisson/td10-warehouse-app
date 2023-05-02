class Warehouse < ApplicationRecord
  validates :name, :code, :address, :city, :area, :cep, :description, presence: true
  validates :code, :name, uniqueness: true
  has_many :stock_products
  #validates :cep, length: {is: 9}


  def full_description
    "#{self.code} - #{self.name}"
  end
end
