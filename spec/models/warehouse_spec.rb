require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe 'valid?' do
    it 'false when name is empty' do
      #arrange
      warehouse = Warehouse.new(name: '', code: 'RIO', address: 'algumaruaae', cep: '25000-000', city: 'Rio de Janeiro', area: 15000, description: 'alguma desgrição')
      #act
      result = warehouse.valid?
      #assert
      expect(result).to be_falsy
    end

    it 'false when code is empty' do
      #arrange
      warehouse = Warehouse.new(name: 'RIO', code: '', address: 'algumaruaae', cep: '25000-000', city: 'Rio de Janeiro', area: 15000, description: 'alguma desgrição')
      #act
      result = warehouse.valid?
      #assert
      expect(result).to be_falsy
    end

    it 'false when address is empty' do
      #arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', cep: '25000-000', city: 'Rio de Janeiro', area: 15000, description: 'alguma desgrição')
      #act
      result = warehouse.valid?
      #assert
      expect(result).to be_falsy
    end

    it 'false when cep is empty' do
      #arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'algumaruaae', cep: '', city: 'Rio de Janeiro', area: 15000, description: 'alguma desgrição')
      #act
      result = warehouse.valid?
      #assert
      expect(result).to be_falsy
    end

    it 'false when city is empty' do
      #arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'algumaruaae', cep: '25000-000', city: '', area: 15000, description: 'alguma desgrição')
      #act
      result = warehouse.valid?
      #assert
      expect(result).to be_falsy
    end

    it 'false when area is empty' do
      #arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'algumaruaae', cep: '25000-000', city: 'Rio de Janeiro', area: '' , description: 'alguma desgrição')
      #act
      result = warehouse.valid?
      #assert
      expect(result).to be_falsy
    end

    it 'false when description is empty' do
      #arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'algumaruaae', cep: '25000-000', city: 'Rio de Janeiro', area: 15000, description: '')
      #act
      result = warehouse.valid?
      #assert
      expect(result).to be_falsy
    end

    context 'unique' do
      it 'false when the code is not unique' do
        #arrange
        first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'algumaruaae', 
                                        cep: '25000-000', city: 'Rio de Janeiro', area: 15000, 
                                        description: 'alguma desgrição')
        second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'rua', 
                                        cep: '35000-000', city: 'Rio de Janeiro', area: 25000, 
                                        description: 'alguma')
        #act
        result = second_warehouse.valid?
        #assert
        expect(result).to be_falsy
      end
    end
  end
end
