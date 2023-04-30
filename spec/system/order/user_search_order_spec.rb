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
    expect(page).to have_content "Resultado da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código do pedido: #{order.code}"
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).to have_content "Fornecedor: Samsung korea LTDA - SAMSUNG"
  end
end