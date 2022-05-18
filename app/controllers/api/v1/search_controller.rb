class Api::V1::SearchController < ApplicationController
  def show
    merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}%").first
    if merchant.nil?
      render json: { data: { message: "No match found" } }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end