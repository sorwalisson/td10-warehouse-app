require 'rails_helper'

describe 'usuário vê seus proprios pedidos' do
  it 'e deve esta autenticado' do
    #arrange

    #act
    visit orders_path
    #assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    second_user = User.create!(name: "Mario", email: "mario@mario.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    first_order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))
    second_order = Order.create!(user_id: second_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: "delivered")
    third_order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: "canceled")
    #act
    login_as(new_user)
    visit root_path
    click_on 'Meus Pedidos'

    #assert
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Pendente'
    expect(page).to_not have_content second_order.code
    expect(page).to have_content third_order.code
    expect(page).to have_content 'Cancelado'
  end

  it 'e visita um pedido' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    first_order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))
    #act
    login_as(new_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on first_order.code

    #assert
    expect(page).to have_content "Pedido #{first_order.code}"
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).to have_content "Data Prevista de Entrega: #{date.strftime("%d/%m/%Y")}"
  end

  it 'e não visita pedidos de outros usuário' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    second_user = User.create!(name: "Chihiro", email: "spiritedaway@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    first_order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))

    #act
    login_as(second_user)
    visit order_path(id: first_order.id)

    #assert
    expect(current_path).to_not eq order_path(id: first_order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content "Acesso Negado, você não é o usuário que gerou esse pedido"
  end

  it 'e vê items do pedido' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_a = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                     sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    product_b = ProductModel.create!(name: "Sound System 7.1", weight: 2800, width: 60, height: 50, depth: 30, 
                                     sku: 'SOSAM1-SAMSU2-LOUD77', supplier_id: supplier.id)
    product_c = ProductModel.create!(name: "Samsung Galaxy A30", weight: 1200, width: 30, height: 20, depth: 15, 
                                    sku: 'SAGGLY-SAMPH2-MPHM77', supplier_id: supplier.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now                             
    first_order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))
    OrderItem.create!(product_model_id: product_a.id, order_id: first_order.id, quantity: 20)
    OrderItem.create!(product_model_id: product_b.id, order_id: first_order.id, quantity: 12)
    
    #act
    login_as(new_user)
    visit root_path
    click_on "Meus Pedidos"
    click_on first_order.code

    #assert
    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '20 x TV 32'
    expect(page).to have_content '12 x Sound System 7.1'
  end
end