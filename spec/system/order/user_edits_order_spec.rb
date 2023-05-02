require 'rails_helper'

describe 'usuario tenta editar pedido' do
  it 'a partir do menu inicial ele vai para pagina de editar' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_model = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                         sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    second_warehouse =  Warehouse.create(name: 'Maceio', code: "MCZ", city: "Maceio", area: 50_000, address: "Avenida Zumbi dos Palmares, 50", 
                                         cep: "57000-000", description: "Galpão do aeroporto zumbi dos palmares")
    second_supplier = Supplier.create!(corporate_name: 'LG do Brasil LTDA', brand_name: 'LG', registration_number: "987654321000", 
                                       full_address: "Avenida Paulista, 40", city: "São Paulo", state: "SP", email: "LG@sac.com.br")
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))

    login_as(new_user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    click_on 'Editar'

    expect(page).to have_content 'Editar Pedido'
    expect(page).to have_button 'Gravar'
    expect(page).to have_select 'Galpão Destino', text: warehouse.full_description
    expect(page).to have_select 'Fornecedor', text: supplier.full_description
    expect(page).to have_field 'Data Prevista', with: date.strftime("%Y-%m-%d")
  end
  
  it 'com sucesso' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_model = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                         sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    second_warehouse =  Warehouse.create!(name: 'Maceio', code: "MCZ", city: "Maceio", area: 50_000, address: "Avenida Zumbi dos Palmares, 50", 
                                         cep: "57000-000", description: "Galpão do aeroporto zumbi dos palmares")
    second_supplier = Supplier.create!(corporate_name: 'LG do Brasil LTDA', brand_name: 'LG', registration_number: "987654321000", 
                                       full_address: "Avenida Paulista, 40", city: "São Paulo", state: "SP", email: "LG@sac.com.br")
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))
    date2 = 5.days.from_now

    login_as(new_user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    click_on 'Editar'
    select second_warehouse.full_description, from: "Galpão Destino"
    select 'LG do Brasil LTDA - LG', from: "Fornecedor"
    fill_in 'Data Prevista', with: date2.strftime("%d/%m/%Y")
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Galpão Destino: MCZ - Maceio'
    expect(page).to have_content "#{order.code}"
    expect(page).to have_content 'Fornecedor: LG do Brasil LTDA - LG'
    expect(page).to have_content 'Usuário Responsável: Walisson - sorwalisson@email.com'
    expect(page).to have_content "Data Prevista de Entrega: #{date2.strftime("%d/%m/%Y")}"
  end

  it 'usuario tenta editar pedido de outro usuario' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    second_user = User.create!(name: "Mario", email: "mario@mario.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_model = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                         sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    second_warehouse =  Warehouse.create!(name: 'Maceio', code: "MCZ", city: "Maceio", area: 50_000, address: "Avenida Zumbi dos Palmares, 50", 
                                         cep: "57000-000", description: "Galpão do aeroporto zumbi dos palmares")
    second_supplier = Supplier.create!(corporate_name: 'LG do Brasil LTDA', brand_name: 'LG', registration_number: "987654321000", 
                                       full_address: "Avenida Paulista, 40", city: "São Paulo", state: "SP", email: "LG@sac.com.br")
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))

    login_as(second_user)
    visit order_path(id: order.id)

    expect(page).to have_content "Acesso Negado, você não é o usuário que gerou esse pedido"
    expect(current_path).to eq root_path
  end
end