require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'validates' do
    it 'deve retornar falso, quando corporate name está em branco' do
      supplier = Supplier.new(corporate_name: "", brand_name: "Play Bugigangas", registration_number: "35.006.222/0001-57", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end
    
    it 'deve retornar falso, quando brand_name está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "", registration_number: "35.006.222/0001-57", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end
    
    it 'deve retornar falso, quando registration_number está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end
    
    it 'deve retornar falso, quando full_addres está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "35.006.222/0001-57", full_address: "",
                              city: "Maceió", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end

    it 'deve retornar falso, quando a cidade está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "35.006.222/0001-57", full_address: "Avenida Tomaz Espindola, 10",
                              city: "", state: "AL", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end

    it 'deve retornar falso quando o estado está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "35.006.222/0001-57", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "", email: "Bugiganas_SA@sac.com.br")
      expect(supplier.valid?).to be_falsy
    end

    it 'deve retornar falso quando o email está em branco' do
      supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "35.006.222/0001-57", full_address: "Avenida Tomaz Espindola, 10",
                              city: "Maceió", state: "AL", email: "")
      expect(supplier.valid?).to be_falsy
    end

    context 'state length' do
      it 'should return false, when the state length is not 2' do
        supplier = Supplier.new(corporate_name: "Bugigangas SA", brand_name: "Play Bugigangas", registration_number: "35.006.222/0001-57", full_address: "Avenida Tomaz Espindola, 10",
                                city: "Maceió", state: "ALAGOAS", email: "")
        expect(supplier.valid?).to be_falsy
        end
      end
  end 
end
