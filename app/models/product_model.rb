class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items
  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: {is: 20}
  validates :weight, :width, :height, comparison: {greater_than: 0}

  def dimensions
    "#{self.width}cm x #{self.height}cm x #{self.depth}cm"
  end
end
