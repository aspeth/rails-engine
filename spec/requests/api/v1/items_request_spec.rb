require 'rails_helper'

RSpec.describe "Item API requests" do
  it "gets all items" do
    id_1 = create(:merchant).id
    id_2 = create(:merchant).id
    items_1 = create_list(:item, 10, merchant_id: id_1)
    items_2 = create_list(:item, 5, merchant_id: id_2)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(15)

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

  it "gets one item" do
    merchant_id = create(:merchant).id
    id = create(:item, merchant_id: merchant_id).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq(1)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
  end

  it "can create items" do
    merchant_id = create(:merchant).id

    item_params = {
      name: 'Headphones',
      description: 'good for music',
      unit_price: 10.1,
      merchant_id: merchant_id
    }

    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to be_successful

    new_item = Item.last

    expect(new_item.name).to eq(item_params[:name])
    expect(new_item.description).to eq(item_params[:description])
    expect(new_item.unit_price).to eq(item_params[:unit_price])
    expect(new_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can edit items" do
    merchant_id = create(:merchant).id

    item_params = {
      name: 'Headphones',
      description: 'good for music',
      unit_price: 10.1,
      merchant_id: merchant_id
    }

    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to be_successful

    new_item = Item.last

    expect(new_item.name).to eq(item_params[:name])
    expect(new_item.description).to eq(item_params[:description])
    expect(new_item.unit_price).to eq(item_params[:unit_price])
    expect(new_item.merchant_id).to eq(item_params[:merchant_id])

    new_item_params = {
      name: 'Glasses',
      description: 'good for seeing',
      unit_price: 21.2,
      merchant_id: merchant_id
    }

    headers = {"CONTENT_TYPE" => "application/json"}
    patch "/api/v1/items/#{new_item.id}", headers: headers, params: JSON.generate(item: new_item_params)

    updated_item = Item.last

    expect(updated_item.name).to eq(new_item_params[:name])
    expect(updated_item.description).to eq(new_item_params[:description])
    expect(updated_item.unit_price).to eq(new_item_params[:unit_price])
    expect(updated_item.merchant_id).to eq(new_item_params[:merchant_id])
  end

  it "can get an item's merchant" do
    merchant = create(:merchant)

    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    found_merchant = JSON.parse(response.body, symbolize_names: true)

    expect(found_merchant.count).to eq(1)
    expect(found_merchant[:data][:attributes][:name]).to eq(merchant.name)
  end

  it "returns 404 if item not found" do
    get "/api/v1/items/1234567/merchant"
    expect(response.status).to eq(404)
    
    get "/api/v1/items/1234567"
    expect(response.status).to eq(404)
    
    get "/api/v1/items"
    expect(response.status).to eq(404)
  end

  it "can find all items by name" do
    merchant_1 = create(:merchant, name: "Rubber Ducky, LLC")

    item_1 = create(:item, name: "Yellow Duck", merchant_id: merchant_1.id)
    item_2 = create(:item, name: "Blue Duck", merchant_id: merchant_1.id)
    item_3 = create(:item, name: "Duck Pirate", merchant_id: merchant_1.id)

    get "/api/v1/items/find_all?name=duck"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
  end
end