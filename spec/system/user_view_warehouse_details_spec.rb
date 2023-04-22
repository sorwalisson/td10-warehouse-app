require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
  it 'e vê adicionais' do
    #arrange
    Warehouse.create(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    #act
    visit('/')
    click_on('Aeroporto SP')
    
    #assert
    expect(page).to have_content("Galpão GRU")
    expect(page).to have_content("Nome: Aeroporto SP")
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100000 m²')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
    expect(page).to have_content('Descrição: Galpão destinado a encomendas internacionais')
  end
end