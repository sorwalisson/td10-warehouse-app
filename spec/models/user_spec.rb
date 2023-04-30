require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'description' do
    it 'mostra o nome mais email' do
      #arrange
      new_user = User.new(name: "Julia Almeida", email: 'Julia@email.com', password: "password")
      #act
      result = new_user.description
      #assert
      expect(result).to eq('Julia Almeida - Julia@email.com')
    end
  end
end
