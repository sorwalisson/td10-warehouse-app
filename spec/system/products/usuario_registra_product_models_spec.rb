require 'rails_helper'

describe 'usuário cadastra modelo de produto' do
  it 'com sucesso' do
    #arrange
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "34.006.033/0001-57", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    second_supplier = Supplier.create!(corporate_name: 'LG do Brasil LTDA', brand_name: 'LG', registration_number: "45.006.673/0001-57", 
                                       full_address: "Avenida Paulista, 40", city: "São Paulo", state: "SP", email: "LG@sac.com.br")

    #act
    visit root_path
    click_on 'Modelos de produtos'
    click_on 'Registrar modelo de produto'
    fill_in 'Nome', with: "TV 32"
    fill_in 'Peso', with: 8000
    fill_in 'Largura', with: 70
    fill_in 'Altura', with: 45
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: "TV32-SAMSU-XPT090"
    select 'Samsung', from: "Fornecedor"
    click_on 'Enviar'

    #assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    expect(page).to have_content 'Produto: TV 32'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPT090'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'Peso: 8000g'
    expect(page).to have_content 'Dimensões: 70cm x 45cm x 10cm'
  end

  it 'sem sucesso, usuario n colocou informações' do
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "34.006.033/0001-57", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    second_supplier = Supplier.create!(corporate_name: 'LG do Brasil LTDA', brand_name: 'LG', registration_number: "45.006.673/0001-57", 
                                full_address: "Avenida Paulista, 40", city: "São Paulo", state: "SP", email: "LG@sac.com.br")
    
    visit root_path
    click_on 'Modelos de produtos'
    click_on 'Registrar modelo de produto'
    

    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ""
    select 'Samsung', from: "Fornecedor"
    click_on 'Enviar'
    

    expect(page).to have_content "Não foi possível cadastrar modelo de produto."
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'SKU não pode ficar em branco'
  end
end