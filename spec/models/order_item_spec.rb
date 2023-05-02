require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'validates' do
    it 'validates maior que 0' do
      new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                    cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
      product_a = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                      sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
      date = 1.day.from_now
      order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)
      
      item = OrderItem.new(product_model_id: product_a.id, quantity: 0, order_id: order.id)

      expect(item.valid?).to be_falsy
    end
    it 'if the product_model_supplier and order_supplier is not the same' do
      new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      supplier_2 = Supplier.create!(corporate_name: 'SAMSUNG FALSA', brand_name: 'SAMSUNG FALSA', registration_number: "123456789111", 
                                    full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                    cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
      product_a = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                      sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
      date = 1.day.from_now
      order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier_2.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)
      
      item = OrderItem.new(product_model_id: product_a.id, quantity: 10, order_id: order.id)

      expect(item.valid?).to be_falsy
    end
  end
end
