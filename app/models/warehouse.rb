class Warehouse < ApplicationRecord
  validates :name, :code, :address, :city, :area, :cep, :description, presence: true
  validates :code, :name, uniqueness: true
  #validates :cep, length: {is: 9}
end
