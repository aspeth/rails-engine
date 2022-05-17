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
    item = merchant.items.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
    end
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
    else
      render status: 404
    end
  end

  private

  def item_params
    params[:item].permit(:name, :description, :unit_price, :merchant_id)
  end
end