require 'rails_helper'

describe 'usuario cadastra novo pedido' do
  it 'deve estar autenticado' do
    #arrange
    
    #act
    visit new_order_path
    
    #assert
    expect(current_path).to eq new_user_session_path
  end

  it 'deve mostrar titulo traduzido' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    #act
    login_as(new_user)
    visit new_order_path
    #assert
    expect(page).to have_content "Registrar Pedido"
  end
  
  it 'com sucesso' do
    #arrange
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
    #act
    login_as(new_user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: "Galpão Destino"
    select 'Samsung korea LTDA - SAMSUNG', from: "Fornecedor"
    fill_in 'Data Prevista', with: "20/12/2022"
    click_on 'Gravar'
    
    #assert
    expect(page).to have_content 'Pedido cadastrado com sucesso.'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung korea LTDA - SAMSUNG'
    expect(page).to have_content 'Usuário Responsável: Walisson - sorwalisson@email.com'
    expect(page).to_not have_content 'Galpão Maceió'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
  end
end