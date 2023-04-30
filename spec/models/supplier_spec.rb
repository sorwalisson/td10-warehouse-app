require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'validates' do
    it 'deve retornar falso, quando corporate name está em branco' do
      supplier = Supplier.new(corporate_name: "", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end
    
    it 'deve retornar falso, quando brand_name está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end
    
    it 'deve retornar falso, quando registration_number está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end
    
    it 'deve retornar falso, quando full_addres está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "",
                              city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end

    it 'deve retornar falso, quando a cidade está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                              city: "", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end

    it 'deve retornar falso quando o estado está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end

    it 'deve retornar falso quando o email está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "AL", email: "")
      expect(supplier.valid?).to be_falsy
    end

    context 'state length' do
      it 'should return false, when the state length is not 2' do
        supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "123456789000", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "ALAGOAS", email: "Bugiganas_SA@sac.com.br")
        expect(supplier.valid?).to be_falsy
      end
    end

    context 'CNPJ length' do
      it 'deve retornar false se o CNPJ length n for 12' do
        supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "35007", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
        expect(supplier.valid?).to be_falsy
      end
    end

    context 'CNPJ uniqueness' do
      it 'deve retornar falso se o CNPJ n for único' do
        supplier = Supplier.create!(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "350062220001", full_address: "Avenida Tomaz Espindola, 10",
          city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
        second_supplier = Supplier.new(corporate_name: "Bugi SA", brand_name: "Bugigangas", registration_number: "350062220001", full_address: "Avenida Amelia Rosa, 10",
            city: "Maceió", state: "AL", email: "Bugiganas@sac.com.br")
        expect(second_supplier.valid?).to be_falsy
      end
    end
  end
  
  describe 'full description' do
    it 'deve retonar razão social mais nome fantasia' do
      #arrange
      supplier = Supplier.create!(corporate_name: 'Samsung korea LTDA', brand_name: 'SAMSUNG', registration_number: "123456789000", 
                                  full_address: "Avenida itapuã, 35", city: "São Paulo", state: "SP", email: "samsung@sac.com.br")
      
      #act
      result = supplier.full_description

      #assert

      expect(result).to eq('Samsung korea LTDA - SAMSUNG')
    end
  end
end
