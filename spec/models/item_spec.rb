require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }
end
