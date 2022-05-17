class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    merchant = Merchant.find(params[:item][:merchant_id])
    merchant.items.create!(item_params)
  end

  private

  def item_params
    params[:item].permit(:name, :description, :unit_price, :merchant_id)
  end
end