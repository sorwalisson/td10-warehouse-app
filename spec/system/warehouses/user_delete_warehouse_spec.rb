require 'rails_helper'

describe 'user remove um galpão' do
  it 'com sucesso' do
    #arrange
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
      cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    
    #act
    login_as(new_user)
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Remover'
    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso.'
    expect(page).to_not have_content 'Aeroporto SP'
    expect(page).to_not have_content 'GRU'
  end

  it 'não apaga os demais galpões' do
    #arrange
    first_warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
      cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    second_warehouse =  Warehouse.create(name: 'Maceio', code: "MCZ", city: "Maceio", area: 50_000, address: "Avenida Zumbi dos Palmares, 50", 
      cep: "57000-000", description: "Galpão do aeroporto zumbi dos palmares")
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    
    #act
    login_as(new_user)
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Remover'

    #
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso.'
    expect(page).to_not have_content 'Aeroporto SP'
    expect(page).to_not have_content 'GRU'
    expect(page).to have_content 'Maceio'
    expect(page).to have_content 'MCZ'
  end
end