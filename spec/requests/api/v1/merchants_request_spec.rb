require 'rails_helper'

RSpec.describe "Merchant API requests" do
  it "gets all merchants" do
    create_list(:merchant, 5)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(merchants.count).to eq(5)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "finds one merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)
    
    expect(merchant.count).to eq(1)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "finds one merchant's items" do
    id = create(:merchant).id
    items = create_list(:item, 10, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(10)
    
    items.each do |item|
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "returns 404 if merchant not found" do
    get "/api/v1/merchants/1234567/items"
    expect(response.status).to eq(404)
    
    get "/api/v1/merchants/1234567"
    expect(response.status).to eq(404)
    
    get "/api/v1/merchants"
    expect(response.status).to eq(404)
  end

  it "can find merchants by searching with query params" do
    merchant_1 = create(:merchant, name: "Rubber Ducky, LLC")
    merchant_2 = create(:merchant, name: "Pen Store")

    get "/api/v1/merchants/find?name=ducky"

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant[:attributes][:name]).to eq(merchant_1.name)
  end
  
  it "returns a message if no match found" do
    merchant_1 = create(:merchant, name: "Rubber Ducky, LLC")
    merchant_2 = create(:merchant, name: "Pen Store")

    get "/api/v1/merchants/find?name=squiggly_piggly"

    message = JSON.parse(response.body, symbolize_names: true)
    expect(message).to have_key(:data)
    expect(message[:data][:message]).to eq("No match found")
  end

  it "finds all merchants by name fragment" do
    merchant_1 = create(:merchant, name: "Rubber Ducky, LLC")
    merchant_2 = create(:merchant, name: "Ducks Inc.")
    merchant_3 = create(:merchant, name: "The Duck Store")
    merchant_4 = create(:merchant, name: "A Different Store")

    get "/api/v1/merchants/find_all?name=dU"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end