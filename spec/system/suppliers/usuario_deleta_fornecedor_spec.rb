require 'rails_helper'

describe 'usuário exclui fornecedor' do
  it 'com sucesso' do
    supplier = Supplier.create!(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")

    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Bugigangas SA'
    click_on 'Remover'

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor deletado com sucesso.'
    expect(page).to_not have_content 'Bugigangas SA'
    expect(page).to_not have_content 'Play Bugigangas'
    expect(page).to_not have_content '123456789000'
  end
end