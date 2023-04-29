require 'rails_helper'


describe 'usuario edita um fornecedor' do
  it 'usuario clicka em editar fornecedor, e vê formulário com informações a serem editadas' do
    supplier = Supplier.create!(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    
    login_as(new_user)
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Bugigangas SA'
    click_on 'Editar'

    expect(current_path).to eq edit_supplier_path(id: supplier.id)
    expect(page).to have_field("Razão Social", with: 'Bugigangas SA')
    expect(page).to have_field("Nome Fantasia", with: "Play Bugigangas")
    expect(page).to have_field("Cidade", with: "Maceió")
    expect(page).to have_field("Estado", with: "AL")
    expect(page).to have_field("Endereço", with: 'Avenida Tomaz Espindola, 10')
    expect(page).to have_field("CNPJ", with: '123456789000')
    expect(page).to have_field("Email", with: 'Bugiganas_SA@sac.com.br')
  end

  it 'com sucesso' do
    supplier = Supplier.create!(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    
    login_as(new_user)
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Bugigangas SA'
    click_on 'Editar'
    fill_in "Razão Social", with: "Bugigas SA"
    fill_in "Nome Fantasia", with: "Brinquedos Bugigangas"
    click_on "Enviar"

    expect(current_path).to eq supplier_path(id: supplier.id)
    expect(page).to have_content "Fornecedor editado com sucesso."
    expect(page).to have_content "Bugigas SA"
    expect(page).to have_content "Brinquedos Bugigangas"
  end

  it "com informações incompletas" do
    supplier = Supplier.create!(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    
    login_as(new_user)
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Bugigangas SA'
    click_on 'Editar'
    fill_in "Razão Social", with: ""
    fill_in "Nome Fantasia", with: ""
    click_on "Enviar"

    expect(page).to have_content "Fornecedor não editado"
  end

end