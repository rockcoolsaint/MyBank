class AccountsController < ApplicationController

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
		
	end

	def update
		
	end

	def destroy
		
	end

	private

		def account_params
			params.require(:account).permit(:acc_type, :acc_balance)
		end
end
