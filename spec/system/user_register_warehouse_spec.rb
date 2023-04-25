require 'rails_helper'

describe 'usuario cadastra galpão' do
  it 'a partir da tela inicial, usuario cliecka em cadastrar galpão' do
    #arrange
    visit(root_path)
    #act
    visit root_path
    click_on 'Cadastrar Galpão'
    #assert
    expect(page).to have_field("Nome")
    expect(page).to have_field("Código")
    expect(page).to have_field("Cidade")
    expect(page).to have_field("Área")
    expect(page).to have_field("Endereço")
    expect(page).to have_field("CEP")
    expect(page).to have_field("Descrição")
  end

  it 'Com sucesso' do
    #arrange


    #act
    visit root_path
    click_on "Cadastrar Galpão"
    fill_in 'Nome', with: "Maceió"
    fill_in 'Código', with: "MCZ"
    fill_in 'Cidade', with: "Maceió"
    fill_in 'Área', with: '25000'
    fill_in 'Endereço', with: "Aeroporto Zumbi dos Palmares, 100"
    fill_in 'CEP', with: "57000-000"
    fill_in 'Descrição', with: 'Galpão do Aeroporto Zumbi dos Palmares, destinado à encomendas para o estado de Alagoas'
    click_on "Criar Galpão"
    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão cadastrado com sucesso'
    expect(page).to have_content 'Maceió'
    expect(page).to have_content 'MCZ'
    expect(page).to have_content '25000 m²'
  end


  it 'Com dados incompletos' do
    #arrange


    #act
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ""
    click_on 'Criar Galpão'

    #assert
    expect(page).to have_content 'Galpão não cadastrado'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'

  end
end