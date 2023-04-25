class Warehouse < ApplicationRecord
  validates :name, :code, :address, :city, :area, :cep, :description, presence: true
  validates :code, uniqueness: true
end
