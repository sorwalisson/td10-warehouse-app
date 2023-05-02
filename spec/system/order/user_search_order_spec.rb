require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'e deve estar autenticada' do
    #arrange

    #act
    visit root_path

    #assert

    within('header nav') do
      expect(page).to_not have_field 'Buscar Pedido'
      expect(page).to_not have_button 'Buscar'
    end
  end
  
  it 'a partir do menu' do
    #arrange
    new_user = User.create(name: "Walisson", email: "sorwalisson@email.com", password: "password")

    #act
    login_as(new_user)
    visit root_path


    #assert
    within('header nav') do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e encontra um pedido' do
    #arrange
    new_user = User.create(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: 1.day.from_now)
    #act
    login_as(new_user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    #assert
    expect(current_path).to eq order_path(id: order.id)
    expect(page).to have_content(order.code)
  end

  it 'encontra multiplos pedidos' do
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
    date2 = 5.days.from_now
    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU1111111')
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"))
    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU2222222')
    second_order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date2.strftime("%d/%m/%Y"))
    allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ1111111')
    third_order = Order.create!(user_id: new_user.id, warehouse_id: second_warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date2.strftime("%d/%m/%Y"))
    login_as(new_user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'

    expect(page).to have_content('GRU1111111')
    expect(page).to have_content('GRU2222222')
    expect(page).to have_content('Galpão Destino: GRU - Aeroporto SP')
    expect(page).to_not have_content('MCZ1111111')
    expect(page).to_not have_content('Galpão Destino: Maceio - MCZ')
  end
end