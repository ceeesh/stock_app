class UserStock < ApplicationRecord
    belongs_to :user 
    has_many :transactions

    validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}
    attribute :quantity, default: 0
end
