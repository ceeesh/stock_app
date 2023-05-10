class PortfolioController < ApplicationController

    def index
        @user_stocks = current_user.user_stocks
        @user = current_user

        @transactions = current_user.transactions
    end
    
end