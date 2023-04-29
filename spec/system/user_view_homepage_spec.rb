require 'rails_helper'

describe "Users visits the homepage" do
  it "and see the name of the app" do
    # Arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    
    #act
    login_as(new_user)
    visit(root_path)

    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end


  it 'e vê os galpões cadastrados' do
    #arrange
    Warehouse.create(name: 'Rio', code: "SDU", city: "Rio de Janeiro", area: 60_000, address: "Avenida do aeroporto, 1000", cep: '20000-000', description: "Galpão do aeroporto santos dumont")
    Warehouse.create(name: 'Maceio', code: "MCZ", city: "Maceio", area: 50_000, address: "Avenida Zumbi dos Palmares, 50", cep: "57000-000", description: "Galpão do aeroporto zumbi dos palmares")
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    
    #act
    login_as(new_user)
    visit(root_path)
    #assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content("Código: SDU")
    expect(page).to have_content("Rio de Janeiro")
    expect(page).to have_content("60000 m²")

    expect(page).to have_content('Maceio')
    expect(page).to have_content("Código: MCZ")
    expect(page).to have_content("Maceio")
    expect(page).to have_content("50000 m²")
  end

  it 'e não existe galpões cadastrados' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    
    #act
    login_as(new_user)
    visit(root_path)
    #assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end 