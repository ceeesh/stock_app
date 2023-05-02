class TransactionsController < ApplicationController
    before_action :set_stock

    def index
        @transactions = current_user.transactions
    end

    # get buy stock
    def buy_stock
        @user = current_user
        @transaction = Transaction.new
        @quote = IEX_CLIENT.quote(params[:symbol])
    end

    # get sell stock
    def sell_stock
        @user = current_user
        @transaction = Transaction.new
        @quote = IEX_CLIENT.quote(params[:symbol])
    end

    def save_transaction
      @transaction = current_user.transactions.create(set_transactions)
      @transaction.amount = @transaction.total_price

      @user_stock = current_user.user_stocks.find_or_create_by(symbol: buy_params[:symbol], company_name: buy_params[:company_name])
      updated_quantity = @transaction.calculate_new_quantity(@user_stock.quantity)

      if @transaction.save && @user_stock.update(quantity: updated_quantity)
        current_user.update!(:balance => current_user.balance - @transaction.amount )
        redirect_to root_path
      else
        if @transaction.buy?
            redirect_to transactions_buy_path
        else
            redirect_to transactions_sell_path
        end
      end
    
    end


    
    private

    def buy_params
        params.require(:transaction).permit(:symbol, :company_name, :price, :quantity)
    end

    def set_stock
        @stock = UserStock.find_by(symbol: params[:symbol], company_name: params[:company_name], quantity: params[:quantity])
    end

    def set_transactions
       params.require(:transaction).permit(:symbol, :price, :quantity, :kind)
    end

end