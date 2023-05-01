require 'rails_helper'

describe 'usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)
    #act
    login_as(new_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'
    #assert
    expect(current_path).to eq order_path(id: order.id)
    expect(page).to have_content "Status do Pedido atualizado com sucesso."
    expect(page).to have_content("Situação do pedido: Entregue")
    expect(page).to_not have_button('Marcar como ENTREGUE')
    expect(page).to_not have_button('Marcar como CANCELADO')
  end

  it 'e pedido cancelado' do
    #arrange
    new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
    supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
    warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
    date = 1.day.from_now
    order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: date.strftime("%d/%m/%Y"), status: :pending)
    #act
    login_as(new_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'
    #assert
    expect(current_path).to eq order_path(id: order.id)
    expect(page).to have_content "Status do Pedido atualizado com sucesso."
    expect(page).to have_content("Situação do pedido: Cancelado")
    expect(page).to_not have_button('Marcar como ENTREGUE')
    expect(page).to_not have_button('Marcar como CANCELADO')
  end
end