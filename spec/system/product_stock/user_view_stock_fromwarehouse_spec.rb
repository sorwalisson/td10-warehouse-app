require 'rails_helper'

describe 'Usuário vê o stock' do
  it 'na tela do galoão' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_a = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                        sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    product_b = ProductModel.create!(name: "Sound System 7.1", weight: 5000, width: 50, height: 35, depth: 15, 
                                          sku: "SOUSYS-SAMSUG-SPT080", supplier_id: supplier.id)
    product_c = ProductModel.create!(name: "Samsung Galaxy A50", weight: 200, width: 40, height: 30, depth: 10, 
                                     sku: "SAMGLX-SAMSUG-UHP080", supplier_id: supplier.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)
    3.times {StockProduct.create!(order_id: order.id, warehouse_id: warehouse.id, product_model_id: product_a.id)}
    2.times {StockProduct.create!(order_id: order.id, warehouse_id: warehouse.id, product_model_id: product_b.id)}

    login_as(new_user)
    visit root_path
    click_on 'Aeroporto SP'

    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x TV 32'
    expect(page).to have_content '2 x Sound System 7.1'
    expect(page).to_not have_content 'Samsung Galaxy A50'
  end

  it 'e da baixa em um item' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_a = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                        sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    product_b = ProductModel.create!(name: "Sound System 7.1", weight: 5000, width: 50, height: 35, depth: 15, 
                                          sku: "SOUSYS-SAMSUG-SPT080", supplier_id: supplier.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)
    3.times {StockProduct.create!(order_id: order.id, warehouse_id: warehouse.id, product_model_id: product_a.id)}
    2.times {StockProduct.create!(order_id: order.id, warehouse_id: warehouse.id, product_model_id: product_b.id)}

    login_as(new_user)
    visit root_path
    click_on 'Aeroporto SP'
    select 'TV 32', from: "Item para Saída"
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: "Rua Alecrim Dourado, 55 - Porto Velho - Espírito Santo"
    click_on "Gravar"

    expect(current_path).to eq warehouse_path(id: warehouse.id)
    expect(page).to have_content "Item retirado com sucesso."
    expect(page).to have_content "2 x TV 32"
    expect(page).to have_content '2 x Sound System 7.1'
  end
end