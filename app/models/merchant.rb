class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :items

  def self.top_merchants_by_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .group(:id)
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .order(revenue: :desc)
    .limit(quantity)
  end

  def self.most_items(quantity)
    # require 'pry'; binding.pry
  end
end
