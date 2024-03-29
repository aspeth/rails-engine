class Api::V1::MerchantsController < ApplicationController
  def index
    if !Merchant.all.empty?
      merchants = Merchant.all
      render json: MerchantSerializer.new(merchants)
    else
      render status: 404
    end
  end

  def show
    if Merchant.exists?(params[:id])
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(merchant)
    else
      render status: 404
    end
  end

  def most_items
    render json: MerchantSerializer.new(Merchant.most_items(params[:quantity]))
  end
end