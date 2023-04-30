require 'rails_helper'

describe 'Usuario faz cadastro' do
  it 'com sucesso' do
    #arrange
    
    #act
    visit root_path
    click_on "Criar Conta"
    fill_in 'Nome', with: "Walisson"
    fill_in "E-mail", with: "sorwalisson@email.com"
    fill_in "Senha", with: "password"
    fill_in "Confirme sua senha", with: "password"
    click_on "Criar Conta"
    
    #assert
    expect(page).to have_content "Boas vindas! Você realizou seu registro com sucesso."
    expect(page).to have_content "sorwalisson@email.com"
    expect(page).to have_content "Olá Walisson"
    expect(page).to have_button "Sair"
    expect(page).to_not have_link "Entrar"
  end
end