require 'rails_helper'

describe 'usuario edita um galpão' do
  it 'a partir da pagina de detalhes de um galpão' do
    #arrange
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                     cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    #act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    #assert
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field("Nome", with: 'Aeroporto SP')
    expect(page).to have_field("Código", with: "GRU")
    expect(page).to have_field("Cidade", with: "Guarulhos")
    expect(page).to have_field("Área", with: "100000")
    expect(page).to have_field("Endereço", with: 'Avenida do Aeroporto, 1000')
    expect(page).to have_field("CEP", with: '15000-000')
    expect(page).to have_field("Descrição", with: 'Galpão destinado a encomendas internacionais.')
  end


  it 'usuario edita informações e clicka em enviar, e edita com sucesso' do
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
      cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    #act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão Internacional'
    fill_in 'Área', with: '200000'
    fill_in 'Endereço', with: 'Avenida dos Galpões, 500'
    fill_in 'CEP', with: '16000-000'
    click_on 'Enviar'

    #assert
    
    expect(current_path).to eq warehouse_path(id: warehouse.id)
    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Galpão Internacional'
    expect(page).to have_content '200000'
    expect(page).to have_content 'Avenida dos Galpões, 500'
    expect(page).to have_content '16000-000'
  end

  it 'usuario tenta editar galpão, mas sem sucesso devido a falta de attributos obrigatórios' do
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
      cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    #act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    click_on 'Enviar'

    #assert

    expect(page).to have_content 'Não foi possível atualizae galpão'
  end
end