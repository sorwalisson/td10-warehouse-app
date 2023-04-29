require 'rails_helper'

describe 'usuario registra supplier' do
  it 'usuario clicka em registrar fornecedor' do
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Registrar Fornecedor'

    expect(current_path).to eq new_supplier_path
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Email'
  end

  it 'com sucesso' do
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Registrar Fornecedor'

    fill_in 'Razão Social', with: "Bugigangas SA"
    fill_in 'Nome Fantasia', with: "Play Bugigangas"
    fill_in 'CNPJ', with: '123456789000'
    fill_in 'Endereço', with: "Avenida Tomaz Espindola, 10"
    fill_in 'Cidade', with: "Maceió"
    fill_in 'Estado', with: 'AL'
    fill_in 'Email', with: 'bugigangas_sa@sac.com.br'
    click_on 'Enviar'

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor cadastrado com sucesso.'
    expect(page).to have_content 'Bugigangas SA'
    expect(page).to have_content 'Play Bugigangas'
    expect(page).to have_content '123456789000'
  end

  it 'com dados incompletos' do
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Registrar Fornecedor'

    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ""
    click_on 'Enviar'

    expect(page).to have_content "Fornecedor não cadastrado."
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Email não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
  end
end