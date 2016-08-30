class AccountsController < ApplicationController
	def show
		@account = current_customer.accounts.build
		@transact = current_customer.accounts.build
		current_account = Account.find(params[:id])
		@account_balance = current_account.acc_balance
	end

	def new

	end

	def create
		@account = customer.accounts.build(account_params)
		if @account.save
			flash[:success] = "Account successfully created!"
			redirect_to @customer
		else
			flash[:danger] = "Account creation failed!"
			redirect_to @customer
		end
	end

	def edit
		@title = "Transaction"
		@account = current_customer.accounts.find(params[:id])
		@account_balance = @account.acc_balance
	end

	def update
		@account = Account.find(params[:id])
		account_balance = @account.acc_balance
		@amount = params[:account][:amount].to_i
		if params[:commit] == "Withdraw"
			account_balance -= @amount
			if @account.update_attribute(:acc_balance, account_balance)
				flash.now[:success] = "Withdrawal of N#{@amount} successful"
      			render 'edit'
      		else
      			flash.now[:danger] = "Oops! Withdrawal failed!"
      			render 'edit'
      		end
      	else
      		account_balance += @amount
			if @account.update_attribute(:acc_balance, account_balance)
				flash.now[:success] = "Deposit of N#{@amount} successful"
      			render 'edit'
      		else
      			flash.now[:danger] = "Oops! Withdrawal failed!"
      			render 'edit'
      		end
      	end
	end

	def deposit
		
	end

	private

		def account_params
			params.require(:account).permit(:acc_type, :acc_balance)
		end
end
