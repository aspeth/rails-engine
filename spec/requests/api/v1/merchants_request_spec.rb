require 'rails_helper'

RSpec.describe "Merchant API requests" do
  it "gets all merchants" do
    create_list(:merchant, 5)

    get "/api/v1/merchants"

    expect(response).to be_successful
  end
end