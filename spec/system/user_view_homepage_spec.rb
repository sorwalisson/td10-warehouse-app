require 'rails_helper'

describe "Users visits the homepage" do
  it "and see the name of the app" do
    # Arrange

    #Act
    visit("/")

    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end
end