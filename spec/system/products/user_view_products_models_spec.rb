require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'a partir do menu' do
    #arrange



    #act
    visit root_path
    within('nav') do
      click_on 'Modelos de produtos'
    end

    #asset
    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    #arrange
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "34.006.033/0001-57", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product1 = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                    sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    product2 = ProductModel.create!(name: "Sound System 7.1", weight: 2800, width: 60, height: 50, depth: 30, 
                                    sku: 'SOSAM1-SAMSU2-LOUD77', supplier_id: supplier.id)
    #act
    visit root_path
    within('nav') do
      click_on 'Modelos de produtos'
    end
    #assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32PL-SAMSUG-XPT090'
    expect(page).to have_content 'SAMSUNG'
    expect(page).to have_content 'Sound System 7.1'
    expect(page).to have_content 'SOSAM1-SAMSU2-LOUD77'
    expect(page).to have_content 'SAMSUNG'
  end

  it 'não modelos de produtos cadastrados' do

    visit root_path
    within('nav') do
      click_on 'Modelos de produtos'
    end

    expect(page).to have_content 'Não há modelos de produtos cadastrados'
  end
end