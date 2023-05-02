require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe "gera um número de série" do
    it 'ao cirar um stock product' do
      new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                    cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
      product = ProductModel.create!(supplier_id: supplier.id, name: "Smart TV 32", weight: 10000, height: 40, width: 30, depth: 30, sku: "STV32S-SAMSUN-LEDTV2")
      order = Order.create(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: 1.day.from_now, status: :delivered)

      stock_product = StockProduct.create!(order_id: order.id, warehouse_id: warehouse.id, product_model_id: product.id)

      expect(stock_product.serial_number.length).to eq 20
    end

    it 'não deve mudar ao atualziar objeto' do
      new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                    cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
      second_warehouse = Warehouse.create!(name: "Aeroporto MCZ", code: "MCZ", city: "Maceio", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                      cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
      product = ProductModel.create!(supplier_id: supplier.id, name: "Smart TV 32", weight: 10000, height: 40, width: 30, depth: 30, sku: "STV32S-SAMSUN-LEDTV2")
      order = Order.create(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: 1.day.from_now, status: :delivered)
      stock_product = StockProduct.create!(order_id: order.id, warehouse_id: warehouse.id, product_model_id: product.id)
      first_serial = stock_product.serial_number

      stock_product.update(warehouse_id: second_warehouse.id)
      stock_product.reload

      expect(stock_product.serial_number).to eq first_serial
    end
  end
end
