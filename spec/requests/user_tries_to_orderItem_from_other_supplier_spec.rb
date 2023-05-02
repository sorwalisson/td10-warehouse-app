require 'rails_helper'

describe 'usuario tenta gerar orderitem de outro fornecedor' do
  it 'e não tem sucesso, devido a fornecedor do pedido n ser o mesmo do produto' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    supplier_2 = Supplier.create!(corporate_name: 'SAMSUNG FALSA', brand_name: 'SAMSUNG FALSA', registration_number: "123456789111", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_a = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                        sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    product_b = ProductModel.create!(name: "Sound System 7.1", weight: 5000, width: 50, height: 35, depth: 15, 
                                          sku: "SOUSYS-SAMSUG-SPT080", supplier_id: supplier_2.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)

    login_as(new_user)
    post(order_order_items_path(order_id: order.id), params: {order_item: {product_model_id: product_b.id, quantity: 2}})
    expect(response).to redirect_to root_path
  end

  it 'e não tem sucesso, devido a quantidade ser menor ou igual a 0' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    supplier_2 = Supplier.create!(corporate_name: 'SAMSUNG FALSA', brand_name: 'SAMSUNG FALSA', registration_number: "123456789111", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_a = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                        sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    product_b = ProductModel.create!(name: "Sound System 7.1", weight: 5000, width: 50, height: 35, depth: 15, 
                                          sku: "SOUSYS-SAMSUG-SPT080", supplier_id: supplier_2.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)

    login_as(new_user)
    post(order_order_items_path(order_id: order.id), params: {order_item: {product_model_id: product_a.id, quantity: 0}})
    expect(response).to redirect_to root_path
  end
end