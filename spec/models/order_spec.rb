require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'gera um código aleatório' do
    it 'ao criar novo pedido' do
      #arrange
      new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                    cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
      order = Order.new(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: 1.day.from_now)
      #act
      order.save!
      result = order.code
      #assert
      expect(result).to_not be_nil
      expect(result.length).to eq 10
    end
    it 'e o código é único' do
      #arrange
      new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                    full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                      cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
      order = Order.create!(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: 1.day.from_now)
      second_order = Order.new(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: 1.day.from_now)
      #act
      second_order.save!
      #assert
      expect(second_order.code).to_not eq order.code
    end
  end

  describe 'valid?' do
    it 'deve ter um código' do
      new_user = User.create!(name: "Walisson", email: "sorwalisson@email.com", password: "password")
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      warehouse = Warehouse.create!(name: "Aeroporto SP", code: "GRU", city: "Guarulhos", area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                    cep: '15000-000', description: 'Galpão destinado a encomendas internacionais.')
      order = Order.new(user_id: new_user.id, warehouse_id: warehouse.id, supplier_id: supplier.id, estimated_delivery_date: 1.day.from_now)

      result = order.valid?

      expect(result).to be true
    end

    it 'data deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: '')
      
      order.valid?
      
      expect(order.errors.include? :estimated_delivery_date).to be true
    end

    it 'data estimada de entega não deve esta no passado' do
      #arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)
      #act
      order.valid?
      #assert
      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser futura.")
    end

    it 'data estimada de entega não deve ser igual a hoje' do
      #arrange
      order = Order.new(estimated_delivery_date: Date.today)
      #act
      order.valid?
      #assert
      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser futura.")
    end

    it 'data deve estar no futuro' do
      #arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      #act
      order.valid?
      #assert
      expect(order.errors.include? :estimated_delivery_date).to be false
    end
  end
end
