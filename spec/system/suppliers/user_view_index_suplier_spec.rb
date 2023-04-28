require 'rails_helper'

describe 'usuário clicka em fornecedores e vai para index de fornecedor' do
  it 'a partir da nav bar' do
    visit root_path
    click_on 'Fornecedores'

    expect(current_path).to eq suppliers_path
  end

  it 'e vê os forncedores cadastrados' do
    Supplier.create!(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "35.006.222/0001-57", full_address: "Avenida Tomaz Espindola, 10",
                    city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
    
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    expect(page).to have_content 'Bugigangas SA'
    expect(page).to have_content 'Play Bugigangas'
    expect(page).to have_content '35.006.222/0001-57'
  end

  it 'vê mensagem não existem forncedores cadastrados, quando suppliers está vazio.' do

    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    expect(page).to have_content 'Não há forncedores cadastrados'
  end
end
