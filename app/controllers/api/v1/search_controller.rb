class Api::V1::SearchController < ApplicationController
  def merchant
    merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}%").first
    if merchant.nil?
      render json: { data: { message: "No match found" } }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end

  def all_items
    items = Item.where("name ilike ?", "%#{params[:name]}%")
    render json: ItemSerializer.new(items)
  end

  def all_merchants
    merchants = Merchant.where("name ILIKE ?", "%#{params[:name]}%")
    render json: MerchantSerializer.new(merchants)
  end
end