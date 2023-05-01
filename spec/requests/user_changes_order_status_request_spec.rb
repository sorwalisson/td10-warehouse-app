require 'rails_helper'

describe 'user manda requisição para mudar status do pedido' do
  it 'tenta mudar status para delivered e não é o usuário responsável pelo pedido' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    second_user = User.create!(name: "Mario", email: "mario@mario.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    second_warehouse =  Warehouse.create!(name: 'Maceio', code: "MCZ", city: "Maceio", area: 50_000, address: "Avenida Zumbi dos Palmares, 50", 
                                         cep: "57000-000", description: "Galpão do aeroporto zumbi dos palmares")
    second_supplier = Supplier.create!(corporate_name: 'LG do Brasil LTDA', brand_name: 'LG', registration_number: "987654321000", 
                                       full_address: "Avenida Paulista, 40", city: "São Paulo", state: "SP", email: "LG@sac.com.br")
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))

    login_as(second_user)
    post(delivered_order_path(order.id))

    expect(response).to redirect_to(root_path)
    expect(order.status).to eq "pending"
  end
  
  it 'tenta mudar status para canceled e não é o usuário responsável pelo pedido' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    second_user = User.create!(name: "Mario", email: "mario@mario.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    second_warehouse =  Warehouse.create!(name: 'Maceio', code: "MCZ", city: "Maceio", area: 50_000, address: "Avenida Zumbi dos Palmares, 50", 
                                         cep: "57000-000", description: "Galpão do aeroporto zumbi dos palmares")
    second_supplier = Supplier.create!(corporate_name: 'LG do Brasil LTDA', brand_name: 'LG', registration_number: "987654321000", 
                                       full_address: "Avenida Paulista, 40", city: "São Paulo", state: "SP", email: "LG@sac.com.br")
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))

    login_as(second_user)
    post(canceled_order_path(order.id))

    expect(response).to redirect_to(root_path)
    expect(order.status).to eq "pending"
  end
end