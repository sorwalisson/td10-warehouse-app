require 'rails_helper'

describe 'Usuário adiciona items ao pedido' do
  it 'com sucesso' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_a = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                         sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    second_b = ProductModel.create!(name: "Sound System 7.1", weight: 5000, width: 50, height: 35, depth: 15, 
                                          sku: "SOUSYS-SAMSUG-SPT080", supplier_id: supplier.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)

    #act
    login_as(new_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'TV 32', from: 'Produto'
    fill_in 'Quantidade', with: 8
    click_on 'Gravar'

    #assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Os itens foram adicionados com sucesso."
    expect(OrderItem.first.product_model_id).to eq product_a.id
    expect(page).to have_content "Quantidade: 8 x TV 32"
  end

  it 'não vê produtos de outros fornecedores' do
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    supplier_2 = Supplier.create!(corporate_name: 'SAMSUNG FALSA', brand_name: 'SAMSUNG FALSA', registration_number: "123456789111", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    product_a = ProductModel.create!(name: "TV 32", weight: 8000, width: 70, height: 45, depth: 10, 
                                        sku: "TV32PL-SAMSUG-XPT090", supplier_id: supplier.id)
    product_b = ProductModel.create!(name: "Sound System 7.1", weight: 5000, width: 50, height: 35, depth: 15, 
                                          sku: "SOUSYS-SAMSUG-SPT080", supplier_id: supplier_2.id)
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)

    login_as(new_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content product_a.name
    expect(page).to_not have_content product_b.name
  end
end