require 'rails_helper'

describe 'Usuario se autentica' do
  it 'com sucesso' do
    #arrange
    User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    #act
    visit root_path
    within('form') do
      fill_in "E-mail", with: 'sorwalisson@email.com'
      fill_in 'Senha', with: 'password'
      click_on "Entrar"
    end
    #assert

    expect(page).to have_button 'Sair'
    expect(page).to_not have_link 'Entrar'
    within('nav') do
      expect(page).to have_content "Walisson - sorwalisson@email.com"
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'faz log out' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    
    #act
    login_as(new_user)
    visit root_path
    click_on 'Sair'
    #assert

    expect(page).to_not have_button 'Sair'
    expect(page).to_not have_content 'sorwalisson@email.com'
    expect(page).to have_link 'Entrar'
  end
end