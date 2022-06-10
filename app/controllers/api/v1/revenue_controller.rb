class Api::V1::RevenueController < ApplicationController
  def merchants
    if params[:quantity].nil?
      render status: 400
    else
      render json: RevenueSerializer.new(Merchant.top_merchants_by_revenue(params[:quantity]))
    end
  end
end