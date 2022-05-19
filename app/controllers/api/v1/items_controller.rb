class Api::V1::ItemsController < ApplicationController
  def index
    if !Item.all.empty?
      items = Item.all
      render json: ItemSerializer.new(items)
    else
      render status: 404
    end
  end

  def show
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      render json: ItemSerializer.new(item)
    else
      render status: 404
    end
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

  def destroy
    item = Item.find(params[:id])
    item.invoices.each do |invoice|
      if invoice.items.count == 1
        invoice.destroy
      end
    end
    item.destroy
  end

  private

  def item_params
    params[:item].permit(:name, :description, :unit_price, :merchant_id)
  end
end