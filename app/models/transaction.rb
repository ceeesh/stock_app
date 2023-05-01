class Transaction < ApplicationRecord
    belongs_to :user
    enum kind: [ :buy, :sell ]

    validates :kind, :quantity, :price, :quantity, presence: true
    validates :quantity, numericality: {greater_than: 0}

    def total_price
        self.quantity.to_d * self.price.to_d
    end
    
    def calculate_new_quantity(user_stock_quantity)
        if self.buy?
            user_stock_quantity + self.quantity
        else
            user_stock_quantity - self.quantity
        end
    end

    
end
