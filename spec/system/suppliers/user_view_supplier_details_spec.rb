require 'rails_helper'

describe 'usuario vê detalhes de um fornecedor' do
  it 'usuario clicka no nome do fornecedor e vê detalhes' do
    supplier = Supplier.create!(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")

    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Bugigangas SA'

    expect(current_path).to eq supplier_path(id: supplier.id)
    expect(page).to have_content "Bugigangas SA"
    expect(page).to have_content "Nome Fantasia: Play Bugigangas"
    expect(page).to have_content "CNPJ: 123456789000"
    expect(page).to have_content "Endereço: Avenida Tomaz Espindola, 10"
    expect(page).to have_content "Cidade: Maceió"
    expect(page).to have_content "Estado: AL"
    expect(page).to have_content "Email: Bugiganas_SA@sac.com.br"
  end

  it 'e clicka em voltar para pagina de fornecedores' do
    supplier = Supplier.create!(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")

    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Bugigangas SA'
    click_on 'Voltar para fornecedores'

    expect(current_path).to eq suppliers_path
  end

  it 'e clicka em voltar para tela inicial' do
    supplier = Supplier.create!(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")

    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Bugigangas SA'
    click_on 'Voltar para página principal'

    expect(current_path).to eq root_path
  end
end