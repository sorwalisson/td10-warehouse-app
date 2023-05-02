class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order
  validate :verify_supplier_product
  validates :quantity, comparison: {greater_than: 0}


  def verify_supplier_product
    if self.product_model.supplier_id != self.order.supplier_id
      self.errors.add(:product_model_id, "Esse produto não pertence ao fornecedor deste pedido")
    end
  end
end
