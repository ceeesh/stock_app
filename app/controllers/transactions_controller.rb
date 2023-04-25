class TransactionsController < ApplicationController

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

    # post buy stock
    def buy
        @user_stock = current_user.user_stocks.find_by(:symbol => params[:symbol])
        if @user_stock.nil?
            @user_stock = current_user.user_stocks.create(symbol: buy_params[:symbol], company_name: buy_params[:company_name], :quantity => 0)
        else
            if !current_user.nil?
                if current_user.balance > (buy_params[:quantity].to_d * buy_params[:price].to_d)
                    @transaction = Transaction.new(set_transactions)
                    @transaction.update!(user_id: current_user.id)
                    if @transaction.save! && @user_stock.update(:quantity => @user_stock.quantity + buy_params[:quantity].to_d)
                        current_user.update!(:balance => current_user.balance - (buy_params[:quantity].to_d * buy_params[:price].to_d) )
                        redirect_to root_path
                    else
                        redirect_to transactions_buy_path(params[:symbol])
                    end
                else
                    redirect_to transactions_buy_path(params[:symbol]), notice: "Not enough balance."
                end
            end
        end
    end

    # post sell stock
    def sell
        @user_stock = current_user.user_stocks.find_by(:symbol => params[:symbol])
        if @user_stock.nil?
            redirect_to transactions_sell_path(params[:symbol]), notice: "You don't own this stock"
            # @user_stock = current_user.user_stocks.create(symbol: buy_params[:symbol], company_name: buy_params[:company_name], :quantity => 0)
        else

            if !current_user.nil?
                if @user_stock.quantity.to_d <= 0 || @user_stock.quantity.to_d < buy_params[:quantity].to_d
                    redirect_to transactions_sell_path(params[:symbol])
                else
                    @transaction = Transaction.new(set_transactions)
                    @transaction.update!(user_id: current_user.id)
                        if @transaction.save! && @user_stock.update(:quantity => @user_stock.quantity - buy_params[:quantity].to_d)
                            current_user.update!(:balance => current_user.balance + (buy_params[:quantity].to_d * buy_params[:price].to_d))
                            redirect_to root_path
                        else
                            redirect_to transactions_sell_path(params[:symbol])
                        end
                end
            end
     end
    end
    
    private

    def buy_params
        params.require(:transaction).permit(:symbol, :company_name, :price, :quantity)
    end

    def set_stock
        @stock = Transaction.find_by(symbol: params[:symbol], company_name: params[:company_name], quantity: params[:quantity])
    end

    def set_transactions
       params.require(:transaction).permit(:symbol, :price, :quantity)
    end

end