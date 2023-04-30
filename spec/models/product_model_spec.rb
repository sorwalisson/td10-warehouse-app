require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe 'Validates' do
    it 'deve retornar falso se nome do modelo de produto estiver em branco' do
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      product_model = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, sku: "TV32-SAMSU-XPT090", supplier_id: supplier.id)
      
      expect(product_model.valid?).to be_falsy
    end

    it 'deve retornar falso se peso estiver em branco' do
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      product_model = ProductModel.new(name: 'TV 32', width: 70, height: 45, depth: 10, sku: "TV32-SAMSU-XPT090", supplier_id: supplier.id)
      
      expect(product_model.valid?).to be_falsy
    end

    it 'deve retornar falso se largura estiver em branco' do
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      product_model = ProductModel.new(name: 'TV 32', weight: 8000 , height: 45, depth: 10, sku: "TV32-SAMSU-XPT090", supplier_id: supplier.id)
      
      expect(product_model.valid?).to be_falsy
    end

    it 'deve retornar falso se altura estiver em branco' do
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, depth: 10, sku: "TV32-SAMSU-XPT090", supplier_id: supplier.id)
      
      expect(product_model.valid?).to be_falsy
    end

    it 'deve retornar falso se profundidade estiver em branco' do
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, sku: "TV32-SAMSU-XPT090", supplier_id: supplier.id)
      
      expect(product_model.valid?).to be_falsy
    end

    it 'deve retornar falso se sku estiver em branco' do
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, supplier_id: supplier.id)
      
      expect(product_model.valid?).to be_falsy
    end

    context 'validates length' do
      it 'SKU deve ter 20 caracteres' do
        supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                    full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
        product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: "TV3222-XM142-SAMTV1", supplier_id: supplier.id)

        expect(product_model.valid?).to be_falsy
      end
    end

    context 'validates uniqueness' do
      it 'SKU must be unique' do
        supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                    full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
        product_model = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: "TV3222-XM1422-SAMTV1", supplier_id: supplier.id)
        second_product_model = ProductModel.new(name: 'TV 40', weight: 9000, width: 30, height: 45, depth: 10, sku: "TV3222-XM1422-SAMTV1", supplier_id: supplier.id)

        expect(second_product_model.valid?).to be_falsy
      end
    end

    context 'validates comparison' do
      it 'peso deve ser maior que 0' do
        supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                    full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
        product_model = ProductModel.new(name: 'TV 32', width: 70, height: 45, depth: 10, sku: "TV3222-XM1422-SAMTV1", supplier_id: supplier.id)
        
        expect(product_model.valid?).to be_falsy
      end

      it 'largura deve ser maior que 0' do
        supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                    full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
        product_model = ProductModel.new(name: 'TV 32', weight: 8000, height: 45, depth: 10, sku: "TV3222-XM1422-SAMTV1", supplier_id: supplier.id)
        
        expect(product_model.valid?).to be_falsy
      end

      it 'altura deve ser maior que 0' do
        supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                    full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
        product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, depth: 10, sku: "TV3222-XM1422-SAMTV1", supplier_id: supplier.id)
        
        expect(product_model.valid?).to be_falsy
      end

      it 'profundidade deve ser maior que 0' do
        supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
                                    full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
        product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, sku: "TV3222-XM1422-SAMTV1", supplier_id: supplier.id)
        
        expect(product_model.valid?).to be_falsy
      end
    end        
  end

  describe 'dimensions' do
    it 'deve retornar uma string com as dimensões' do
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'Samsung', registration_number: "123456789000", 
        full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: "TV3222-XM1422-SAMTV1", supplier_id: supplier.id)

      result = product_model.dimensions

      expect(result).to eq "70cm x 45cm x 10cm"
    end
  end
end
