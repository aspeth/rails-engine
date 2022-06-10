class Transaction < ApplicationRecord
  has_many :merchants, through: :invoices
end